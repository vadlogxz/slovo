import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slovo/core/utils/enum_from_name.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';

enum GenerationStatus {
  pending,
  ready,
  failed;

  static GenerationStatus fromString(String? value) =>
      enumFromName(values, value) ?? GenerationStatus.pending;
}

class DictionaryEntry {
  const DictionaryEntry({
    required this.id,
    required this.term,
    required this.searchKey,
    required this.status,
    required this.createdAt,
    this.errorMessage,
    this.linguistics,
  });

  final String id;
  final String term;
  final String searchKey;
  final GenerationStatus status;
  final DateTime createdAt;
  final String? errorMessage;

  // Populated only when status == ready.
  final WordLinguistics? linguistics;

  bool get isReady => status == GenerationStatus.ready;
  bool get isPending => status == GenerationStatus.pending;
  bool get isFailed => status == GenerationStatus.failed;

  // Delegation getters — valid only when isReady.
  String? get definition => linguistics?.definition;
  String? get example => linguistics?.example;
  String? get exampleTranslation => linguistics?.exampleTranslation;
  WordType? get wordType => linguistics?.wordType;
  CefrLevel? get level => linguistics?.level;
  NounData? get nounData => linguistics?.nounData;
  VerbData? get verbData => linguistics?.verbData;
  AdjectiveData? get adjectiveData => linguistics?.adjectiveData;

  // Converts to Word for adding to a user's collection.
  // [wordId] must be a unique ID for this word within the collection's words
  // subcollection (the repository uses the dictionary entry's own id, so
  // re-adding the same term resolves to the same doc instead of a duplicate).
  Word? toWord({required String wordId, required String collectionId}) {
    if (!isReady || linguistics == null) return null;
    return Word(
      id: wordId,
      collectionId: collectionId,
      dictionaryEntryId: id,
      term: term,
      linguistics: linguistics!,
      createdAt: DateTime.now(),
    );
  }

  factory DictionaryEntry.pending({required String id, required String term, required String searchKey}) => DictionaryEntry(
    id: id,
    term: term,
    searchKey: searchKey,
    status: GenerationStatus.pending,
    createdAt: DateTime.now(),
  );

  factory DictionaryEntry.fromJson(Map<String, dynamic> json, String id){
    return DictionaryEntry(
      id: id,
      term: json['term'] as String,
      searchKey: json['searchKey'] as String,
      status: GenerationStatus.fromString(json['status'] as String?),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      errorMessage: json['errorMessage'] as String?,
      linguistics: json['definition'] != null ? WordLinguistics.fromJson(json) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'term': term,
      'searchKey': searchKey,
      'status': status.name,
      'createdAt': Timestamp.fromDate(createdAt),
      if (errorMessage != null) 'errorMessage': errorMessage,
      if (linguistics != null) ...linguistics!.toJson(),
    };
  }

  static String normalizeSearchKey(String raw){
    final parts = raw.trim().toLowerCase().split(RegExp(r'\s+'));
    final articles = {'der', 'die', 'das'};
    if(parts.length == 2 && articles.contains(parts.first)){
      return parts[1];
    }
    return parts.join(' ');
  }
}
