import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/shared/widgets/app_button.dart';

class WordsDueCard extends StatelessWidget {
  const WordsDueCard({
    super.key,
    required this.wordCount,
    required this.collectionCount,
    required this.estimatedMinutes,
    this.onStart,
  });

  final int wordCount;
  final int collectionCount;
  final int estimatedMinutes;
  final VoidCallback? onStart;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppGradients.primary.colors,
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: AppGradients.primary.colors[1].withValues(alpha: 0.45),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ready to learn?',
                  style: tt.bodySmall?.copyWith(
                    color: colors.textOnBrandMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '$wordCount words due',
                  style: tt.headlineSmall?.copyWith(
                    color: colors.textOnBrand,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Across $collectionCount collections · About $estimatedMinutes min',
                  style: tt.labelMedium?.copyWith(
                    color: colors.textOnBrandMuted,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          SizedBox(
            width: 72,
            height: 44,
            child: AppButton(
              onTap: onStart,
              backgroundColor: colors.textOnBrand.withValues(alpha: 0.15),
              border: Border.all(
                color: colors.textOnBrand.withValues(alpha: 0.35),
                width: 1.5,
              ),
              borderRadius: AppRadius.md,
              contentPadding: EdgeInsets.zero,
              pressedScale: 0.90,
              pressedOverlayColor: colors.textOnBrand.withValues(alpha: 0.15),
              boxShadow: const BoxShadow(color: Colors.transparent),
              pressedBoxShadow: const BoxShadow(color: Colors.transparent),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: colors.textOnBrand,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
