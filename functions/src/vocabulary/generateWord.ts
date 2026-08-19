import { onDocumentWritten } from "firebase-functions/v2/firestore";
import { logger } from "firebase-functions";
import OpenAI from "openai";
import { defineSecret } from "firebase-functions/params";
import { SYSTEM_PROMPT, userMessage } from "./prompt";
import type { DictionaryEntry, NounData, VerbData, AdjectiveData, WordType } from "../types";

const openaiKey = defineSecret("OPENAI_API_KEY");

const VALID_WORD_TYPES: readonly WordType[] = [
  "noun", "verb", "adjective", "adverb",
  "preposition", "conjunction", "pronoun", "phrase",
];

// ── Helpers ───────────────────────────────────────────────────────────────────

function stripNulls(obj: Record<string, unknown>): Record<string, unknown> {
  return Object.fromEntries(
    Object.entries(obj).filter(([, v]) => v !== null && v !== undefined)
  );
}

function isCompleteWordData(
  data: Omit<DictionaryEntry, "status" | "createdAt">
): boolean {
  if (
    typeof data.definition !== "string" ||
    data.definition.trim().length === 0 ||
    typeof data.wordType !== "string" ||
    !VALID_WORD_TYPES.includes(data.wordType as WordType)
  ) {
    return false;
  }

  // The Dart client casts VerbData.partizip2 as a non-nullable String —
  // a "ready" verb entry without it crashes every future read of this term.
  if (data.wordType === "verb") {
    const partizip2 = data.verbData?.partizip2;
    if (typeof partizip2 !== "string" || partizip2.trim().length === 0) {
      return false;
    }
  }

  return true;
}

async function callOpenAI(
  client: OpenAI,
  term: string
): Promise<Omit<DictionaryEntry, "status" | "createdAt">> {
  const completion = await client.chat.completions.create({
    model: "gpt-4o-mini",
    response_format: { type: "json_object" },
    temperature: 0,
    max_tokens: 512,
    messages: [
      { role: "system", content: SYSTEM_PROMPT },
      { role: "user", content: userMessage(term) },
    ],
  });

  const raw = JSON.parse(completion.choices[0].message.content ?? "{}");

  return {
    term: raw.term ?? term,
    definition: raw.definition,
    example: raw.example,
    exampleTranslation: raw.exampleTranslation,
    wordType: raw.wordType,
    level: raw.level,
    nounData: raw.nounData
      ? (stripNulls(raw.nounData) as unknown as NounData)
      : undefined,
    verbData: raw.verbData
      ? (stripNulls(raw.verbData) as unknown as VerbData)
      : undefined,
    adjectiveData: raw.adjectiveData
      ? (stripNulls(raw.adjectiveData) as unknown as AdjectiveData)
      : undefined,
  };
}

// ── Cloud Function ─────────────────────────────────────────────────────────────

/**
 * Fills in AI-generated linguistic data for a pending dictionary entry.
 *
 * Triggers on both creation and update of /dictionary/{entryId} so that
 * FirestoreDictionaryRepository.lookupOrRequest can reset a failed or
 * stuck-pending entry back to "pending" and have generation retried, not
 * just on the initial create. Writes back status "ready" + linguistic
 * data, or status "failed" + errorMessage.
 */
export const generateWord = onDocumentWritten(
  { document: "dictionary/{entryId}", secrets: [openaiKey], region: "europe-west1" },
  async (event) => {
    const snap = event.data?.after;
    if (!snap?.exists) return;

    const data = snap.data() as DictionaryEntry;
    if (data.status !== "pending") return;

    const term = data.term;

    try {
      const client = new OpenAI({ apiKey: openaiKey.value() });
      const wordData = await callOpenAI(client, term);

      if (!isCompleteWordData(wordData)) {
        throw new Error(
          `OpenAI response for "${term}" is missing required fields`
        );
      }

      // createdAt is intentionally left untouched — it records when the
      // entry was first requested, not when generation finished.
      const entry = stripNulls({
        ...(wordData as Record<string, unknown>),
        status: "ready",
      });

      await snap.ref.update(entry);
    } catch (err) {
      logger.error(`generateWord failed for "${term}"`, err);
      await snap.ref.update({
        status: "failed",
        errorMessage: err instanceof Error ? err.message : String(err),
      });
    }
  }
);