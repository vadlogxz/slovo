import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';

abstract class WordRepository {
  Future<void> addWordToCollections({
    required String userId,
    required DictionaryEntry entry,
    required List<String> collectionIds,
  });
}
