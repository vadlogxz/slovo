import 'package:go_router/go_router.dart';
import 'package:slovo/app/router/app_routes.dart';
import 'package:slovo/app/shell/main_shell.dart';
import 'package:slovo/app/shell/widgets/branch_slide_transition.dart';
import 'package:slovo/feature/auth/presentation/login_screen.dart';
import 'package:slovo/feature/home/presentation/home_screen.dart';
import 'package:slovo/feature/learning/presentation/screens/learning_screen.dart';
import 'package:slovo/feature/onboarding/presentation/screens/_.dart';
import 'package:slovo/feature/profile/presentation/profile_screen.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';
import 'package:slovo/feature/vocabulary/presentation/screens/add_collection_screen.dart';
import 'package:slovo/feature/vocabulary/presentation/screens/vocabulary_screen.dart';

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
    builder: (context, state) => const CreateCollectionScreen(),
  ),
  GoRoute(
    path: AppRoutes.learning.path,
    name: AppRoutes.learning.name,

    builder: (context, state) => LearningScreen(sessionWordList: state.extra as List<Word>,),
  ),
  StatefulShellRoute(
    builder: (context, state, navigationShell) => AppShell(navigationShell: navigationShell),
    navigatorContainerBuilder: (context, navigationShell, children) =>
        BranchSlideTransition(currentIndex: navigationShell.currentIndex, children: children),
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.home.path,
            name: AppRoutes.home.name,
            builder: (context, state) => const HomeScreen(),
          )
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.vocabulary.path,
            name: AppRoutes.vocabulary.name,
            builder: (context, state) => const VocabularyScreen(),

          )
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.profile.path,
            name: AppRoutes.profile.name,
            builder: (context, state) => const ProfileScreen(),
          )
        ],
      ),
    ],
  ),
];
