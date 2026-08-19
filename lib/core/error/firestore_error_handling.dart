import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slovo/core/error/repository_exception.dart';

// Shared by Firestore repositories so every call site wraps FirebaseException
// the same way instead of repeating the try/catch block.
Future<T> wrapFirestoreErrors<T>(Future<T> Function() call) async {
  try {
    return await call();
  } on FirebaseException catch (e) {
    throw RepositoryException(e.message ?? 'Firestore error');
  }
}

// Same wrapping for stream-returning repository methods (`.snapshots()`),
// where FirebaseException surfaces as a stream error rather than a thrown
// exception.
extension FirestoreStreamErrorWrapping<T> on Stream<T> {
  Stream<T> wrapFirestoreErrors() => handleError((Object error) {
        if (error is FirebaseException) {
          throw RepositoryException(error.message ?? 'Firestore error');
        }
        throw error;
      });
}