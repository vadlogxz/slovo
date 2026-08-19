import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/di/core_providers.dart';
import 'package:slovo/feature/auth/data/repositories/firebase_auth_repository.dart';
import 'package:slovo/feature/auth/domain/models/auth_state.dart';
import 'package:slovo/feature/auth/domain/models/user.dart';
import 'package:slovo/feature/auth/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => FirebaseAuthRepository(auth: ref.watch(firebaseAuthProvider)),
);

final authStateProvider = StreamProvider<AuthState>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

final currentUserIdProvider = Provider<String?>((ref) {
  final authState = ref.watch(authStateProvider).asData?.value;

  return switch (authState) {
    Authenticated(:final user) => user.id,
    _ => null,
  };
});

final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider).asData?.value;

  return switch (authState) {
    Authenticated(:final user) => user,
    _ => null,
  };
});
