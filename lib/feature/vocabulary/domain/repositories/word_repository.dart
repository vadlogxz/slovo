import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';

abstract class WordRepository {
  Future<void> addWordToCollections({
    required String userId,
    required DictionaryEntry entry,
    required List<String> collectionIds,
  });

  Future<List<Word>> getAllWords({required String userId});
}
