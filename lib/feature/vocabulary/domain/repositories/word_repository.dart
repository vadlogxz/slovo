import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';

abstract class WordRepository {

  Future<void> addWordToCollections(DictionaryEntry entry, List<String> collectionIds);
}