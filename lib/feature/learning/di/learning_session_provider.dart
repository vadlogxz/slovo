import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/learning/di/word_progress_provider.dart';
import 'package:slovo/feature/learning/domain/models/learning_session_state.dart';
import 'package:slovo/feature/learning/domain/models/word_progress.dart';

import '../presentation/widgets/recall_buttons.dart';

class LearningSessionNotifier extends Notifier<LearningSessionState> {
  @override
  LearningSessionState build() {
    return LearningSessionState(currentWordIndex: 0, recallRatings: {
      RecallRating.again: 0,
      RecallRating.hard: 0,
      RecallRating.good: 0,
      RecallRating.easy: 0,
    });
  }

  void incrementCurrentWordIndex() {
    state = state.copyWith(currentWordIndex: state.currentWordIndex + 1);
  }

  void updateRecallRatings(RecallRating rating) {
    final updatedRatings = Map<RecallRating, int>.from(state.recallRatings);
    updatedRatings[rating] = updatedRatings[rating]! + 1;
    state = state.copyWith(recallRatings: updatedRatings);
  }


  Future<void> recordWordProgress({
    required String dictionaryEntryId,
    required RecallRating rating,
  }) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId != null) {
      final currentWordProgress = await ref
          .read(wordProgressProvider)
          .getWordProgress(userId: userId, dictionaryEntryId: dictionaryEntryId);

      await ref
          .read(wordProgressProvider)
          .updateWordProgress(
            userId: userId,
            wordProgress: WordProgress.record(
              dictionaryEntryId: dictionaryEntryId,
              rating: rating,
              previousReviewCount: currentWordProgress?.reviewedCount ?? 0,
            ),
          );
    }
  }
}

final learningSessionProvider = NotifierProvider<LearningSessionNotifier, LearningSessionState>(
  LearningSessionNotifier.new,
);
