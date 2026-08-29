import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:slovo/core/logging/app_logger.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/learning/presentation/screens/session_summary_screen.dart';
import 'package:slovo/feature/learning/presentation/widgets/recall_buttons.dart';
import 'package:slovo/feature/learning/presentation/widgets/word_card.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';
import 'package:slovo/shared/widgets/_.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key, required this.sessionWordList});

  final List<Word> sessionWordList;

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int currentWordIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (currentWordIndex >= widget.sessionWordList.length) {
      return SessionSummaryScreen();
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
                  totalWords: widget.sessionWordList.length,
                ),
              ),
              WordCard(word: widget.sessionWordList[currentWordIndex]),
              SizedBox(height: AppSpacing.md),
              RecallButtons(
                onTap: (RecallRating rating) {
                  AppLogger.debug('Recall rating: $rating');
                  setState(() {
                    currentWordIndex++;
                  });
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
        GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              border: Border.all(color: context.colors.outline, width: 2),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(Icons.close, color: context.colors.textMuted),
          ),
        ),
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
