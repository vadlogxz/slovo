import 'package:flutter/material.dart';

extension ColorX on Color {
  Color get contrastForeground {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness((hsl.lightness * 0.55).clamp(0.0, 1.0)).toColor();
  }
}