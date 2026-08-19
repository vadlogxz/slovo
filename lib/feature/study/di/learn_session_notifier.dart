import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:slovo/core/error/repository_exception.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/study/di/study_provider.dart';
import 'package:slovo/feature/study/domain/models/card_progress.dart';
import 'package:slovo/feature/vocabulary/di/vocabulary_provider.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';

part 'learn_session_notifier.freezed.dart';

@freezed
abstract class LearnSessionState with _$LearnSessionState {
  const LearnSessionState._();

  const factory LearnSessionState({
    required List<(Word, CardProgress)> queue,
    required int currentIndex,
    required bool revealed,
  }) = _LearnSessionState;

  bool get isComplete => currentIndex >= queue.length;
  (Word, CardProgress)? get current => isComplete ? null : queue[currentIndex];
  int get total => queue.length;
}

class LearnSessionNotifier extends AsyncNotifier<LearnSessionState> {
  LearnSessionNotifier(this.collectionId);

  // Riverpod 3's family notifiers receive their argument via the
  // constructor (passed by the family's create callback below), not as a
  // build() parameter.
  final String collectionId;

  // Guards against a second rate() call (double-tap/double-swipe) firing
  // while a previous one's Firestore save is still in flight — without this,
  // both calls read the same pre-await state and the second write would
  // silently clobber the first's session-advance.
  bool _isRating = false;

  @override
  Future<LearnSessionState> build() async {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) {
      return const LearnSessionState(
        queue: [],
        currentIndex: 0,
        revealed: false,
      );
    }

    // Kick off both reads before awaiting either, so they run in parallel
    // instead of round-tripping to Firestore one after the other.
    final wordsFuture = ref
        .read(collectionRepositoryProvider)
        .watchCollectionWords(userId, collectionId)
        .first;
    final progressFuture = ref
        .read(cardProgressRepositoryProvider)
        .watchCollectionProgress(userId, collectionId)
        .first;
    final words = await wordsFuture;
    final progressList = await progressFuture;
    final progressByWordId = {for (final p in progressList) p.wordId: p};

    final queue = [
      for (final word in words)
        if (progressByWordId[word.id].isDueOrNew)
          (
            word,
            progressByWordId[word.id] ??
                CardProgress.fresh(
                  wordId: word.id,
                  collectionId: collectionId,
                ),
          ),
    ];

    return LearnSessionState(queue: queue, currentIndex: 0, revealed: false);
  }

  void reveal() {
    final current = state.asData?.value;
    if (current == null || current.revealed) return;
    state = AsyncData(current.copyWith(revealed: true));
  }

  Future<void> rate(fsrs.Rating rating) async {
    if (_isRating) return;
    final current = state.asData?.value;
    if (current == null || current.isComplete) return;
    final (_, progress) = current.current!;

    _isRating = true;
    try {
      final scheduler = fsrs.Scheduler();
      final result = scheduler.reviewCard(progress.card, rating);
      final updated = progress.withCard(result.card);

      final userId = ref.read(currentUserIdProvider);
      if (userId == null) {
        state = AsyncError(
          const RepositoryException('Not authenticated'),
          StackTrace.current,
        );
        return;
      }

      final masteryDelta = switch ((progress.isMastered, updated.isMastered)) {
        (false, true) => 1,
        (true, false) => -1,
        _ => 0,
      };
      // Progress and the collection's wordsLearned counter are written
      // together atomically — see saveProgress's contract.
      await ref
          .read(cardProgressRepositoryProvider)
          .saveProgress(userId, updated, wordsLearnedDelta: masteryDelta);

      if (!ref.mounted) return;
      state = AsyncData(
        current.copyWith(
          currentIndex: current.currentIndex + 1,
          revealed: false,
        ),
      );
    } catch (e, st) {
      if (ref.mounted) state = AsyncError(e, st);
    } finally {
      _isRating = false;
    }
  }
}

/// Scoped to the learn session screen. Auto-disposes on navigation so a new
/// session always starts fresh.
final learnSessionProvider = AsyncNotifierProvider.autoDispose
    .family<LearnSessionNotifier, LearnSessionState, String>(
      (collectionId) => LearnSessionNotifier(collectionId),
    );
