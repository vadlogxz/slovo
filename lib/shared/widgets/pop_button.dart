import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:slovo/core/theme/app_colors.dart';
import 'package:slovo/core/theme/app_radius.dart';
import 'package:slovo/core/theme/app_spacing.dart';

class PopButton extends StatelessWidget {
  const PopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          border: Border.all(color: context.colors.outline, width: 2),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Icon(Icons.close, color: context.colors.textMuted),
      ),
    );
  }
}
