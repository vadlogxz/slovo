import 'package:slovo/core/utils/enum_from_name.dart';

// ── Enums ─────────────────────────────────────────────────────────────────────

enum WordType {
  noun,
  verb,
  adjective,
  adverb,
  preposition,
  conjunction,
  pronoun,
  phrase;

  static WordType? fromString(String? value) => enumFromName(values, value);
}

// Nullable-aware so callers can do `word.wordType.label` without a null
// check — an entry with no wordType yet just reads as "Word".
//
// Single source of truth for every display variant of a WordType label —
// add a new WordType case to `_labels` once, not in separate per-screen
// switch statements.
extension WordTypeLabel on WordType? {
  ({String en, String abbreviation, String de}) get _labels => switch (this) {
    WordType.noun => (en: 'Noun', abbreviation: 'noun', de: 'Substantiv'),
    WordType.verb => (en: 'Verb', abbreviation: 'verb', de: 'Verb'),
    WordType.adjective => (
      en: 'Adjective',
      abbreviation: 'adj',
      de: 'Adjektiv',
    ),
    WordType.adverb => (en: 'Adverb', abbreviation: 'adv', de: 'Adverb'),
    WordType.preposition => (
      en: 'Preposition',
      abbreviation: 'präp',
      de: 'Präposition',
    ),
    WordType.conjunction => (
      en: 'Conjunction',
      abbreviation: 'konj',
      de: 'Konjunktion',
    ),
    WordType.pronoun => (en: 'Pronoun', abbreviation: 'pron', de: 'Pronomen'),
    WordType.phrase => (en: 'Phrase', abbreviation: 'phrase', de: 'Phrase'),
    null => (en: 'Word', abbreviation: '', de: 'Wort'),
  };

  /// English display label, e.g. "Noun". Falls back to "Word" when unset.
  String get label => _labels.en;

  /// Short lowercase abbreviation for compact UI (e.g. list-item badges).
  /// Null when there's no wordType, so callers can fall back to a plain
  /// placeholder instead of showing an empty badge.
  String? get abbreviation => this == null ? null : _labels.abbreviation;

  /// German display label, e.g. "Substantiv". Falls back to "Wort" when unset.
  String get labelDe => _labels.de;
}

enum NounGender {
  der,
  die,
  das;

  static NounGender? fromString(String? value) => enumFromName(values, value);
}

enum HilfsVerb {
  haben,
  sein;

  static HilfsVerb fromString(String value) =>
      value == 'sein' ? HilfsVerb.sein : HilfsVerb.haben;
}

enum CefrLevel {
  a1,
  a2,
  b1,
  b2,
  c1,
  c2;

  static CefrLevel? fromString(String? value) => enumFromName(values, value);

  String get label => name.toUpperCase();
}

// ── Type-specific data classes ─────────────────────────────────────────────────
class NounData{

  const NounData({
    required this.gender,
    this.plural,
    this.genitive,
  });

  final NounGender gender;
  final String? plural;
  final String? genitive;


  factory NounData.fromMap(Map<String, dynamic> m) => NounData(
    gender: NounGender.fromString(m['gender'] as String?) ?? NounGender.das,
    plural: m['plural'] as String?,
    genitive: m['genitive'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'gender': gender.name,
    if (plural != null) 'plural': plural,
    if (genitive != null) 'genitive': genitive,
  };
}

class VerbConjugation{
  const VerbConjugation({
    required this.ich,
    required this.du,
    required this.erSieEs,
    required this.wir,
    required this.ihr,
    required this.sieSie,
  });

  final String ich;
  final String du;
  final String erSieEs;
  final String wir;
  final String ihr;
  final String sieSie;

  factory VerbConjugation.fromMap(Map<String, dynamic> m) => VerbConjugation(
    ich: m['ich'] as String,
    du: m['du'] as String,
    erSieEs: m['erSieEs'] as String,
    wir: m['wir'] as String,
    ihr: m['ihr'] as String,
    sieSie: m['sieSie'] as String,
  );

  Map<String, dynamic> toMap() => {
    'ich': ich,
    'du': du,
    'erSieEs': erSieEs,
    'wir': wir,
    'ihr': ihr,
    'sieSie': sieSie,
  };
}


class VerbData {
  const VerbData({
    required this.partizip2,
    required this.hilfsVerb,
    this.isTrennbar = false,
    this.trennbarPrefix,
    this.isIrregular = false,
    this.praeteritum,
    this.conjugation,
  });

  final String partizip2;
  final HilfsVerb hilfsVerb;
  final bool isTrennbar;
  final String? trennbarPrefix;
  final bool isIrregular;
  final String? praeteritum;
  final VerbConjugation? conjugation;

