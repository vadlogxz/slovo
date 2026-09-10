import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/learning/di/word_progress_scheduler_provider.dart';
import 'package:slovo/feature/learning/di/word_progress_provider.dart';
import 'package:slovo/feature/learning/domain/models/learning_session_state.dart';

import '../presentation/widgets/recall_buttons.dart';
import 'due_words_provider.dart';

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
            wordProgress: ref.read(wordProgressSchedulerProvider).review(
              dictionaryEntryId: dictionaryEntryId,
              current: currentWordProgress,
              rating: rating,
            ),
          );
      ref.invalidate(dueWordsProvider);
    }
  }
}

final learningSessionProvider = NotifierProvider.autoDispose<LearningSessionNotifier, LearningSessionState>(
  LearningSessionNotifier.new,
);
