import 'package:fsrs/fsrs.dart' as fsrs;

class CardProgress {
  const CardProgress({
    required this.wordId,
    required this.collectionId,
    required this.card,
  });

  final String wordId;
  final String collectionId;

  // The underlying fsrs.Card holds all scheduling state.
  // Pass this directly to Scheduler.reviewCard() during a session.
  final fsrs.Card card;

  // Convenience: true when the card is due for review right now.
  bool get isDue => card.due.isBefore(DateTime.now().toUtc());

  // A card has graduated out of initial learning once FSRS considers it
  // "review" state — this is what Collection.wordsLearned counts.
  bool get isMastered => card.state == fsrs.State.review;

  // Creates a brand-new card that has never been reviewed.
  // cardId uses epoch ms — call Card.create() if collision risk matters.
  factory CardProgress.fresh({
    required String wordId,
    required String collectionId,
  }) {
    return CardProgress(
      wordId: wordId,
      collectionId: collectionId,
      card: fsrs.Card(
        cardId: DateTime.now().millisecondsSinceEpoch,
        due: DateTime.now().toUtc(),
      ),
    );
  }

  CardProgress withCard(fsrs.Card updatedCard) {
    return CardProgress(
      wordId: wordId,
      collectionId: collectionId,
      card: updatedCard,
    );
  }
}

// A word with no progress record yet has never been reviewed — every screen
// that shows due-status treats that the same as "due", so this is the single
// place that rule is expressed instead of each call site re-deriving it.
extension CardProgressDueStatus on CardProgress? {
  bool get isDueOrNew => this?.isDue ?? true;
}
