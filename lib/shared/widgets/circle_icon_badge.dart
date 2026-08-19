import 'package:flutter/material.dart';

/// The small circular "icon in a tinted circle" badge used across the app
/// for compact affordances (close, add, check, speaker, etc.) — callers vary
/// size, background, and the icon itself, so only the circle shape (and the
/// optional tap target) is unified here.
class CircleIconBadge extends StatelessWidget {
  const CircleIconBadge({
    super.key,
    required this.icon,
    required this.backgroundColor,
    this.size = 22,
    this.onTap,
  });

  final Widget icon;
  final Color backgroundColor;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final circle = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Center(child: icon),
    );
    return onTap == null
        ? circle
        : GestureDetector(onTap: onTap, child: circle);
  }
}
