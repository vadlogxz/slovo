import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/di/core_providers.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/profile/data/repositories/firestore_user_profile_repository.dart';
import 'package:slovo/feature/profile/domain/models/user_profile.dart';
import 'package:slovo/feature/profile/domain/repositories/user_profile_repository.dart';

final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return FirestoreUserProfileRepository(firestore: firestore);
});

// Seeding a default profile on first sight is a workflow (read, then
// conditionally write), not pure wiring, so it lives in a Notifier per
// architecture.md rather than a plain FutureProvider.
class UserProfileNotifier extends AsyncNotifier<UserProfile?> {
  @override
  Future<UserProfile?> build() async {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) return null;

    final repository = ref.watch(userProfileRepositoryProvider);
    final existing = await repository.getUserProfile(userId);
    if (existing != null) return existing;

    // First time this user is seen — no Firestore doc yet. Seed one from the
    // auth provider's display name so the home screen greeting isn't blank.
    final authUser = ref.read(currentUserProvider);
    final profile = UserProfile(uid: userId, displayName: authUser?.name ?? '');
    await repository.saveUserProfile(profile);
    return profile;
  }
}

final userProfileProvider =
    AsyncNotifierProvider<UserProfileNotifier, UserProfile?>(
      UserProfileNotifier.new,
    );
