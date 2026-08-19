import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';

/// The small rounded-square icon button used in screen headers across the
/// vocabulary feature (back, more, favorite, etc.).
class HeaderIconButton extends StatelessWidget {
  const HeaderIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 20,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: colors.surfaceSubtle,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Icon(icon, size: size, color: colors.textSecondary),
      ),
    );
  }
}
