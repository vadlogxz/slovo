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
    // TODO(fuzzy-search): exact match only — a typo (e.g. "Hause" instead
    // of "Haus") finds nothing here and falls through to generate(), which
    // just creates a second, near-duplicate entry. Firestore has no native
    // fuzzy-match query; options if this becomes annoying in practice:
    // (1) Cloud Function-side Levenshtein over a narrowed candidate set
    //     (same first letter, length within ~2), cheap at our current
    //     dictionary size; or
    // (2) sync entries to a dedicated search service (Algolia/Typesense)
    //     via a Firestore trigger, same pattern as onWordsChanged.
    // Deliberately not implemented yet — MVP scope, revisit if it's
    // actually annoying in practice, not preemptively.
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
