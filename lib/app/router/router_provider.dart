import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:slovo/app/router/app_router.dart';
import 'package:slovo/app/router/app_routes.dart';
import 'package:slovo/core/logging/app_logger.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/auth/domain/models/auth_state.dart';
import 'package:slovo/feature/onboarding/di/onboarding_provider.dart';
import 'package:slovo/feature/onboarding/di/splash_provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: appRoutes,
    initialLocation: AppRoutes.splashPath,
    redirect: (context, state) {
      AppLogger.info('Router redirect: ${state.path}');
      final isSplashDone = ref.read(splashDoneProvider);
      if (!isSplashDone) return null;

      final authState = ref.read(authStateProvider);
      final hasSeenOnboarding = ref.read(onboardingCompletedProvider);

      if (authState.isLoading) return null;

      final isLoggedIn = authState.asData?.value is Authenticated;
      final isOnLoginPage = state.matchedLocation == AppRoutes.loginPath;
      final isOnSplashPage = state.matchedLocation == AppRoutes.splashPath;

      final isOnOnboardingPage = state.uri.path.startsWith(AppRoutes.onboardingPath);
      if (!isLoggedIn && !isOnLoginPage && !isOnOnboardingPage) {
        AppLogger.debug('User is not authenticated. Redirecting to login.', tag: LogTag.router);
        return AppRoutes.loginPath;
      }
      if (isLoggedIn && (isOnLoginPage || isOnSplashPage)) {
        if (!hasSeenOnboarding) {
          AppLogger.debug('User has not seen onboarding. Current path: ${state.matchedLocation}. Redirecting to onboarding: $isOnOnboardingPage');
          return isOnOnboardingPage ? null : AppRoutes.welcomePath;
        }
        AppLogger.debug('User is authenticated. Redirecting to home.', tag: LogTag.router);
        return AppRoutes.homePath;
      }
      return null;
    },
  );

  ref.listen(splashDoneProvider, (_, _) => router.refresh());
  ref.listen(authStateProvider, (_, _) => router.refresh());
  ref.listen(onboardingProvider, (_, _) => router.refresh());

  return router;
});
