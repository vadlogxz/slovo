import '_.dart';

class OnboardingData {
  final DailyGoal dailyGoal;
  final ReminderTime reminderTime;
  final String userName;

  const OnboardingData({
    this.dailyGoal = DailyGoal.regular,
    this.reminderTime = ReminderTime.evening,
    this.userName = '',
  });

  OnboardingData copyWith({DailyGoal? dailyGoal, String? userName, ReminderTime? reminderTime}) => OnboardingData(
    dailyGoal: dailyGoal ?? this.dailyGoal,
    userName: userName ?? this.userName,
    reminderTime: reminderTime ?? this.reminderTime
  );
}
