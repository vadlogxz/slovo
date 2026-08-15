import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';
import 'package:slovo/feature/vocabulary/domain/repositories/word_repository.dart';

class FirebaseWordRepository implements WordRepository{

  @override
  Future<void> addWordToCollections(DictionaryEntry entry, List<String> collectionIds) {

    throw UnimplementedError();
  }
}