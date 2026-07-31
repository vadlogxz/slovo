import '_.dart';

class OnboardingData {
  final DailyGoal dailyGoal;
  final String userName;

  const OnboardingData({
    this.dailyGoal = DailyGoal.regular,
    this.userName = '',
  });

  OnboardingData copyWith({DailyGoal? dailyGoal, String? userName}) => OnboardingData(
    dailyGoal: dailyGoal ?? this.dailyGoal,
    userName: userName ?? this.userName,
  );
}
