import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/theme/app_colors.dart';
import 'package:slovo/core/theme/app_radius.dart';
import 'package:slovo/core/theme/app_spacing.dart';

class StatisticCard extends ConsumerWidget {
  const StatisticCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.iconSize = 20.0,
    this.titleTextStyle,
    this.valueTextStyle,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final double iconSize;
  final TextStyle? titleTextStyle;
  final TextStyle? valueTextStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.md),
        border: Border.all(color: context.colors.outline, width: 2),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
            ),
            child: Icon(icon, color: color, size: iconSize),
          ),
          SizedBox(height: AppSpacing.sm),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: valueTextStyle ?? Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: titleTextStyle ?? Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 13,
                color: context.colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
