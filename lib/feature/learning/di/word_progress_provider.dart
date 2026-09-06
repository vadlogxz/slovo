
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/di/core_providers.dart';
import 'package:slovo/feature/learning/data/repositories/firebase_word_progress_repository.dart';

final wordProgressProvider = Provider<FirebaseWordProgressRepository>((ref) {
  final firestore = ref.read(firestoreProvider);
  return FirebaseWordProgressRepository(firestore: firestore);
});
