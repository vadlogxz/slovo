import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/di/core_providers.dart';
import 'package:slovo/core/logging/app_logger.dart';
import 'package:slovo/feature/vocabulary/data/repositories/firebase_dictionary_repository.dart';
import 'package:slovo/feature/vocabulary/domain/models/dictionary_lookup_state.dart';
import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';

class DictionaryLookupNotifier extends Notifier<DictionaryLookupState> {
  StreamSubscription<DictionaryEntry>? _generationSub;

  @override
  DictionaryLookupState build() {
    ref.onDispose(() => _generationSub?.cancel());
    return DictionaryLookupIdle();
  }

  Future<void> search(String term) async {
    AppLogger.debug('Searching for word: $term');
    await _generationSub?.cancel();
    state = DictionaryLookupSearching();
    final normalizeKey = DictionaryEntry.normalizeSearchKey(term);
    try {
      final entries = await ref
          .read(dictionaryRepositoryProvider)
          .searchByKey(normalizeKey);
      AppLogger.info('Found entries for "$term": ${entries.length}');
      if (entries.isEmpty) {
        state = DictionaryLookupGenerating(term: term);
        AppLogger.info('Generating new dictionary entry for "$term"');
        final generatedEntry = ref
            .read(dictionaryRepositoryProvider)
            .generate(term);
        _generationSub = generatedEntry.listen(
          (entry) {
            AppLogger.info('Generated dictionary entry for "$term": $entry');
            if (entry.isReady) {
              state = DictionaryLookupReady(entry: entry);
            } else if (entry.isFailed) {
              state = DictionaryLookupFailed(entry.errorMessage ?? 'Unknown error');
            }
          },
          onError: (error, stackTrace) {
            AppLogger.error('Error occurred while generating dictionary entry for "$term": $error');
            state = DictionaryLookupFailed(error.toString());
          },
        );
      } else if (entries.length == 1) {
        AppLogger.info('Found single entry for "$term": ${entries.first}');
        state = DictionaryLookupReady(entry: entries.first);
      } else {
        AppLogger.info('Found multiple entries for "$term": ${entries.length}');
        state = DictionaryLookupCandidates(candidates: entries);
      }
    } catch (e) {
      AppLogger.error('Error occurred while searching for word "$term": $e');
      state = DictionaryLookupFailed(e.toString());
    }
  }
}

final addWordProvider = NotifierProvider<DictionaryLookupNotifier, DictionaryLookupState>(
  DictionaryLookupNotifier.new,
);

final dictionaryRepositoryProvider = Provider<FirebaseDictionaryRepository>((
  ref,
) {
  return FirebaseDictionaryRepository(firestore: ref.read(firestoreProvider));
});
