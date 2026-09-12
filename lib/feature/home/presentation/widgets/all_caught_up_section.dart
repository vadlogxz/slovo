import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/core/utils/format_date.dart';
import 'package:slovo/feature/learning/di/review_summary_provider.dart';

class AllCaughtUpSection extends ConsumerWidget {
  const AllCaughtUpSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewSummary = ref.watch(reviewSummaryProvider).value;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppAccents.mint.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, size: 38, color: AppAccents.mint),
        ),
        Text(
          'Nothing due right now',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: context.colors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        if (reviewSummary != null)
          Text(
            'You cleared all ${reviewSummary.clearedToday} words today. The next ${reviewSummary.nextBatchCount} come\nback at ${reviewSummary.nextDue != null ? formatTime(reviewSummary.nextDue!) : "unknown"}.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: context.colors.textSecondary,
              fontSize: 14,
            ),
          ),
      ],
    );
  }
}
