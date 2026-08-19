import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slovo/core/error/firestore_error_handling.dart';
import 'package:slovo/core/firestore/firestore_field_parsing.dart';
import 'package:slovo/feature/onboarding/domain/models/daily_goal.dart';
import 'package:slovo/feature/profile/domain/models/user_profile.dart';
import 'package:slovo/feature/profile/domain/repositories/user_profile_repository.dart';

// UserProfile is a pure-Dart domain model (per architecture.md), so its
// Firestore (de)serialization — which needs the Timestamp type — lives here
// in the data layer instead of on the model itself.
UserProfile _profileFromFirestore(String uid, Map<String, dynamic> data) {
  return UserProfile(
    uid: uid,
    displayName: data['displayName'] as String? ?? '',
    streak: intOrDefault(data, 'streak'),
    lastActiveDate: (data['lastActiveDate'] as Timestamp?)?.toDate(),
    dailyGoalMinutes: intOrDefault(
      data,
      'dailyGoalMinutes',
      DailyGoal.regular.minutes,
    ),
  );
}

Map<String, dynamic> _profileToFirestore(UserProfile profile) => {
  'displayName': profile.displayName,
  'streak': profile.streak,
  if (profile.lastActiveDate != null)
    'lastActiveDate': Timestamp.fromDate(profile.lastActiveDate!),
  'dailyGoalMinutes': profile.dailyGoalMinutes,
};

class FirestoreUserProfileRepository implements UserProfileRepository {
  FirestoreUserProfileRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  @override
  Future<UserProfile?> getUserProfile(String uid) {
    return wrapFirestoreErrors(() async {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return _profileFromFirestore(uid, doc.data()!);
      } else {
        return null;
      }
    });
  }

  @override
  Future<void> saveUserProfile(UserProfile profile) {
    return wrapFirestoreErrors(() async {
      await _firestore
          .collection('users')
          .doc(profile.uid)
          .set(_profileToFirestore(profile), SetOptions(merge: true));
    });
  }
}
