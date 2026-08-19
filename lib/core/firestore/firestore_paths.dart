import 'package:cloud_firestore/cloud_firestore.dart';

// Shared by every repository that needs a user's collections subcollection,
// so the path is defined once instead of being copy-pasted per repository
// (per firebase.md: all user data nests under users/{userId}).
extension UserCollectionsPath on FirebaseFirestore {
  CollectionReference<Map<String, dynamic>> userCollectionsRef(
    String userId,
  ) => collection('users').doc(userId).collection('collections');
}
