import 'package:slovo/feature/study/domain/models/card_progress.dart';

abstract interface class CardProgressRepository {
  /// Streams every card in [collectionId] so the UI can derive due-count and
  /// mastery stats. A word with no doc here simply has no progress yet.
  Stream<List<CardProgress>> watchCollectionProgress(
    String userId,
    String collectionId,
  );

  /// Streams every card across all of the user's collections — used for
  /// account-wide aggregates (e.g. the Home screen's total due-count) where
  /// scoping to one collection at a time would be wrong.
  Stream<List<CardProgress>> watchAllProgress(String userId);

  /// Persists a reviewed card's updated FSRS state.
  ///
  /// If [wordsLearnedDelta] is non-zero, the owning collection's
  /// wordsLearned counter is adjusted in the same atomic write — the two
  /// must never be allowed to drift independently.
  Future<void> saveProgress(
    String userId,
    CardProgress progress, {
    int wordsLearnedDelta = 0,
  });
}
