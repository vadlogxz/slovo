import 'package:slovo/feature/onboarding/domain/models/daily_goal.dart';

class UserProfile {
  UserProfile({
    required this.uid,
    this.displayName,
    this.streak = 0,
    this.lastActiveDate,
    int? dailyGoalMinutes,
  }) : dailyGoalMinutes = dailyGoalMinutes ?? DailyGoal.regular.minutes;

  final String uid;
  String? displayName;
  int streak;
  DateTime? lastActiveDate;
  final int dailyGoalMinutes;
}
