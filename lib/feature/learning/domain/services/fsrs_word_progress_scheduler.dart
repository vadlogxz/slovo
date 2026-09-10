import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:slovo/feature/learning/domain/models/word_progress.dart';
import 'package:slovo/feature/learning/domain/services/word_progress_scheduler.dart';
import 'package:slovo/feature/learning/presentation/widgets/recall_buttons.dart';

class FsrsWordProgressScheduler implements WordProgressScheduler {
  FsrsWordProgressScheduler();

  final _scheduler = fsrs.Scheduler();

  @override
  WordProgress review({
    required String dictionaryEntryId,
    required WordProgress? current,
    required RecallRating rating,
  }){
    final card = current?.fsrsCard ?? fsrs.Card(cardId: dictionaryEntryId.hashCode);
    final (card: updatedCard, reviewLog: _) = _scheduler.reviewCard(card, _toFsrsRating(rating));

    return WordProgress.record(
      dictionaryEntryId: dictionaryEntryId,
      rating: rating,
      fsrsCard: updatedCard,
      previousReviewCount: current?.reviewedCount ?? 0,
    );
   }

}

fsrs.Rating _toFsrsRating(RecallRating recallRating) {
  switch (recallRating) {
    case RecallRating.again:
      return fsrs.Rating.again;
    case RecallRating.hard:
      return fsrs.Rating.hard;
    case RecallRating.good:
      return fsrs.Rating.good;
    case RecallRating.easy:
      return fsrs.Rating.easy;
  }
}