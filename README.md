# Slovo

A German vocabulary learning app — search or AI-generate dictionary entries,
save them into your own collections, and study them from there.

## Stack

- **Flutter** + **Riverpod** — feature-first structure
  (`lib/feature/<name>/{data,di,domain,presentation}`)
- **Firebase** — Auth (Google Sign-In), Firestore, Cloud Functions
- **OpenAI** (via Cloud Functions) — generates dictionary entries (definition,
  example sentence, grammar data) for German words/phrases not yet in the
  shared dictionary

## Features

- **Auth & onboarding** — Google sign-in, guided first-run flow
- **Vocabulary** — search a global, shared German dictionary by term; if it's
  not there yet, generate it with AI; save it into one or more of your own
  collections
- **Collections** — organize saved words, word count kept in sync server-side
- **Profile** — backed by a real Firestore-stored user profile

## Backend

Cloud Functions live in [`functions/`](functions/README.md) — see that README
for what each function does and why it has to run server-side.

## Project history

This repo went through two passes. The first — squashed into a single
`chore:` commit at the root of the git history — validated the full feature
set end to end (auth, collections, AI dictionary, spaced-repetition study
sessions). It was then deliberately stripped back to UI mocks (keeping only
Auth/Onboarding real) and rebuilt feature-by-feature by hand, to actually
learn Flutter/Riverpod/Firebase rather than ship fast a second time.

Most of the Flutter app in this rebuild was hand-written by the project
owner while learning, with [Claude Code](https://claude.com/claude-code)
acting as a reviewer/mentor rather than the author. The backend
(`functions/`) and a couple of specific infrastructure pieces (the shared
`AppButton` style refactor, the git history cleanup above) were implemented
directly by Claude Code instead — see
[`functions/README.md`](functions/README.md) and the commit history for
exactly which parts.

## Getting started

1. `flutter pub get`
2. Copy `config/dev.example.json` to `config/dev.json` and fill in your own
   Firebase web client ID / API base URL (gitignored, never committed).
3. `flutter run`

The backend needs its own setup — see [`functions/README.md`](functions/README.md).
