import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/storage/shared_preferences_provider.dart';

class ThemeNotifier extends Notifier<ThemeMode> {

  @override
  ThemeMode build() {
    final sharedPreferences = ref.watch(sharedPreferencesProvider);
    final currentThemeMode = sharedPreferences.getString('themeMode');
    if (currentThemeMode == null) return ThemeMode.system;
    return currentThemeMode == 'dark' ? ThemeMode.dark : ThemeMode.light;

  }

  void toggle() async {
    final sharedPreferences = ref.read(sharedPreferencesProvider);
    final newThemeMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = newThemeMode;
    await sharedPreferences.setString('themeMode', newThemeMode == ThemeMode.dark ? 'dark' : 'light');
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);