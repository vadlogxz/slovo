import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/di/core_providers.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/study/data/repositories/firestore_card_progress_repository.dart';
import 'package:slovo/feature/study/domain/models/card_progress.dart';
import 'package:slovo/feature/study/domain/repositories/card_progress_repository.dart';

final cardProgressRepositoryProvider = Provider<CardProgressRepository>((ref) {
  return FirestoreCardProgressRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

final collectionProgressProvider = StreamProvider.autoDispose
    .family<List<CardProgress>, String>((ref, collectionId) {
      final userId = ref.watch(currentUserIdProvider);
      if (userId == null) return const Stream.empty();
      return ref
          .watch(cardProgressRepositoryProvider)
          .watchCollectionProgress(userId, collectionId);
    });

/// Every card across all of the user's collections — for account-wide
/// aggregates (e.g. Home's total due-count) where per-collection scoping
/// would undercount or overcount.
final allProgressProvider = StreamProvider.autoDispose<List<CardProgress>>((
  ref,
) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return const Stream.empty();
  return ref.watch(cardProgressRepositoryProvider).watchAllProgress(userId);
});
