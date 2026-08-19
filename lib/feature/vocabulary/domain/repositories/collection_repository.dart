import 'package:slovo/feature/vocabulary/domain/models/collection.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection_color.dart';
import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';

abstract interface class CollectionRepository {
  Stream<List<Collection>> watchUserCollections(String userId);
  Stream<List<Word>> watchCollectionWords(String userId, String collectionId);

  Future<Collection> createCollection({
    required String userId,
    required String title,
    String? description,
    CollectionColor color = CollectionColor.violet,
    bool isPublic = false,
    String language = 'de',
    List<String> tags = const [],
  });

  Future<void> updateCollection(String uid, Collection collection);
  Future<void> deleteCollection(String uid, String collectionId);

  /// Adds a ready dictionary entry to a user's collection as a [Word].
  /// Atomically increments [Collection.wordCount].
  /// Throws [RepositoryException] if [entry] is not [GenerationStatus.ready].
  Future<Word> addWordToCollection({
    required String userId,
    required String collectionId,
    required DictionaryEntry entry,
  });

  /// Removes a word from a user's collection.
  /// Atomically decrements [Collection.wordCount].
  Future<void> deleteWordFromCollection({
    required String userId,
    required String collectionId,
    required String wordId,
  });
}
