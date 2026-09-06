import 'package:slovo/feature/learning/presentation/widgets/recall_buttons.dart';

class LearningSessionState {
  LearningSessionState({required this.currentWordIndex, required this.recallRatings});

  final int currentWordIndex;
  final Map<RecallRating, int> recallRatings;

  LearningSessionState copyWith({
    int? currentWordIndex,
    Map<RecallRating, int>? recallRatings,
  }) {
    return LearningSessionState(
      currentWordIndex: currentWordIndex ?? this.currentWordIndex,
      recallRatings: recallRatings ?? this.recallRatings,
    );
  }
}
