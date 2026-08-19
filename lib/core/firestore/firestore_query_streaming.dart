import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slovo/core/error/firestore_error_handling.dart';

// Shared by every repository method that streams a Firestore query as a
// list of domain objects, so "snapshots → map each doc through
// fromFirestore → wrap errors" is written once instead of per query.
Stream<List<T>> watchQueryAsList<T>(
  Query<Map<String, dynamic>> query,
  T Function(String id, Map<String, dynamic> data) fromFirestore,
) {
  return query
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((doc) => fromFirestore(doc.id, doc.data()))
            .toList(),
      )
      .wrapFirestoreErrors();
}
