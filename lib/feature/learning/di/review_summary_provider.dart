import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/learning/di/word_progress_provider.dart';

final reviewSummaryProvider = FutureProvider<ReviewSummary>((ref) async {
  final userId = ref.read(currentUserIdProvider);
  if (userId == null) {
    return ReviewSummary(clearedToday: 0, nextDue: null, nextBatchCount: 0);
  }

  final allProgress = await ref
      .read(wordProgressProvider)
      .getAllProgress(userId: userId);

  final today = DateTime.now();

  bool isToday(DateTime? d) =>
      d != null &&
      d.year == today.year &&
      d.month == today.month &&
      d.day == today.day;

  final clearedToday = allProgress
      .where((p) => isToday(p.fsrsCard.lastReview))
      .length;

  final upcoming =
      allProgress.where((p) => p.fsrsCard.due.isAfter(today)).toList()
        ..sort((a, b) => a.fsrsCard.due.compareTo(b.fsrsCard.due));

  final nextDue = upcoming.isEmpty ? null : upcoming.first.fsrsCard.due;
  final nextBatch = nextDue == null
      ? 0
      : upcoming.where((p) => p.fsrsCard.due == nextDue).length;

  return ReviewSummary(
    clearedToday: clearedToday,
    nextDue: nextDue,
    nextBatchCount: nextBatch,
  );
});



class ReviewSummary {
  ReviewSummary({
    required this.clearedToday,
    required this.nextDue,
    required this.nextBatchCount,
  });

  final int clearedToday;
  final DateTime? nextDue;
  final int nextBatchCount;
}
