import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slovo/core/error/firestore_error_handling.dart';
import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';
import 'package:slovo/feature/vocabulary/domain/repositories/dictionary_repository.dart';

// DictionaryEntry is a pure-Dart domain model (per architecture.md), so its
// Firestore (de)serialization — which needs the Timestamp type — lives here
// in the data layer instead of on the model itself.
DictionaryEntry _entryFromFirestore(String id, Map<String, dynamic> data) {
  final status = GenerationStatus.fromString(data['status'] as String?);
  return DictionaryEntry(
    id: id,
    term: data['term'] as String,
    status: status,
    errorMessage: data['errorMessage'] as String?,
    createdAt: (data['createdAt'] as Timestamp).toDate(),
    // Parse linguistics only when the entry is complete.
    linguistics: status == GenerationStatus.ready
        ? WordLinguistics.fromMap(data)
        : null,
  );
}

class FirestoreDictionaryRepository implements DictionaryRepository {
  FirestoreDictionaryRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  // U+F8FF — Private Use Area character that sorts after all regular Unicode,
  // making '$prefix' an inclusive upper bound for prefix range queries.
  static const _prefixUpperBound = '';

  // A pending entry stuck longer than this is assumed to have lost its
  // Cloud Function invocation (cold-start crash, deploy race, etc.) and is
  // retried on the next lookup. Must match firestore.rules' matching bound.
  static const _pendingStaleAfter = Duration(minutes: 2);

  // Document ID = lowercased, trimmed term for O(1) lookup and deduplication.
  // Firestore document IDs may not contain '/', and may not be exactly '.'
  // or '..', so both are escaped here — the unescaped term is still
  // preserved in the 'term'/'termLower' fields.
  String _docId(String normalizedTerm) {
    final escaped = normalizedTerm.replaceAll('/', '%2F');
    return (escaped == '.' || escaped == '..')
        ? escaped.replaceAll('.', '%2E')
        : escaped;
  }

  DocumentReference<Map<String, dynamic>> _entryRef(String docId) =>
      _firestore.collection('dictionary').doc(docId);

  @override
  Future<DictionaryEntry> lookupOrRequest(String term) {
    final normalizedTerm = term.toLowerCase().trim();
    final trimmedTerm = term.trim();
    final docId = _docId(normalizedTerm);
    final ref = _entryRef(docId);

    return wrapFirestoreErrors(() {
      // A transaction makes the "check, then create if missing" sequence
      // atomic: if two callers race to create the same new term, Firestore
      // aborts and retries the loser, which then sees the doc the winner
      // just created instead of attempting a client-side update (blocked by
      // firestore.rules).
      return _firestore.runTransaction<DictionaryEntry>((transaction) async {
        final snapshot = await transaction.get(ref);
        if (snapshot.exists) {
          final data = snapshot.data()!;
          final existing = _entryFromFirestore(snapshot.id, data);

          final isStalePending = existing.isPending &&
              DateTime.now().difference(existing.createdAt) >
                  _pendingStaleAfter;
          if (existing.isFailed || isStalePending) {
            // Reset back to pending so generateWord's onDocumentWritten
            // trigger fires again — firestore.rules only allows this
            // transition (failed/stale-pending → pending), not arbitrary
            // client writes.
            transaction.update(ref, {
              'status': GenerationStatus.pending.name,
              'createdAt': FieldValue.serverTimestamp(),
              'errorMessage': FieldValue.delete(),
            });
            return DictionaryEntry.pending(docId, existing.term);
          }

          return existing;
        }

        // Not in the global dictionary — write a pending entry.
        // A Cloud Function listens for writes with status=pending
        // and fills in AI-generated linguistic data.
        transaction.set(ref, {
          'term': trimmedTerm,
          'termLower': normalizedTerm,
          'status': GenerationStatus.pending.name,
          'createdAt': FieldValue.serverTimestamp(),
        });

        return DictionaryEntry.pending(docId, trimmedTerm);
      });
    });
  }

  @override
  Stream<DictionaryEntry?> watchEntry(String entryId) {
    return _firestore
        .collection('dictionary')
        .doc(entryId)
        .snapshots()
        .map(
          (snap) => snap.exists
              ? _entryFromFirestore(snap.id, snap.data()!)
              : null,
        )
        .wrapFirestoreErrors();
  }

  @override
  Future<List<DictionaryEntry>> searchByPrefix(
    String query, {
    int limit = 20,
  }) {
    final q = query.toLowerCase().trim();
    if (q.isEmpty) return Future.value(const []);

    return wrapFirestoreErrors(() async {
      // Prefix range: termLower >= q  AND  termLower < q + U+F8FF.
      // Requires a composite Firestore index on (termLower ASC, status ASC).
      final snap = await _firestore
          .collection('dictionary')
          .where('termLower', isGreaterThanOrEqualTo: q)
          .where('termLower', isLessThan: '$q$_prefixUpperBound')
          .where('status', isEqualTo: GenerationStatus.ready.name)
          .orderBy('termLower')
          .limit(limit)
          .get();

      return snap.docs
          .map((d) => _entryFromFirestore(d.id, d.data()))
          .toList();
    });
  }
}