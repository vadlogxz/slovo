import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/vocabulary/data/repositories/firebase_collection_repository.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection.dart';
import 'package:slovo/feature/vocabulary/domain/repositories/collection_repository.dart';

import '../../../core/di/core_providers.dart';

final collectionRepositoryProvider = Provider<CollectionRepository>((ref){
  final firestore = ref.watch(firestoreProvider);
  return FirebaseCollectionRepository(firestore: firestore);
});

final userCollectionsProvider = StreamProvider<List<Collection>>((ref) {
  final collectionRepository = ref.watch(collectionRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  if(userId == null) {
    throw Exception('User is not authenticated');
  }
  return collectionRepository.getUserCollections(userId: userId);
});
