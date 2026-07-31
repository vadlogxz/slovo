import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/storage/shared_preferences_provider.dart';
import 'package:slovo/feature/onboarding/domain/models/_.dart';

class OnboardingNotifier extends Notifier<OnboardingData> {

  @override
  OnboardingData build() {
    return OnboardingData();
  }

  void setDailyGoal(DailyGoal dailyGoal) {
    state = state.copyWith(dailyGoal: dailyGoal);
  }

  void setUserName(String userName) {
    state = state.copyWith(userName: userName);
  }


  Future<void> completeOnboarding() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString('daily_goal', state.dailyGoal.name);
    await prefs.setBool('onboardingCompleted', true);
    // onboardingCompletedProvider has no reactive dependency of its own —
    // invalidate it so the router redirect sees the fresh value instead of
    // the cached pre-onboarding `false`.
    ref.invalidate(onboardingCompletedProvider);
  }

}

final onboardingProvider = NotifierProvider<OnboardingNotifier, OnboardingData>(OnboardingNotifier.new);
final onboardingCompletedProvider = Provider<bool>((ref) {
   final sharedPreferences = ref.watch(sharedPreferencesProvider);
   return sharedPreferences.getBool('onboardingCompleted') ?? false;
});