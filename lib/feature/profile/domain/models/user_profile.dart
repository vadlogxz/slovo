import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String uid,
    required String displayName,
    @Default(0) int streak,
    DateTime? lastActiveDate,
    // Must match DailyGoal.regular.minutes (the "regular" onboarding goal) —
    // freezed's @Default can't evaluate a cross-file enum field access, so
    // this literal has to be kept in sync by hand.
    @Default(10) int dailyGoalMinutes,
  }) = _UserProfile;
}
