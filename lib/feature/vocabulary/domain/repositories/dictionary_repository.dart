import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';

abstract interface class DictionaryRepository {
  /// Looks up a dictionary entry by term (case-insensitive).
  ///
  /// If a ready entry exists, returns it immediately. If it does not exist,
  /// or the existing entry is [GenerationStatus.failed] or has been
  /// [GenerationStatus.pending] for longer than the retry threshold, writes
  /// (or resets) a pending entry to (re)trigger server-side AI generation.
  /// The caller should then subscribe to [watchEntry] and add to the
  /// collection once status becomes [GenerationStatus.ready].
  Future<DictionaryEntry> lookupOrRequest(String term);

  /// Streams live updates for a single entry.
  /// Used to observe the pending → ready/failed transition after [lookupOrRequest].
  Stream<DictionaryEntry?> watchEntry(String entryId);

  /// Prefix search on [query] against all [GenerationStatus.ready] entries.
  /// Returns up to [limit] results ordered alphabetically.
  /// An empty [query] returns an empty list.
  Future<List<DictionaryEntry>> searchByPrefix(String query, {int limit = 20});
}