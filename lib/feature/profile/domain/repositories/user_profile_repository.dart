import 'package:slovo/feature/profile/domain/models/user_profile.dart';

abstract class UserProfileRepository {
  Future<UserProfile?> getUserProfile(String uid);
  Future<void> saveUserProfile(UserProfile profile);
}