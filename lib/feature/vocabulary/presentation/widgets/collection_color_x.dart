import 'package:flutter/material.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection_color.dart';

// CollectionColor is a pure-Dart domain enum (per architecture.md — no
// Flutter imports in domain/), so its swatch mapping lives here in the
// presentation layer instead of on the enum itself.
extension CollectionColorX on CollectionColor {
  Color get value => switch (this) {
    CollectionColor.teal => const Color(0xFF2CBDAC),
    CollectionColor.violet => const Color(0xFF4e5bd6),
    CollectionColor.pink => const Color(0xFFD6409F),
    CollectionColor.gold => const Color(0xFFc9a227),
    CollectionColor.green => const Color(0xFF30A46C),
    CollectionColor.purple => const Color(0xFF8B5CF6),
  };
}
