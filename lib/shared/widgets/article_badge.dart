import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';
import 'package:slovo/shared/widgets/badge_pill.dart';

class ArticleBadge extends StatelessWidget {
  const ArticleBadge({super.key, required this.gender});

  final NounGender gender;

  /// The accent color for [gender] (der/die/das each map to a fixed brand
  /// color). Exposed so other widgets that show the article as inline
  /// colored text stay visually consistent with this badge.
  static Color colorFor(AppColors colors, NounGender gender) =>
      switch (gender) {
        NounGender.der => colors.primary,
        NounGender.die => colors.pink,
        NounGender.das => colors.rating,
      };

  @override
  Widget build(BuildContext context) {
    final fg = colorFor(context.colors, gender);

    return BadgePill(
      backgroundColor: fg.withValues(alpha: 0.12),
      child: Text(
        gender.name,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: fg,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}
