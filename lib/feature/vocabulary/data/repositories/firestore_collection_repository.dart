import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slovo/core/error/firestore_error_handling.dart';
import 'package:slovo/core/error/repository_exception.dart';
import 'package:slovo/core/firestore/firestore_field_parsing.dart';
import 'package:slovo/core/firestore/firestore_paths.dart';
import 'package:slovo/core/firestore/firestore_query_streaming.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection_color.dart';
import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';
import 'package:slovo/feature/vocabulary/domain/repositories/collection_repository.dart';

// Collection and Word are pure-Dart domain models (per architecture.md), so
// their Firestore (de)serialization — which needs the Timestamp type — lives
// here in the data layer instead of on the models themselves.
Collection _collectionFromFirestore(String id, Map<String, dynamic> data) {
  return Collection(
    id: id,
    ownerId: data['ownerId'] as String,
    title: data['title'] as String,
    description: data['description'] as String?,
    color: CollectionColor.fromString(data['color'] as String?),
    isPublic: data['isPublic'] as bool? ?? false,
    wordCount: intOrDefault(data, 'wordCount'),
    wordsLearned: intOrDefault(data, 'wordsLearned'),
    language: data['language'] as String? ?? 'de',
    tags: List<String>.from(data['tags'] as List? ?? []),
    lastStudiedAt: (data['lastStudiedAt'] as Timestamp?)?.toDate(),
    // Optimistic local-cache writes resolve serverTimestamp() to null
    // until the server ack arrives — fall back rather than crash.
    createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
  );
}

Map<String, dynamic> _collectionToFirestore(Collection collection) => {
  'ownerId': collection.ownerId,
  'title': collection.title,
  if (collection.description != null) 'description': collection.description,
  'color': collection.color.name,
  'isPublic': collection.isPublic,
  'wordCount': collection.wordCount,
  'wordsLearned': collection.wordsLearned,
  'language': collection.language,
  'tags': collection.tags,
  if (collection.lastStudiedAt != null)
    'lastStudiedAt': Timestamp.fromDate(collection.lastStudiedAt!),
  'createdAt': Timestamp.fromDate(collection.createdAt),
  'updatedAt': Timestamp.fromDate(collection.updatedAt),
};

Word _wordFromFirestore(
  String id,
  String collectionId,
  Map<String, dynamic> data,
) {
  return Word(
    id: id,
    collectionId: collectionId,
    term: data['term'] as String,
    linguistics: WordLinguistics.fromMap(data),
    // Optimistic local-cache writes resolve serverTimestamp() to null
    // until the server ack arrives — fall back rather than crash.
    createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    dictionaryEntryId: data['dictionaryEntryId'] as String?,
  );
}

Map<String, dynamic> _wordToFirestore(Word word) => {
  'term': word.term,
  ...word.linguistics.toMap(),
  if (word.dictionaryEntryId != null)
    'dictionaryEntryId': word.dictionaryEntryId,
  'createdAt': Timestamp.fromDate(word.createdAt),
};

class FirestoreCollectionRepository implements CollectionRepository {
  FirestoreCollectionRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _collectionsRef(String userId) =>
      _firestore.userCollectionsRef(userId);

  // Single source of truth for the words subcollection path.
  CollectionReference<Map<String, dynamic>> _wordsRef(
    String userId,
    String collectionId,
  ) => _collectionsRef(userId).doc(collectionId).collection('words');

  @override
  Stream<List<Collection>> watchUserCollections(String userId) {
    return watchQueryAsList(
      _collectionsRef(userId).orderBy('createdAt', descending: true),
      _collectionFromFirestore,
    );
  }

  @override
  Stream<List<Word>> watchCollectionWords(String userId, String collectionId) {
    return watchQueryAsList(
      _wordsRef(userId, collectionId).orderBy('createdAt', descending: true),
      (id, data) => _wordFromFirestore(id, collectionId, data),
    );
  }

