import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';

/// The rounded-square "icon in a tinted box" container used across the app
/// for feature/collection/summary icons — callers vary size, background, and
/// the icon itself, so only the container shape is unified here.
class IconAvatar extends StatelessWidget {
  const IconAvatar({
    super.key,
    required this.icon,
    required this.backgroundColor,
    this.size = 44,
    this.radius,
  });

  final Widget icon;
  final Color backgroundColor;
  final double size;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius ?? AppRadius.md),
      ),
      child: Center(child: icon),
    );
  }
}
