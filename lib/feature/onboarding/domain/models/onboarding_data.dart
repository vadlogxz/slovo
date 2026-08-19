import '_.dart';

class OnboardingData {
  final DailyGoal dailyGoal;

  const OnboardingData({this.dailyGoal = DailyGoal.regular});

  OnboardingData copyWith({DailyGoal? dailyGoal}) =>
      OnboardingData(dailyGoal: dailyGoal ?? this.dailyGoal);
}
