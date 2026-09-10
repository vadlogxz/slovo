import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';
import 'package:slovo/feature/vocabulary/domain/repositories/word_repository.dart';

import '../../domain/models/word.dart';

class FirebaseWordRepository implements WordRepository {
  FirebaseWordRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _userWordsReference(
    String userId,
  ) => _firestore.collection('users').doc(userId).collection('words');

  @override
  Future<void> addWordToCollections({
    required String userId,
    required DictionaryEntry entry,
    required List<String> collectionIds,
  }) async {
    final batch = _firestore.batch();
    final docRef = _userWordsReference(userId).doc(entry.id);
    final word = entry.toWord(wordId: entry.id, collectionId: collectionIds);
    if (word == null) {
      throw Exception(
        'Failed to convert DictionaryEntry to Word for collectionIds: $collectionIds',
      );
    }
    // word.toJson() writes collectionIds as a plain list, which would
    // overwrite prior membership if this word already belongs to other
    // collections. Swap in arrayUnion so Firestore merges instead.
    final data = {
      ...word.toJson(),
      'collectionIds': FieldValue.arrayUnion(collectionIds),
    };
    batch.set(docRef, data, SetOptions(merge: true));
    await batch.commit();
  }

  @override
  Future<List<Word>> getAllWords({required String userId}) async {
    return await _userWordsReference(userId).get().then((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Word.fromJson(data, doc.id);
      }).toList();
    });
  }
}
