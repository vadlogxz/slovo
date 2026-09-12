import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/logging/app_logger.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/learning/di/learning_session_provider.dart';
import 'package:slovo/feature/learning/presentation/screens/session_summary_screen.dart';
import 'package:slovo/feature/learning/presentation/widgets/recall_buttons.dart';
import 'package:slovo/feature/learning/presentation/widgets/word_card.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';
import 'package:slovo/shared/widgets/_.dart';

class LearningScreen extends ConsumerWidget {
  const LearningScreen({super.key, required this.sessionWordList});

  final List<Word> sessionWordList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWordIndex = ref
        .watch(learningSessionProvider)
        .currentWordIndex;

    if (currentWordIndex >= sessionWordList.length) {
      final recallRatings = ref.read(learningSessionProvider).recallRatings;
      return SessionSummaryScreen(
        recallRatings: recallRatings,
        reviewedCount: sessionWordList.length,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.md),
                child: _LearningAppBar(
                  currentWordIndex: currentWordIndex,
                  totalWords: sessionWordList.length,
                ),
              ),
              WordCard(word: sessionWordList[currentWordIndex]),
              SizedBox(height: AppSpacing.md),
              RecallButtons(
                onTap: (RecallRating rating) async {
                  AppLogger.debug('Recall rating: $rating');
                  final currentWordId =
                      sessionWordList[currentWordIndex].dictionaryEntryId;
                  ref
                      .read(learningSessionProvider.notifier)
                      .incrementCurrentWordIndex();
                  ref
                      .read(learningSessionProvider.notifier)
                      .updateRecallRatings(rating);
                  await ref
                      .read(learningSessionProvider.notifier)
                      .recordWordProgress(
                        dictionaryEntryId: currentWordId,
                        rating: rating,
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LearningAppBar extends StatelessWidget {
  const _LearningAppBar({
    required this.currentWordIndex,
    required this.totalWords,
  });

  final int currentWordIndex;
  final int totalWords;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.sm,
      children: [
        PopButton(),
        Expanded(
          child: AppProgressBar(
            value: (currentWordIndex + 1) / totalWords,
            height: 8,
            progressColor: context.colors.primary,
            backgroundColor: context.colors.outline,
          ),
        ),
        Text(
          '${currentWordIndex + 1}/$totalWords',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: context.colors.textMuted),
        ),
      ],
    );
  }
}
