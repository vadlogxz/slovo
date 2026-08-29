import 'package:flutter/material.dart';
import 'package:slovo/core/theme/app_accents.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';

// Content-bearing types (noun/verb/adjective/adverb/pronoun/phrase) each get
// their own AppAccents color — one accent per case, none reused.
//
// Pure grammatical connectors (preposition/conjunction) carry no meaning of
// their own, so instead of inventing 2 more hues, they borrow the closest
// content word's color at reduced opacity — visually "quieter", signaling
// "function word" rather than competing for attention with content words.
extension WordTypeColorX on WordType {
  Color get color {
    switch (this) {
      case WordType.noun:
        return AppAccents.blue; // concrete, stable — things
      case WordType.verb:
        return AppAccents.coral; // action, energy
      case WordType.adjective:
        return AppAccents.mint; // fresh, descriptive
      case WordType.adverb:
        return AppAccents.purple; // nuance, modifies verbs/adjectives
      case WordType.pronoun:
        return AppAccents.orange; // stands in for a person/noun — warm
      case WordType.phrase:
        return AppAccents.yellow; // idiomatic, meant to stand out
      case WordType.preposition:
        // Ties to nouns (spatial/relational: "in", "on", "under").
        return AppAccents.blue.withValues(alpha: 0.5);
      case WordType.conjunction:
        // Ties to adverbs (logical/connective: "however", "therefore").
        return AppAccents.purple.withValues(alpha: 0.5);
    }
  }
}