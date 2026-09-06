import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slovo/feature/learning/presentation/widgets/recall_buttons.dart';

class WordProgress {
  WordProgress({
    required this.dictionaryEntryId,
    required this.lastRating,
    required this.lastReviewed,
    required this.reviewedCount,
  });

  final String dictionaryEntryId;
  final RecallRating lastRating;
  final DateTime lastReviewed;
  final int reviewedCount;

  factory WordProgress.fromJson(Map<String, dynamic> json) {
    return WordProgress(
      dictionaryEntryId: json['dictionaryEntryId'] as String,
      lastRating: RecallRating.values.byName(json['lastRating'] as String),
      lastReviewed: (json['lastReviewed'] as Timestamp).toDate(),
      reviewedCount: json['reviewedCount'] as int,
    );
  }

  factory WordProgress.record({
    required String dictionaryEntryId,
    required RecallRating rating,
    int previousReviewCount = 0,
  }) => WordProgress(
    dictionaryEntryId: dictionaryEntryId,
    lastRating: rating,
    lastReviewed: DateTime.now(),
    reviewedCount: previousReviewCount + 1,
  );

  Map<String, dynamic> toJson() {
    return {
      'dictionaryEntryId': dictionaryEntryId,
      'lastRating': lastRating.name,
      'lastReviewed': Timestamp.fromDate(lastReviewed),
      'reviewedCount': reviewedCount,
    };
  }

  WordProgress copyWith({
    String? dictionaryEntryId,
    RecallRating? lastRating,
    DateTime? lastReviewed,
    int? reviewedCount,
  }) {
    return WordProgress(
      dictionaryEntryId: dictionaryEntryId ?? this.dictionaryEntryId,
      lastRating: lastRating ?? this.lastRating,
      lastReviewed: lastReviewed ?? this.lastReviewed,
      reviewedCount: reviewedCount ?? this.reviewedCount,
    );
  }

}