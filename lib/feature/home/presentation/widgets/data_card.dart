import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';

class DataCard extends StatelessWidget {
  const DataCard({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: colors.outline,
          width: 1.5,
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: tt.headlineMedium?.copyWith(color: colors.primaryDark),),
          Text(subtitle, style: tt.labelLarge?.copyWith(color: colors.textMuted,),),
        ],
      )
    );
  }
}
