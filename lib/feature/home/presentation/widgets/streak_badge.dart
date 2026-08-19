import 'package:flutter/material.dart';
import 'package:slovo/core/assets/app_assets.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/shared/widgets/app_icon.dart';

class StreakBadge extends StatelessWidget {
  const StreakBadge({super.key, required this.streak});

  final int streak;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colors.primary12,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.sm,
        children: [
          AppIcon(
            path: AppAssets.fire,
            size: 18,
          ),
          Text.rich(
            TextSpan(
              text: '$streak',
              style: tt.titleSmall?.copyWith(color: colors.primaryDark),
              children: [
                TextSpan(
                  text: ' day streak',
                  style: tt.labelMedium?.copyWith(color: colors.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}