import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/shared/widgets/_.dart';

class NavIcon extends StatelessWidget {
  const NavIcon({super.key, required this.path, required this.selected});

  final String path;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final icon = AppIcon(
      // Opaque placeholder — the ShaderMask below replaces this color with
      // the gradient when selected, so only full opacity/coverage matters.
      color: selected ? colors.textOnBrand : colors.textMuted,
      path: path,
      size: 26,
    );

    if (!selected) return icon;

    return ShaderMask(
      shaderCallback: (bounds) => AppGradients.bluePurple.createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: icon,
    );
  }
}
