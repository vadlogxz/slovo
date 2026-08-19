# Cloud Functions

Backend for the Slovo app. Everything here runs server-side because it
either needs a secret (OpenAI key) or needs to be authoritative regardless of
which client wrote the data that triggered it.

## Functions

### `generateWord` (`src/vocabulary/generateWord.ts`)

Triggers on write to `dictionary/{entryId}`. When a client creates a
`status: "pending"` stub (or resets a stuck/failed one back to `pending`),
this calls OpenAI to fill in the definition, example sentence, word type,
CEFR level, and type-specific grammar data (noun gender/plural, verb
conjugation, adjective forms), then writes `status: "ready"` — or
`status: "failed"` with an error message if the response didn't come back
complete enough to trust.

It also recomputes `searchKey` from the (possibly AI-corrected) `term`
before writing back, so a corrected spelling stays findable by its correct
spelling, not just by whatever typo the entry was originally requested with.

### `onWordsChanged` (`src/vocabulary/updateWordCount.ts`)

Triggers on any create/update/delete under
`users/{userId}/collections/{collectionId}/words/{wordId}`. Re-counts the
`words` subcollection from scratch and writes the result to the parent
collection's `wordCount`, rather than incrementing/decrementing a running
total — self-healing: if the count ever drifts from reality, the next write
recomputes truth instead of adjusting an already-wrong number.

### Prompt (`src/vocabulary/prompt.ts`)

The system prompt sent to OpenAI for `generateWord`. Notably enforces
Ukrainian-only translations with an explicit Russian prohibition — the two
languages are close enough that the model would otherwise occasionally
answer in Russian.

## Setup

```bash
cd functions
npm install
firebase functions:secrets:set OPENAI_API_KEY
npm run build
firebase deploy --only functions
```

## Authorship note

The `searchKey`-consistency fix and the Ukrainian-language prompt guard in
`generateWord` / `prompt.ts`, and the entire `onWordsChanged` word-count
trigger, were implemented directly by
[Claude Code](https://claude.com/claude-code) (Anthropic's AI coding agent),
not hand-written by the project owner. Backend/infrastructure work like this
was explicitly out of scope for the "learn Flutter by writing it myself"
approach used for the rest of this repo — see the project README and the
git history for the exact commits.
