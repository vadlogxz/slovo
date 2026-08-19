import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/error/repository_exception.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/vocabulary/di/vocabulary_provider.dart';
import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';

// Flow when a user submits a term from the add-word screen:
//
//   submit("Haus", userId, collectionId)
//     │
//     ├─ lookupOrRequest("Haus")
//     │     ├─ Found + ready   → addWordToCollection → AsyncData(word)   ✓
//     │     ├─ Found + pending ─────────────────────────────────────────┐
//     │     └─ Not found       → writes pending entry to Firestore      │
//     │                                                                 │
//     └─────────────────── watchEntry(entryId) ────────────────────────┘
//                                │
//                          status == ready   → addWordToCollection → AsyncData(word)  ✓
//                          status == failed  → AsyncError(errorMessage)               ✗

class AddWordNotifier extends AsyncNotifier<Word?> {
  StreamSubscription<DictionaryEntry?>? _entrySub;

  // Bumped on every submit() call. A pending callback only applies its
  // result if it's still the most recent submission, so an overlapping
  // submit() can't have its result clobbered by a stale one that resolves
  // later.
  int _generation = 0;

  @override
  FutureOr<Word?> build() {
    ref.onDispose(() => _entrySub?.cancel());
    return null; // idle
  }

  Future<void> submit({
    required String term,
    required String collectionId,
  }) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) {
      state = AsyncError(
        const RepositoryException('Not authenticated'),
        StackTrace.current,
      );
      return;
    }

    final generation = ++_generation;
    state = const AsyncLoading();
    _entrySub?.cancel();

    final dictionaryRepo = ref.read(dictionaryRepositoryProvider);
    final collectionRepo = ref.read(collectionRepositoryProvider);

    try {
      final entry = await dictionaryRepo.lookupOrRequest(term);
      if (generation != _generation) return; // superseded by a newer submit()

      if (entry.isReady) {
        // Entry already in the global dictionary — add immediately.
        final word = await collectionRepo.addWordToCollection(
          userId: userId,
          collectionId: collectionId,
          entry: entry,
        );
        _emit(generation, AsyncData(word));
        return;
      }

      if (entry.isFailed) {
        _emit(
          generation,
          AsyncError(
            RepositoryException(entry.errorMessage ?? 'Generation failed'),
            StackTrace.current,
          ),
        );
        return;
      }

      // Entry is pending — subscribe and add once the Cloud Function finishes.
      _entrySub = dictionaryRepo.watchEntry(entry.id).listen(
        (updated) async {
          if (updated == null || generation != _generation) return;
          if (updated.isReady) {
            _entrySub?.cancel();
            try {
              final word = await collectionRepo.addWordToCollection(
                userId: userId,
                collectionId: collectionId,
                entry: updated,
              );
              _emit(generation, AsyncData(word));
            } catch (e, st) {
              _emit(generation, AsyncError(e, st));
            }
          } else if (updated.isFailed) {
            _entrySub?.cancel();
            _emit(
              generation,
              AsyncError(
                RepositoryException(
                    updated.errorMessage ?? 'AI generation failed'),
                StackTrace.current,
              ),
            );
          }
        },
        onError: (Object e, StackTrace st) {
          _entrySub?.cancel();
          _emit(generation, AsyncError(e, st));
        },
      );
    } catch (e, st) {
      _emit(generation, AsyncError(e, st));
    }
  }

  // Applies [value] only if [generation] is still current and the notifier
  // hasn't been disposed (e.g. the add-word screen was already left) —
  // mutating `state` after disposal throws in Riverpod 3.
  void _emit(int generation, AsyncValue<Word?> value) {
    if (generation == _generation && ref.mounted) state = value;
  }
}

/// Scoped to the add-word screen. Auto-disposes on navigation so the state
/// is always fresh for the next use.
final addWordProvider = AsyncNotifierProvider.autoDispose<AddWordNotifier, Word?>(
  AddWordNotifier.new,
);