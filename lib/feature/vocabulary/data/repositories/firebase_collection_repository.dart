import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection_color.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection_icon.dart';
import 'package:slovo/feature/vocabulary/domain/repositories/collection_repository.dart';

class FirebaseCollectionRepository implements CollectionRepository {
  FirebaseCollectionRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _collectionReference(
    String userId,
  ) => _firestore.collection('users').doc(userId).collection('collections');

  @override
  Stream<List<Collection>> getUserCollections({required String userId}) {
    return _collectionReference(userId).snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => Collection.fromJson(doc.data())).toList(),
    );
  }

  @override
  Future<void> createCollection({
    required String userId,
    required String title,
    required CollectionIcon icon,
    required CollectionColor color,
    String? description,
  }) {
    final doc = _collectionReference(userId).doc();
    final currentTime = DateTime.now();
    final Collection collection = Collection(
      id: doc.id,
      ownerId: userId,
      title: title,
      icon: icon,
      color: color,
      description: description,
      createdAt: currentTime,
      updatedAt: currentTime,
    );
    return doc.set(collection.toJson());
  }
}