  factory VerbData.fromMap(Map<String, dynamic> m) => VerbData(
    partizip2: m['partizip2'] as String,
    hilfsVerb: HilfsVerb.fromString(m['hilfsVerb'] as String? ?? 'haben'),
    isTrennbar: m['isTrennbar'] as bool? ?? false,
    trennbarPrefix: m['trennbarPrefix'] as String?,
    isIrregular: m['isIrregular'] as bool? ?? false,
    praeteritum: m['praeteritum'] as String?,
    conjugation: m['conjugation'] != null
        ? VerbConjugation.fromMap(
            Map<String, dynamic>.from(m['conjugation'] as Map),
          )
        : null,
  );

  Map<String, dynamic> toMap() => {
    'partizip2': partizip2,
    'hilfsVerb': hilfsVerb.name,
    'isTrennbar': isTrennbar,
    if (trennbarPrefix != null) 'trennbarPrefix': trennbarPrefix,
    'isIrregular': isIrregular,
    if (praeteritum != null) 'praeteritum': praeteritum,
    if (conjugation != null) 'conjugation': conjugation!.toMap(),
  };
}

class AdjectiveData{

  const AdjectiveData({
    this.komparativ,
    this.superlativ,
  });

  final String? komparativ;
  final String? superlativ;

  factory AdjectiveData.fromMap(Map<String, dynamic> m) => AdjectiveData(
    komparativ: m['komparativ'] as String?,
    superlativ: m['superlativ'] as String?,
  );

  Map<String, dynamic> toMap() => {
    if (komparativ != null) 'komparativ': komparativ,
    if (superlativ != null) 'superlativ': superlativ,
  };
}

// ── WordLinguistics ───────────────────────────────────────────────────────────
//
// Shared linguistic payload used by both Word (user copy) and DictionaryEntry
// (global canon). Extracting it here eliminates duplicated fromMap/toMap logic.

class WordLinguistics{
  const  WordLinguistics({
    // Primary translation or explanation.
    required this.definition,
    // Example sentence in German.
    this.example,
    // English translation of [example]. Only present on entries generated
    // after this field was added — older entries leave it null.
    this.exampleTranslation,
    this.wordType,
    this.level,
    // Exactly one of these is non-null, matching wordType.
    this.nounData,
    this.verbData,
    this.adjectiveData,
  });

  final String definition;
  final String? example;
  final String? exampleTranslation;
  final WordType? wordType;
  final CefrLevel? level;
  final NounData? nounData;
  final VerbData? verbData;
  final AdjectiveData? adjectiveData;

  factory WordLinguistics.fromMap(Map<String, dynamic> data) {
    final definition = data['definition'] as String?;
    if (definition == null) {
      throw FormatException(
        'WordLinguistics.fromMap: a "ready" entry is missing its required '
        '"definition" field (data: $data)',
      );
    }
    return WordLinguistics(
      definition: definition,
      example: data['example'] as String?,
      exampleTranslation: data['exampleTranslation'] as String?,
      wordType: WordType.fromString(data['wordType'] as String?),
      level: CefrLevel.fromString(data['level'] as String?),
      nounData: data['nounData'] != null
          ? NounData.fromMap(Map<String, dynamic>.from(data['nounData'] as Map))
          : null,
      verbData: data['verbData'] != null
          ? VerbData.fromMap(Map<String, dynamic>.from(data['verbData'] as Map))
          : null,
      adjectiveData: data['adjectiveData'] != null
          ? AdjectiveData.fromMap(
              Map<String, dynamic>.from(data['adjectiveData'] as Map),
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() => {
    'definition': definition,
    if (example != null) 'example': example,
    if (exampleTranslation != null) 'exampleTranslation': exampleTranslation,
    if (wordType != null) 'wordType': wordType!.name,
    if (level != null) 'level': level!.name,
    if (nounData != null) 'nounData': nounData!.toMap(),
    if (verbData != null) 'verbData': verbData!.toMap(),
    if (adjectiveData != null) 'adjectiveData': adjectiveData!.toMap(),
  };
}

// ── Word ──────────────────────────────────────────────────────────────────────

class Word{
  const Word({
    required this.id,
    required this.collectionId,
    required this.term,
    required this.linguistics,
    required this.createdAt,
    // Links back to the global dictionary entry this word was sourced from.
    this.dictionaryEntryId,
  });

  final String id;
  final String collectionId;
  final String term;
  final WordLinguistics linguistics;
  final DateTime createdAt;
  final String? dictionaryEntryId;

  // Delegation getters — keep call sites ergonomic without exposing internals.
  String get definition => linguistics.definition;
  String? get example => linguistics.example;
  String? get exampleTranslation => linguistics.exampleTranslation;
  WordType? get wordType => linguistics.wordType;
  CefrLevel? get level => linguistics.level;
  NounData? get nounData => linguistics.nounData;
  VerbData? get verbData => linguistics.verbData;
  AdjectiveData? get adjectiveData => linguistics.adjectiveData;
}
