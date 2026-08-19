import 'package:flutter/material.dart';
import 'package:slovo/core/theme/app_accents.dart';

import '../domain/models/word.dart';

// Matches the blue/red/green der-die-das mnemonic used across German-learner
// material — der learners already associate these colors with gender, so
// reusing them (via the closest AppAccents hues) is more useful here than
// picking colors freehand.
extension NounGenderX on NounGender {
  Color get color {
    switch (this) {
      case NounGender.der:
        return AppAccents.blue; // masculine
      case NounGender.die:
        return AppAccents.coral; // feminine (closest accent to "red")
      case NounGender.das:
        return AppAccents.mint; // neuter (closest accent to "green")
    }
  }
}