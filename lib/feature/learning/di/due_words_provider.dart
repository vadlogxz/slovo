import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/learning/di/word_progress_provider.dart';
import 'package:slovo/feature/vocabulary/di/word_provider.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';

final dueWordsProvider = FutureProvider<List<Word>>((ref) async {
  final userId = ref.read(currentUserIdProvider);
  final dueWords = <Word>[];
  if(userId != null) {
    final allWords = await ref.read(wordRepositoryProvider).getAllWords(userId: userId);
    for(final word in allWords) {
      final progress = await ref.read(wordProgressProvider).getWordProgress(userId: userId, dictionaryEntryId: word.dictionaryEntryId);

      if(progress == null || progress.fsrsCard.due.isBefore(DateTime.now())) {
        dueWords.add(word);
      }
    }
    return dueWords;
  }
  return [];
});