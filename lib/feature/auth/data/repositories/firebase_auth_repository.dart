import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:slovo/core/config/app_config.dart';
import 'package:slovo/core/error/repository_exception.dart';
import 'package:slovo/feature/auth/domain/models/auth_state.dart';
import 'package:slovo/feature/auth/domain/models/user.dart';
import 'package:slovo/feature/auth/domain/repositories/auth_repository.dart';

/// Web Client ID: Firebase Console → Authentication → Sign-in method → Google → Web SDK configuration
const _webClientId = AppConfig.googleWebClientId;

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({required fb.FirebaseAuth auth}) : _auth = auth;

  final fb.FirebaseAuth _auth;

  @override
  Future<void> signInWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize(serverClientId: _webClientId);
      final googleUser = await GoogleSignIn.instance.authenticate();
      final googleAuth = googleUser.authentication;
      final credential = fb.GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on GoogleSignInException catch (e) {
      // User dismissed the account picker — not an error worth surfacing.
      if (e.code == GoogleSignInExceptionCode.canceled) return;
      throw RepositoryException(e.description ?? 'Google sign-in failed');
    } on fb.FirebaseAuthException catch (e) {
      throw RepositoryException(e.message ?? 'Google sign-in failed');
    }
  }

  @override
  Future<void> signInWithApple() async {
    throw const RepositoryException('Sign in with Apple is not available yet.');
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([_auth.signOut(), GoogleSignIn.instance.signOut()]);
    } on GoogleSignInException catch (e) {
      throw RepositoryException(e.description ?? 'Sign out failed');
    } on fb.FirebaseAuthException catch (e) {
      throw RepositoryException(e.message ?? 'Sign out failed');
    }
  }

  @override
  Stream<AuthState> get authStateChanges {
    return _auth.authStateChanges().map((fbUser) {
      if (fbUser != null) {
        return Authenticated(
          user: User(
            id: fbUser.uid,
            email: fbUser.email ?? '',
            name: fbUser.displayName,
          ),
        );
      } else {
        return const Unauthenticated();
      }
    });
  }
}
