import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/di/core_providers.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/profile/data/repositories/firebase_profile_repository.dart';
import 'package:slovo/feature/profile/domain/models/user_profile.dart';
import 'package:slovo/feature/profile/domain/repositories/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>(
      (ref) {
        final firestore = ref.watch(firestoreProvider);
        return FirebaseProfileRepository(firestore: firestore);
      },
);

final profileProvider = FutureProvider<UserProfile>((ref){
  final currentUserId = ref.watch(currentUserIdProvider);
  final profileRepository = ref.watch(profileRepositoryProvider);
  if (currentUserId == null) {
    throw Exception('User is not authenticated');
  }
  return profileRepository.getOrCreateUserProfile(currentUserId);
});