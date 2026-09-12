import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:slovo/app/router/app_routes.dart';
import 'package:slovo/core/logging/app_logger.dart';
import 'package:slovo/feature/home/presentation/widgets/all_caught_up_section.dart';
import 'package:slovo/feature/learning/di/due_words_provider.dart';
import 'package:slovo/shared/widgets/app_button.dart';

import '../../../../core/theme/_.dart';

class StartLearningSection extends ConsumerWidget {
  const StartLearningSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dueWordsAsync = ref.watch(dueWordsProvider);

    // Once loaded, an empty list means there's nothing to review right now —
    // show the empty state instead of a "Start Learning" card with nowhere
    // useful to go (no session to run).

    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        border: BoxBorder.all(color: context.colors.outline, width: 2),
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: dueWordsAsync.value?.isEmpty == true
          ? const AllCaughtUpSection()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _DueForReviewSummary(),
                SizedBox(height: AppSpacing.md),
                const _StartLearningButton(),
              ],
            ),
    );
  }
}

class _DueForReviewSummary extends ConsumerWidget {
  const _DueForReviewSummary();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dueWords = ref.watch(dueWordsProvider).value ?? const [];
    final wordCount = dueWords.length;
    final collectionCount = dueWords
        .expand((word) => word.collectionIds)
        .toSet()
        .length;

    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DUE FOR REVIEW',
              style: textTheme.labelMedium?.copyWith(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
            SizedBox(height: AppSpacing.xs),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              spacing: AppSpacing.xs,
              children: [
                Text(
                  '$wordCount',
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                ),
                Text(
                  'words',
                  style: textTheme.bodyMedium?.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          'across $collectionCount collections',
          textAlign: TextAlign.right,
          style: textTheme.bodyMedium?.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _StartLearningButton extends ConsumerWidget {
  const _StartLearningButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dueWordsAsync = ref.watch(dueWordsProvider);

    if (dueWordsAsync.hasError) {
      AppLogger.error('Failed to load due words: ${dueWordsAsync.error}');
    }

    return AppButton(
      onTap: dueWordsAsync.hasValue
          ? () => context.push(
              AppRoutes.learning.path,
              extra: dueWordsAsync.value,
            )
          : null,
      isDisabled: !dueWordsAsync.hasValue,
      style: AppButtonStyle.outline(context.colors).copyWith(
        background: context.colors.surfaceAccent,
        border: BoxBorder.all(color: context.colors.primary, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: AppSpacing.md,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: context.colors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.play_arrow, color: context.colors.surfaceAccent),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Start Learning',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: context.colors.textPrimary,
                  fontSize: 18,
                ),
              ),
              Text(
                'Recommended for you',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: context.colors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: context.colors.primary,
            size: 20,
          ),
        ],
      ),
    );
  }
}
