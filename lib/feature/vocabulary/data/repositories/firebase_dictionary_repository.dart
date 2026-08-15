import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slovo/core/logging/app_logger.dart';
import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';
import 'package:slovo/feature/vocabulary/domain/repositories/dictionary_repository.dart';

class FirebaseDictionaryRepository implements DictionaryRepository {
  FirebaseDictionaryRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _dictionaryReference() =>
      _firestore.collection('dictionary');

  @override
  Future<List<DictionaryEntry>> searchByKey(String key) async {
    final snapshot = await _dictionaryReference()
        .where('searchKey', isEqualTo: key)
        .get();
    return snapshot.docs
        .map((doc) => DictionaryEntry.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Stream<DictionaryEntry> generate(String term) {
    final docRef = _dictionaryReference().doc();
    final entry = DictionaryEntry.pending(docRef.id, term);
    docRef.set(entry.toJson()).catchError((error) {
      AppLogger.error(
        'Failed to create dictionary entry for term "$term"',
        tag: LogTag.dictionary,
        error: error,
      );
    });
    return docRef.snapshots().map(
      (snapshot) => DictionaryEntry.fromJson(snapshot.data()!, snapshot.id),
    );
  }
}