  @override
  Future<Collection> createCollection({
    required String userId,
    required String title,
    String? description,
    CollectionColor color = CollectionColor.violet,
    bool isPublic = false,
    String language = 'de',
    List<String> tags = const [],
  }) async {
    final ref = _collectionsRef(userId).doc();
    final now = DateTime.now();
    final created = Collection(
      id: ref.id,
      ownerId: userId,
      title: title,
      description: description,
      color: color,
      isPublic: isPublic,
      language: language,
      tags: tags,
      createdAt: now,
      updatedAt: now,
    );
    await wrapFirestoreErrors(() async {
      // Optimistic local model uses DateTime.now(); Firestore gets server timestamps.
      await ref.set({
        ..._collectionToFirestore(created),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
    return created;
  }

  @override
  Future<void> updateCollection(String uid, Collection collection) {
    return wrapFirestoreErrors(() async {
      await _collectionsRef(uid).doc(collection.id).update({
        ..._collectionToFirestore(collection),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  @override
  Future<Word> addWordToCollection({
    required String userId,
    required String collectionId,
    required DictionaryEntry entry,
  }) async {
    if (!entry.isReady) {
      throw RepositoryException(
        'Cannot add "${entry.term}": dictionary entry is not ready yet.',
      );
    }

    // wordId is deterministic (= the dictionary entry's own id), so re-adding
    // a term already in this collection resolves to the same doc instead of
    // depending on a separate existence query — see toWord's doc comment.
    final wordRef = _wordsRef(userId, collectionId).doc(entry.id);
    final word = entry.toWord(wordId: wordRef.id, collectionId: collectionId);
    if (word == null) {
      throw RepositoryException(
        'Cannot add "${entry.term}": dictionary entry has no linguistic data.',
      );
    }

    return wrapFirestoreErrors(() {
      // A transaction (not a batch) is required here: two concurrent calls
      // both racing a plain "query for existing doc, then write" would both
      // pass the existence check before either commit, creating a duplicate
      // Word doc and double-incrementing wordCount. The transaction makes
      // the read-then-write atomic, so Firestore retries the loser against
      // the winner's already-committed doc instead of letting both through.
      return _firestore.runTransaction<Word>((transaction) async {
        final existing = await transaction.get(wordRef);
        if (existing.exists) {
          return _wordFromFirestore(existing.id, collectionId, existing.data()!);
        }

        transaction.set(wordRef, {
          ..._wordToFirestore(word),
          'createdAt': FieldValue.serverTimestamp(),
        });
        // Atomically increment wordCount so it never falls out of sync.
        transaction.update(_collectionsRef(userId).doc(collectionId), {
          'wordCount': FieldValue.increment(1),
        });
        return word;
      });
    });
  }

  @override
  Future<void> deleteWordFromCollection({
    required String userId,
    required String collectionId,
    required String wordId,
  }) {
    return wrapFirestoreErrors(() async {
      final batch = _firestore.batch();
      batch.delete(_wordsRef(userId, collectionId).doc(wordId));
      // Atomically decrement wordCount so it never falls out of sync.
      batch.update(_collectionsRef(userId).doc(collectionId), {
        'wordCount': FieldValue.increment(-1),
      });
      await batch.commit();
    });
  }

  @override
  Future<void> deleteCollection(String uid, String collectionId) {
    return wrapFirestoreErrors(() async {
      // TODO(WordRepository): migrate to WordRepository.deleteAllInCollection
      // once that layer exists, so word-deletion logic lives in one place.
      await _deleteAllWords(uid, collectionId);
      await _collectionsRef(uid).doc(collectionId).delete();
    });
  }

  // Batch-deletes the entire words subcollection in pages of 400.
  // limit(400) leaves headroom for additional writes if the batch ever grows.
  // Firestore does not cascade-delete subcollections automatically.
  Future<void> _deleteAllWords(String uid, String collectionId) async {
    while (true) {
      final snapshot = await _wordsRef(uid, collectionId).limit(400).get();
      if (snapshot.docs.isEmpty) break;
      final writeBatch = _firestore.batch();
      for (final doc in snapshot.docs) {
        writeBatch.delete(doc.reference);
      }
      await writeBatch.commit();
      if (snapshot.docs.length < 400) break;
    }
  }
}
