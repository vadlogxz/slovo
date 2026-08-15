import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';

abstract class DictionaryRepository {

  Future<List<DictionaryEntry>>searchByKey(String key);

  Stream<DictionaryEntry> generate(String term);
}