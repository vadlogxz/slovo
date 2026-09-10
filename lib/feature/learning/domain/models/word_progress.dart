import 'package:fsrs/fsrs.dart';
import 'package:slovo/feature/learning/presentation/widgets/recall_buttons.dart';

class WordProgress {
  WordProgress({
    required this.dictionaryEntryId,
    required this.lastRating,
    required this.reviewedCount,
    required this.fsrsCard,
  });

  final String dictionaryEntryId;
  final RecallRating lastRating;
  final int reviewedCount;
  final Card fsrsCard;

  factory WordProgress.fromJson(Map<String, dynamic> json) {
    return WordProgress(
      dictionaryEntryId: json['dictionaryEntryId'] as String,
      lastRating: RecallRating.values.byName(json['lastRating'] as String),
      reviewedCount: json['reviewedCount'] as int,
      fsrsCard: Card.fromMap(json['fsrsCard'] as Map<String, dynamic>),
    );
  }

  factory WordProgress.record({
    required String dictionaryEntryId,
    required RecallRating rating,
    required Card fsrsCard,
    int previousReviewCount = 0,
  }) => WordProgress(
    dictionaryEntryId: dictionaryEntryId,
    lastRating: rating,
    reviewedCount: previousReviewCount + 1,
    fsrsCard: fsrsCard,
  );

  Map<String, dynamic> toJson() {
    return {
      'dictionaryEntryId': dictionaryEntryId,
      'lastRating': lastRating.name,
      'reviewedCount': reviewedCount,
      'fsrsCard': fsrsCard.toMap(),
    };
  }

  WordProgress copyWith({
    String? dictionaryEntryId,
    RecallRating? lastRating,
    int? reviewedCount,
    Card? fsrsCard,
  }) {
    return WordProgress(
      dictionaryEntryId: dictionaryEntryId ?? this.dictionaryEntryId,
      lastRating: lastRating ?? this.lastRating,
      reviewedCount: reviewedCount ?? this.reviewedCount,
      fsrsCard: fsrsCard ?? this.fsrsCard,
    );
  }

}