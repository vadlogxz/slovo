import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slovo/feature/profile/domain/models/user_profile.dart';
import 'package:slovo/feature/profile/domain/repositories/profile_repository.dart';

class FirebaseProfileRepository implements ProfileRepository {
  FirebaseProfileRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  @override
  Future<UserProfile> getOrCreateUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) {
      final UserProfile userProfile = UserProfile(uid: uid);

      await _firestore.collection('users').doc(uid).set(userProfile.toJson());
      return userProfile;
    } else {
      return UserProfile.fromJson(doc.data()!);
    }
  }

  @override
  Future<void> updateUserProfile(UserProfile userProfile) async {
    return await _firestore
        .collection('users')
        .doc(userProfile.uid)
        .set(userProfile.toJson(), SetOptions(merge: true));
  }
}
