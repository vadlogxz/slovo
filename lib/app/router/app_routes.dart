final class AppRoute {
  final String path;
  final String name;

  const AppRoute({required this.path, required this.name});

  String get segment => path.split('/').last;
}

abstract final class AppRoutes {
  static const homePath = '/home';
  static const splashPath = '/splash';
  static const onboardingPath = '/onboarding';
  static const welcomePath = '/onboarding/welcome';
  static const featuresPath = '/onboarding/features';
  static const dailyGoalPath = '/onboarding/daily-goal';
  static const getStartedPath = '/onboarding/get-started';
  static const onboardingCompletePath = '/onboarding/complete';

  static const vocabularyPath = '/vocabulary';
  static const profilePath = '/profile';
  static const loginPath = '/login';
  static const createCollectionPath = '/create-collection';
  static const collectionDetailPath = '/collection/:collectionId';
  static const wordDetailPath = '/collection/:collectionId/word/:wordId';
  static const learnSessionPath = '/collection/:collectionId/learn';

  static const splash = AppRoute(path: splashPath, name: 'splash');
  static const onboarding = AppRoute(path: onboardingPath, name: 'onboarding');
  static const welcome = AppRoute(path: welcomePath, name: 'welcome');
  static const features = AppRoute(path: featuresPath, name: 'features');
  static const dailyGoal = AppRoute(path: dailyGoalPath, name: 'daily-goal');
  static const getStarted = AppRoute(path: getStartedPath, name: 'get-started');
  static const onboardingComplete = AppRoute(
    path: onboardingCompletePath,
    name: 'onboarding-complete',
  );

  static const home = AppRoute(path: homePath, name: 'home');
  static const vocabulary = AppRoute(path: vocabularyPath, name: 'vocabulary');
  static const profile = AppRoute(path: profilePath, name: 'profile');
  static const login = AppRoute(path: loginPath, name: 'login');
  static const createCollection = AppRoute(
    path: createCollectionPath,
    name: 'create-collection',
  );
  static const collectionDetail = AppRoute(
    path: collectionDetailPath,
    name: 'collection-detail',
  );
  static const wordDetail = AppRoute(path: wordDetailPath, name: 'word-detail');
  static const learnSession = AppRoute(
    path: learnSessionPath,
    name: 'learn-session',
  );
}
