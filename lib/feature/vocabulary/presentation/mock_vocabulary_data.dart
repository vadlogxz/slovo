import 'package:slovo/feature/vocabulary/domain/models/collection.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection_color.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';

// Static fixture data backing the Vocabulary/Study/Home UI now that there's
// no Firestore repository behind these screens. Collection/word IDs are
// shared here so navigating between screens (list → detail → word) always
// resolves to the same item.

final mockCollections = <Collection>[
  Collection(
    id: 'mock-collection-cafe',
    ownerId: 'mock-user',
    title: 'Im Café',
    description: 'Everyday café vocabulary',
    color: CollectionColor.teal,
    wordCount: 4,
    wordsLearned: 2,
    tags: const ['beginner'],
    lastStudiedAt: DateTime.now().subtract(const Duration(days: 1)),
    createdAt: DateTime.now().subtract(const Duration(days: 10)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Collection(
    id: 'mock-collection-alltag',
    ownerId: 'mock-user',
    title: 'Alltag',
    description: 'Everyday life essentials',
    color: CollectionColor.violet,
    wordCount: 4,
    wordsLearned: 1,
    tags: const ['everyday'],
    createdAt: DateTime.now().subtract(const Duration(days: 6)),
    updatedAt: DateTime.now().subtract(const Duration(days: 3)),
  ),
];

final mockWordsByCollection = <String, List<Word>>{
  'mock-collection-cafe': [
    Word(
      id: 'mock-word-kaffee',
      collectionId: 'mock-collection-cafe',
      term: 'Kaffee',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      linguistics: const WordLinguistics(
        definition: 'coffee',
        example: 'Ich trinke gerne einen Kaffee am Morgen.',
        exampleTranslation: 'I like to drink a coffee in the morning.',
        wordType: WordType.noun,
        level: CefrLevel.a1,
        nounData: NounData(gender: NounGender.der, plural: 'Kaffees'),
      ),
    ),
    Word(
      id: 'mock-word-tasse',
      collectionId: 'mock-collection-cafe',
      term: 'Tasse',
      createdAt: DateTime.now().subtract(const Duration(days: 9)),
      linguistics: const WordLinguistics(
        definition: 'cup',
        example: 'Die Tasse ist heiß.',
        exampleTranslation: 'The cup is hot.',
        wordType: WordType.noun,
        level: CefrLevel.a1,
        nounData: NounData(gender: NounGender.die, plural: 'Tassen'),
      ),
    ),
    Word(
      id: 'mock-word-bestellen',
      collectionId: 'mock-collection-cafe',
      term: 'bestellen',
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
      linguistics: const WordLinguistics(
        definition: 'to order',
        example: 'Ich möchte einen Kuchen bestellen.',
        exampleTranslation: 'I would like to order a cake.',
        wordType: WordType.verb,
        level: CefrLevel.a2,
        verbData: VerbData(partizip2: 'bestellt', hilfsVerb: HilfsVerb.haben),
      ),
    ),
    Word(
      id: 'mock-word-suess',
      collectionId: 'mock-collection-cafe',
      term: 'süß',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      linguistics: const WordLinguistics(
        definition: 'sweet',
        example: 'Der Kuchen ist sehr süß.',
        exampleTranslation: 'The cake is very sweet.',
        wordType: WordType.adjective,
        level: CefrLevel.a1,
      ),
    ),
  ],
  'mock-collection-alltag': [
    Word(
      id: 'mock-word-haus',
      collectionId: 'mock-collection-alltag',
      term: 'Haus',
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
      linguistics: const WordLinguistics(
        definition: 'house',
        example: 'Das Haus ist groß.',
        exampleTranslation: 'The house is big.',
        wordType: WordType.noun,
        level: CefrLevel.a1,
        nounData: NounData(gender: NounGender.das, plural: 'Häuser'),
      ),
    ),
    Word(
      id: 'mock-word-gehen',
      collectionId: 'mock-collection-alltag',
      term: 'gehen',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      linguistics: const WordLinguistics(
        definition: 'to go',
        example: 'Ich gehe zur Arbeit.',
        exampleTranslation: 'I go to work.',
        wordType: WordType.verb,
        level: CefrLevel.a1,
        verbData: VerbData(
          partizip2: 'gegangen',
          hilfsVerb: HilfsVerb.sein,
          isIrregular: true,
          praeteritum: 'ging',
        ),
      ),
    ),
    Word(
      id: 'mock-word-schnell',
      collectionId: 'mock-collection-alltag',
      term: 'schnell',
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      linguistics: const WordLinguistics(
        definition: 'fast',
        example: 'Er läuft sehr schnell.',
        exampleTranslation: 'He runs very fast.',
        wordType: WordType.adjective,
        level: CefrLevel.a1,
      ),
    ),
    Word(
      id: 'mock-word-strasse',
      collectionId: 'mock-collection-alltag',
      term: 'Straße',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      linguistics: const WordLinguistics(
        definition: 'street',
        example: 'Die Straße ist lang.',
        exampleTranslation: 'The street is long.',
        wordType: WordType.noun,
        level: CefrLevel.a1,
        nounData: NounData(gender: NounGender.die, plural: 'Straßen'),
      ),
    ),
  ],
};

Collection? collectionById(String id) =>
    mockCollections.where((c) => c.id == id).firstOrNull;

List<Word> wordsOf(String collectionId) =>
    mockWordsByCollection[collectionId] ?? const [];

Word? wordById(String collectionId, String wordId) =>
    wordsOf(collectionId).where((w) => w.id == wordId).firstOrNull;
