import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/feature/vocabulary/data/repositories/firebase_word_repository.dart';
import 'package:slovo/feature/vocabulary/domain/repositories/word_repository.dart';

import '../../../core/di/core_providers.dart';

final wordRepositoryProvider = Provider<WordRepository>((ref) {
  return FirebaseWordRepository(firestore: ref.read(firestoreProvider));
});

