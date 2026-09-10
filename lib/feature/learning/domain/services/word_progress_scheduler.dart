import 'package:slovo/feature/learning/domain/models/word_progress.dart';
import 'package:slovo/feature/learning/presentation/widgets/recall_buttons.dart';

abstract class WordProgressScheduler {
  /// Computes the next [WordProgress] for a word given how well it was
  /// recalled. [current] is null the first time a word is ever reviewed.
  WordProgress review({
    required String dictionaryEntryId,
    required WordProgress? current,
    required RecallRating rating,
  });
}