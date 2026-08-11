import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';

sealed class AddWordState {
  const AddWordState();
}

class AddWordIdle extends AddWordState {
  AddWordIdle();
}

class AddWordSearching extends AddWordState {
  AddWordSearching();
}

class AddWordCandidates extends AddWordState {
  AddWordCandidates({required this.candidates});

  final List<DictionaryEntry> candidates;
}

class AddWordGenerating extends AddWordState {
  AddWordGenerating({required this.term});

  final String term;
}

class AddWordReady extends AddWordState {
  AddWordReady({required this.entry});

  final DictionaryEntry entry;
}

class AddWordFailed extends AddWordState {
  const AddWordFailed(this.message);

  final String message;
}
