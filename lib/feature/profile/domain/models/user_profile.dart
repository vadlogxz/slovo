import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'] as String,
      displayName: json['displayName'] as String?,
      streak: json['streak'] as int? ?? 0,
      lastActiveDate: (json['lastActiveDate'] as Timestamp?)?.toDate(),
      dailyGoalMinutes:
          json['dailyGoalMinutes'] as int? ?? DailyGoal.regular.minutes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'displayName': displayName,
      'streak': streak,
      'lastActiveDate': lastActiveDate,
      'dailyGoalMinutes': dailyGoalMinutes,
    };
  }

  UserProfile copyWith({
    String? displayName,
    int? streak,
    DateTime? lastActiveDate,
    int? dailyGoalMinutes,
  }) {
    return UserProfile(
      uid: uid,
      displayName: displayName ?? this.displayName,
      streak: streak ?? this.streak,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      dailyGoalMinutes: dailyGoalMinutes ?? this.dailyGoalMinutes,
    );
  }
}
