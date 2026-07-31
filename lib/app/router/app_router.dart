import 'package:go_router/go_router.dart';
import 'package:slovo/app/router/app_routes.dart';
import 'package:slovo/app/shell/main_shell.dart';
import 'package:slovo/feature/auth/presentation/login_screen.dart';
import 'package:slovo/feature/home/presentation/home_screen.dart';
import 'package:slovo/feature/onboarding/presentation/screens/_.dart';
import 'package:slovo/feature/profile/presentation/profile_screen.dart';
import 'package:slovo/feature/study/presentation/learn_session_screen.dart';
import 'package:slovo/feature/vocabulary/presentation/collection_detail_screen.dart';
import 'package:slovo/feature/vocabulary/presentation/create_collection.dart';
import 'package:slovo/feature/vocabulary/presentation/vocabulary_screen.dart';
import 'package:slovo/feature/vocabulary/presentation/word_detail_screen.dart';

final appRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.splash.path,
    name: AppRoutes.splash.name,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: AppRoutes.onboarding.path,
    name: AppRoutes.onboarding.name,
    builder: (context, state) => const OnboardingScreen(),
  ),
  GoRoute(
    path: AppRoutes.login.path,
    name: AppRoutes.login.name,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: AppRoutes.createCollection.path,
    name: AppRoutes.createCollection.name,
    builder: (context, state) => const CreateCollection(),
  ),
  GoRoute(
    path: AppRoutes.collectionDetail.path,
    name: AppRoutes.collectionDetail.name,
    builder: (context, state) {
      final extra = state.extra is Map<String, dynamic>
          ? state.extra as Map<String, dynamic>
          : null;
      return CollectionDetailScreen(
        collectionId: state.pathParameters['collectionId']!,
        lastAddedWordTitle: extra?['lastAddedWordTitle'] as String?,
        lastAddedWordId: extra?['lastAddedWordId'] as String?,
      );
    },
  ),
  GoRoute(
    path: AppRoutes.wordDetail.path,
    name: AppRoutes.wordDetail.name,
    builder: (context, state) => WordDetailScreen(
      collectionId: state.pathParameters['collectionId']!,
      wordId: state.pathParameters['wordId']!,
    ),
  ),
  GoRoute(
    path: AppRoutes.learnSession.path,
    name: AppRoutes.learnSession.name,
    builder: (context, state) =>
        LearnSessionScreen(collectionId: state.pathParameters['collectionId']!),
  ),
  ShellRoute(
    builder: (context, state, child) => AppShell(child: child),
    routes: [
      //TODO: Add routes here
      GoRoute(
        path: AppRoutes.home.path,
        name: AppRoutes.home.name,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.vocabulary.path,
        name: AppRoutes.vocabulary.name,
        builder: (context, state) => const VocabularyScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile.path,
        name: AppRoutes.profile.name,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  ),
];
