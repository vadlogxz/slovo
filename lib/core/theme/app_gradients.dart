import 'package:flutter/material.dart';

class AppGradients {
  AppGradients._();

  // Primary CTA — Indigo → Violet (Radix indigo9 → violet9)
  static const primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3E63DD), Color(0xFF6E56CF)],
  );

  // Blue → Purple accent (secondary actions, borders, icons)
  static const bluePurple = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3E63DD), Color(0xFF4e5bd6)], // indigo → violet
  );

  // AI card / featured surface
  static const aiCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1F1B2E), Color(0xFF161416)],
  );

  // Subtle surface depth — Mauve dark 4 → 3
  static const surfaceGlow = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF282330), Color(0xFF23202B)],
  );
}
