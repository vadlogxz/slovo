import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';

sealed class DictionaryLookupState {
  const DictionaryLookupState();
}

class DictionaryLookupIdle extends DictionaryLookupState {
  DictionaryLookupIdle();
}

class DictionaryLookupSearching extends DictionaryLookupState {
  DictionaryLookupSearching();
}

class DictionaryLookupCandidates extends DictionaryLookupState {
  DictionaryLookupCandidates({required this.candidates});

  final List<DictionaryEntry> candidates;
}

class DictionaryLookupNotFound extends DictionaryLookupState {
  DictionaryLookupNotFound(this.term);
  final String term;
}

class DictionaryLookupGenerating extends DictionaryLookupState {
  DictionaryLookupGenerating({required this.term});

  final String term;
}

class DictionaryLookupReady extends DictionaryLookupState {
  DictionaryLookupReady({required this.entry});

  final DictionaryEntry entry;
}

class DictionaryLookupFailed extends DictionaryLookupState {
  const DictionaryLookupFailed(this.message);

  final String message;
}
