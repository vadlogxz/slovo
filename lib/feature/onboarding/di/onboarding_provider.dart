import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/storage/shared_preferences_provider.dart';
import 'package:slovo/feature/onboarding/domain/models/_.dart';
import 'package:slovo/feature/profile/di/profile_provider.dart';

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

  void setReminderTime(ReminderTime reminderTime) {
    state = state.copyWith(reminderTime: reminderTime);
  }


  Future<void> completeOnboarding() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString('reminder_time', state.reminderTime.name);
    await prefs.setBool('onboardingCompleted', true);

    final userProfile = await ref.read(profileProvider.future);
    final profileRepository = ref.read(profileRepositoryProvider);
    await profileRepository.updateUserProfile(userProfile.copyWith(
      displayName: state.userName,
      dailyGoalMinutes: state.dailyGoal.minutes
    ));

    ref.invalidate(profileProvider);
    ref.invalidate(onboardingCompletedProvider);
  }

}

final onboardingProvider = NotifierProvider<OnboardingNotifier, OnboardingData>(OnboardingNotifier.new);
final onboardingCompletedProvider = Provider<bool>((ref) {
   final sharedPreferences = ref.watch(sharedPreferencesProvider);
   return sharedPreferences.getBool('onboardingCompleted') ?? false;
});