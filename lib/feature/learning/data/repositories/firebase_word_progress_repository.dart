import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slovo/core/logging/app_logger.dart';
import 'package:slovo/feature/learning/domain/models/word_progress.dart';
import 'package:slovo/feature/learning/domain/repositories/word_progress_repository.dart';

class FirebaseWordProgressRepository implements WordProgressRepository {
  FirebaseWordProgressRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _progressReference(String userId) =>
      _firestore.collection('users').doc(userId).collection('progress');

  @override
  Future<WordProgress?> getWordProgress({
    required String userId,
    required String dictionaryEntryId,
  }) async {
    return await _progressReference(userId).doc(dictionaryEntryId).get().then((
      doc,
    ) {
      if (doc.exists) {
        return WordProgress.fromJson(doc.data()!);
      } else {
        AppLogger.info('Word progress not found for user $userId and entry $dictionaryEntryId');
        return null;
      }
    });
  }

  @override
  Future<void> updateWordProgress({
    required String userId,
    required WordProgress wordProgress,
  }) async {
    return await _progressReference(
      userId,
    ).doc(wordProgress.dictionaryEntryId).set(wordProgress.toJson());
  }

  @override
  Future<List<WordProgress>> getAllProgress({required String userId}) async {
    final snapshot = await _progressReference(userId).get();
    return snapshot.docs.map((doc) => WordProgress.fromJson(doc.data())).toList();
  }
}
