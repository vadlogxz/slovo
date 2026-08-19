import 'package:slovo/core/theme/app_colors.dart';
import 'package:slovo/core/theme/app_radius.dart';
import 'package:slovo/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static InputDecorationTheme _inputTheme(AppColors colors) =>
      InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceSubtle,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: colors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: colors.outline, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        hintStyle: TextStyle(color: colors.textSecondary),
      );

  static BottomSheetThemeData _bottomSheetThemeData(AppColors colors) => BottomSheetThemeData(
    backgroundColor: colors.surfaceSubtle,
    surfaceTintColor: Colors.transparent
  );

  static const _appBarTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: false,
  );

  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.light.surfaceSubtle,
    fontFamily: GoogleFonts.poppins().fontFamily,
    colorScheme: ColorScheme.light(
      primary: AppColors.light.primary,
      secondary: AppColors.light.primary12,
      surface: AppColors.light.surface,
      error: AppColors.light.error,
      onSurface: AppColors.light.textPrimary,
      outline: AppColors.light.outline,
      shadow: AppColors.light.shadow,
    ),
    textTheme: AppTextStyles.light,
    appBarTheme: _appBarTheme,
    bottomSheetTheme: _bottomSheetThemeData(AppColors.light),
    inputDecorationTheme: _inputTheme(AppColors.light),
    extensions: const [AppColors.light],
  );

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.dark.surfaceSubtle,
    fontFamily: GoogleFonts.poppins().fontFamily,
    colorScheme: ColorScheme.dark(
      primary: AppColors.dark.primary,
      secondary: AppColors.dark.primary12,
      surface: AppColors.dark.surface,
      error: AppColors.dark.error,
      onSurface: AppColors.dark.textPrimary,
      outline: AppColors.dark.outline,
      shadow: AppColors.dark.shadow,
    ),
    textTheme: AppTextStyles.dark,
    appBarTheme: _appBarTheme,
    inputDecorationTheme: _inputTheme(AppColors.dark),
    extensions: const [AppColors.dark],
  );
}