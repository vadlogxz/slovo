import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';
import 'package:slovo/feature/vocabulary/domain/repositories/word_repository.dart';

class FirebaseWordRepository implements WordRepository {
  FirebaseWordRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _userCollectionsReference(
    String userId,
  ) => _firestore.collection('users').doc(userId).collection('collections');

  @override
  Future<void> addWordToCollections({
    required String userId,
    required DictionaryEntry entry,
    required List<String> collectionIds,
  }) async {
    final batch = _firestore.batch();
    for (var collectionId in collectionIds) {
      final docRef = _userCollectionsReference(
        userId,
      ).doc(collectionId).collection('words').doc(entry.id);
      final word = entry.toWord(wordId: entry.id, collectionId: collectionId);
      if(word == null) {
        throw Exception('Failed to convert DictionaryEntry to Word for collectionId: $collectionId');
      }
      batch.set(docRef, word.toJson());
    }
    await batch.commit();
  }
}
