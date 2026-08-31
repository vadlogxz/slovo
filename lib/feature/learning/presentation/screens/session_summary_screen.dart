import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:slovo/app/router/app_routes.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/home/presentation/widgets/statistic_card.dart';
import 'package:slovo/feature/learning/presentation/widgets/recall_buttons.dart';
import 'package:slovo/shared/widgets/_.dart';

class SessionSummaryScreen extends StatelessWidget {
  const SessionSummaryScreen({super.key, required this.recallRatings, required this.reviewedCount});
  final Map<RecallRating, int> recallRatings;
  final int reviewedCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Center(
            child: Column(
              spacing: AppSpacing.md,
              children: [
                Spacer(),
                Text(
                  'Nice work!',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Row(
                  spacing: AppSpacing.md,
                  children: [
                    Expanded(
                      child: StatisticCard(
                        title: 'Reviewed',
                        value: '$reviewedCount',
                        icon: Icons.bookmark_border_outlined,
                        color: AppAccents.purple,
                        iconSize: 28,
                        valueTextStyle: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: context.colors.textPrimary,
                            ),
                        titleTextStyle: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              fontSize: 13,
                              color: context.colors.textSecondary,
                            ),
                      ),
                    ),
                    Expanded(
                      child: StatisticCard(
                        title: 'Accuracy',
                        //TODO: Implement real data for Accuracy
                        value: '92%',
                        icon: Icons.check,
                        color: AppAccents.mint,
                        iconSize: 28,
                        valueTextStyle: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: context.colors.textPrimary,
                            ),
                        titleTextStyle: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              fontSize: 13,
                              color: context.colors.textSecondary,
                            ),
                      ),
                    ),
                    Expanded(
                      child: StatisticCard(
                        title: 'Time',
                        //TODO: Implement real data for Time
                        value: '5m 30s',
                        icon: Icons.timer_outlined,
                        color: AppAccents.blue,
                        iconSize: 28,
                        valueTextStyle: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: context.colors.textPrimary,
                            ),
                        titleTextStyle: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              fontSize: 13,
                              color: context.colors.textSecondary,
                            ),
                      ),
                    ),
                  ],
                ),
                _SessionResults(
                  againCount: recallRatings[RecallRating.again]!,
                  hardCount: recallRatings[RecallRating.hard]!,
                  goodCount: recallRatings[RecallRating.good]!,
                  easyCount: recallRatings[RecallRating.easy]!,
                ),
                Spacer(),
                AppButton(
                  onTap: () {
                    context.goNamed(AppRoutes.home.name);
                  },
                  text: 'Done',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SessionResults extends StatelessWidget {
  const _SessionResults({
    required this.againCount,
    required this.hardCount,
    required this.goodCount,
    required this.easyCount,
  });

  final int againCount;
  final int hardCount;
  final int goodCount;
  final int easyCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.outline, width: 2),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HOW IT WENT',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: AppSpacing.sm),
          AppSectionProgressBar(
            sections: [
              if(againCount > 0)
              ProgressBarSection(value: againCount, color: AppAccents.coral),
              if(hardCount > 0)
              ProgressBarSection(value: hardCount, color: AppAccents.orange),
              if(goodCount > 0)
              ProgressBarSection(value: goodCount, color: AppAccents.yellow),
              if(easyCount > 0)
              ProgressBarSection(value: easyCount, color: AppAccents.mint),
            ],
          ),
          SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Again $againCount',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppAccents.coral,
                ),
              ),
              Text(
                'Hard $hardCount',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppAccents.orange,
                ),
              ),
              Text(
                'Good $goodCount',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppAccents.yellow,
                ),
              ),
              Text(
                'Easy $easyCount',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppAccents.mint,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
