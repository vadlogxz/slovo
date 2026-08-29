import 'package:flutter/material.dart';
import 'package:slovo/core/theme/app_colors.dart';
import 'package:slovo/core/theme/app_radius.dart';
import 'package:slovo/core/theme/app_spacing.dart';

class WordExample extends StatelessWidget {
  const WordExample({
    super.key,
    required this.example,
    this.exampleTranslation,
  });

  final String example;
  final String? exampleTranslation;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: context.colors.primary,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
        ),
        SizedBox(width: AppSpacing.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              example,
              style: textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
            if (exampleTranslation != null)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xs),
                child: Text(exampleTranslation!, style: textTheme.bodySmall),
              ),
          ],
        ),
      ],
    );
  }
}
