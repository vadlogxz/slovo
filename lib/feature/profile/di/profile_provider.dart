import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/feature/profile/domain/models/user_profile.dart';

final profileProvider = Provider<UserProfile>((ref) => UserProfile(
  uid: 'mock-user',
  streak: 4,
  dailyGoalMinutes: 15,
));