import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/assets/app_assets.dart';
import 'package:slovo/core/error/repository_exception.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/auth/domain/repositories/auth_repository.dart';
import 'package:slovo/shared/widgets/_.dart';

enum _SignInProvider { apple, google }

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TapGestureRecognizer _termsTap;
  late final TapGestureRecognizer _privacyTap;
  _SignInProvider? _loading;

  @override
  void initState() {
    _termsTap = TapGestureRecognizer()..onTap = () {
      //TODO: Open terms of service
    };
    _privacyTap = TapGestureRecognizer()..onTap = () {
      //TODO: Open privacy policy
    };
    super.initState();
  }

  @override
  void dispose() {
    _termsTap.dispose();
    _privacyTap.dispose();
    super.dispose();
  }

  Future<void> _signIn(
    _SignInProvider provider,
    Future<void> Function() action,
  ) async {
    if (_loading != null) return;
    setState(() => _loading = provider);
    try {
      await action();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e is RepositoryException ? e.message : 'Sign-in failed. Please try again.',
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: context.colors.error,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) setState(() => _loading = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepository = ref.watch(authRepositoryProvider);
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;
    // Apple's sign-in button must stay auto-inverted against the system
    // theme regardless of the app's own brand colors, so it's the one place
    // that intentionally reads Material's ColorScheme instead of AppColors.
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            children: [
              const Spacer(),
              // ── Branding ──
              Column(
                children: [
                  const BrandLogo(),
                  const SizedBox(height: AppSpacing.md),
                  const BrandTitle(),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'German, in your own words.',
                    style: tt.bodyMedium?.copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
              const Spacer(),
              // ── Auth buttons ──
              AppButton(
                onTap: _loading != null
                    ? null
                    : () => _signIn(_SignInProvider.apple, authRepository.signInWithApple),
                isLoading: _loading == _SignInProvider.apple,
                style: AppButtonStyle(
                  background: cs.inverseSurface,
                  boxShadow: [
                    BoxShadow(
                      color: colors.shadow,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  pressedBoxShadow: [
                    BoxShadow(
                      color: colors.shadow,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(
                      path: AppAssets.appleLogo,
                      color: cs.onInverseSurface,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      'Continue with Apple',
                      style: TextStyle(
                        color: cs.onInverseSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.05,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppButton(
                // No isLoading spinner here — AppButton's spinner is white,
                // which has poor contrast on this button's light background.
                onTap: _loading != null
                    ? null
                    : () => _signIn(_SignInProvider.google, authRepository.signInWithGoogle),
                style: AppButtonStyle(
                  background: colors.surface,
                  border: Border.all(color: colors.outline),
                  boxShadow: [
                    BoxShadow(
                      color: colors.shadow,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  pressedBoxShadow: [
                    BoxShadow(
                      color: colors.shadow,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppIcon(path: AppAssets.googleLogo, size: 24),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      'Continue with Google',
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.05,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text.rich(
                TextSpan(
                  style: tt.labelMedium?.copyWith(
                    fontSize: 13,
                    height: 1.4,
                    color: colors.textMuted,
                  ),
                  children: [
                    const TextSpan(text: 'By continuing you agree to Slovo’s '),
                    TextSpan(
                      text: 'Terms',
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: _termsTap,
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: _privacyTap,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}