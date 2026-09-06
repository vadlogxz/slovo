import 'package:slovo/feature/learning/domain/models/word_progress.dart';

abstract class WordProgressRepository {
  Future<WordProgress?> getWordProgress({required String userId, required String dictionaryEntryId});
  Future<void> updateWordProgress({required String userId, required WordProgress wordProgress});
}