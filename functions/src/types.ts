// Mirrors Dart Word model enums and sub-types

export type WordType =
  | "noun" | "verb" | "adjective" | "adverb"
  | "preposition" | "conjunction" | "pronoun" | "phrase";

export type CefrLevel = "a1" | "a2" | "b1" | "b2" | "c1" | "c2";

export type NounGender = "der" | "die" | "das";

export interface NounData {
  gender: NounGender;
  plural?: string;
  genitive?: string;
}

export interface VerbConjugation {
  ich: string;
  du: string;
  erSieEs: string;
  wir: string;
  ihr: string;
  sieSie: string;
}

export interface VerbData {
  partizip2: string;
  hilfsVerb: "haben" | "sein";
  isTrennbar: boolean;
  trennbarPrefix?: string;
  isIrregular: boolean;
  praeteritum?: string;
  conjugation?: VerbConjugation; // only for irregular verbs with vowel changes
}

export interface AdjectiveData {
  komparativ?: string;
  superlativ?: string;
}

// Mirrors Dart DictionaryEntry
export type GenerationStatus = "pending" | "ready" | "failed";

export interface DictionaryEntry {
  term: string;
  searchKey: string;
  status: GenerationStatus;
  createdAt: FirebaseFirestore.Timestamp;
  errorMessage?: string;
  definition?: string;
  example?: string;
  exampleTranslation?: string;
  wordType?: WordType;
  level?: CefrLevel;
  nounData?: NounData;
  verbData?: VerbData;
  adjectiveData?: AdjectiveData;
}