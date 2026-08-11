import 'package:flutter/material.dart';

/// Decorative accent palette — NOT theme/feedback state.
///
/// Use for purely visual variety (stat card icons, streak badges, selection
/// pills, illustrative blobs) where the color carries no semantic meaning.
/// Same values in light and dark — these never adapt to theme.
///
/// For real feedback state (errors, success messages, warnings) use
/// [AppColors] instead.
class AppAccents {
  AppAccents._();

  static const yellow = Color(0xFFFFE566);
  static const orange = Color(0xFFFE9F43);
  static const mint = Color(0xFF00C9A7);
  static const coral = Color(0xFFFF5C5C);
  static const blue = Color(0xFF3B7CFF);
  static const purple = Color(0xFF9B5CFF);
}

