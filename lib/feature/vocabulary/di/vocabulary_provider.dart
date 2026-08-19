import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/di/core_providers.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/vocabulary/data/repositories/firestore_collection_repository.dart';
import 'package:slovo/feature/vocabulary/data/repositories/firestore_dictionary_repository.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection.dart';
import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';
import 'package:slovo/feature/vocabulary/domain/repositories/collection_repository.dart';
import 'package:slovo/feature/vocabulary/domain/repositories/dictionary_repository.dart';

// ── Collection ────────────────────────────────────────────────────────────────

final collectionRepositoryProvider = Provider<CollectionRepository>((ref) {
  return FirestoreCollectionRepository(firestore: ref.watch(firestoreProvider));
});

final userCollectionsProvider = StreamProvider<List<Collection>>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return const Stream.empty();
  return ref.watch(collectionRepositoryProvider).watchUserCollections(userId);
});

final collectionByIdProvider = Provider.autoDispose.family<Collection?, String>((
  ref,
  collectionId,
) {
  final collections = ref.watch(userCollectionsProvider).value ?? [];
  return collections.where((c) => c.id == collectionId).firstOrNull;
});

final collectionWordsProvider = StreamProvider.family<List<Word>, String>((
  ref,
  collectionId,
) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return const Stream.empty();
  return ref
      .watch(collectionRepositoryProvider)
      .watchCollectionWords(userId, collectionId);
});

// Returns AsyncValue<Word?> rather than a plain Word? so callers can tell
// "still loading" (loading) apart from "genuinely not in this collection"
// (data with a null value) instead of both collapsing to the same null.
final wordByIdProvider = Provider.autoDispose
    .family<AsyncValue<Word?>, ({String collectionId, String wordId})>((
      ref,
      args,
    ) {
      final wordsAsync = ref.watch(collectionWordsProvider(args.collectionId));
      return wordsAsync.whenData(
        (words) => words.where((w) => w.id == args.wordId).firstOrNull,
      );
    });

// ── Dictionary ────────────────────────────────────────────────────────────────

final dictionaryRepositoryProvider = Provider<DictionaryRepository>((ref) {
  return FirestoreDictionaryRepository(firestore: ref.watch(firestoreProvider));
});

/// Prefix search results. Drive this with a debounced text field value.
/// Returns an empty list for empty queries without hitting Firestore.
final dictionarySearchProvider = FutureProvider.autoDispose
    .family<List<DictionaryEntry>, String>((ref, query) {
      return ref.watch(dictionaryRepositoryProvider).searchByPrefix(query);
    });

// The add-word orchestration (AddWordNotifier, addWordProvider) lives in
// add_word_notifier.dart — it's workflow logic, not provider wiring.
