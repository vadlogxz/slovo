import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';

/// The small rounded-pill container shared by every inline badge/tag in the
/// app (article gender, word-type abbreviation, "just added" tag, etc.) —
/// callers supply their own background and child so only the shape (padding,
/// radius) is unified here.
class BadgePill extends StatelessWidget {
  const BadgePill({super.key, required this.child, this.backgroundColor});

  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: child,
    );
  }
}
