import 'package:slovo/feature/profile/domain/models/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile> getOrCreateUserProfile(String uid);

  Future<void> updateUserProfile(UserProfile userProfile);
}
