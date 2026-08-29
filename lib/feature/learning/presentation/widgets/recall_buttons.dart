import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/shared/widgets/_.dart';

enum RecallRating { again, hard, good, easy }

class RecallButtons extends StatelessWidget {
  const RecallButtons({super.key, required this.onTap});
  final void Function(RecallRating) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.sm,
      children: [
        Expanded(
          child: AppButton(
            onTap: () => onTap(RecallRating.again),
            style: AppButtonStyle(background: AppAccents.coral),
            child: Text('Again', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: context.colors.textOnBrand)),
          ),
        ),
        Expanded(
          child: AppButton(
            onTap: () => onTap(RecallRating.hard),
            style: AppButtonStyle(background: AppAccents.orange),
            child: Text('Hard', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: context.colors.textOnBrand)),
          ),
        ),
        Expanded(
          child: AppButton(
            onTap: () => onTap(RecallRating.good),
            style: AppButtonStyle(background: AppAccents.yellow),
            child: Text('Good', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: context.colors.textOnBrand)),
          ),
        ),
        Expanded(
          child: AppButton(
            onTap: () => onTap(RecallRating.easy),
            style: AppButtonStyle(background: AppAccents.mint),
            child: Text('Easy', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: context.colors.textOnBrand)),
          ),
        ),
      ],
    );
  }
}
