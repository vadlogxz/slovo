import 'package:flutter/material.dart';
import 'package:slovo/core/theme/app_accents.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection_color.dart';

extension CollectionColorX on CollectionColor {
  Color get color {
    switch (this) {
      case CollectionColor.yellow:
        return AppAccents.yellow;
      case CollectionColor.orange:
        return AppAccents.orange;
      case CollectionColor.mint:
        return AppAccents.mint;
      case CollectionColor.coral:
        return AppAccents.coral;
      case CollectionColor.blue:
        return AppAccents.blue;
      case CollectionColor.purple:
        return AppAccents.purple;
    }
  }
}