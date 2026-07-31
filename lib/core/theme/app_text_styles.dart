import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slovo/core/theme/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextTheme get light => TextTheme(
        headlineLarge:  withColor(heading1,     AppColors.light.textPrimary),
        headlineMedium: withColor(heading2,     AppColors.light.textPrimary),
        headlineSmall:  withColor(heading3,     AppColors.light.textPrimary),
        titleLarge:     withColor(titleLarge,   AppColors.light.textPrimary),
        titleMedium:    withColor(titleMedium,  AppColors.light.textPrimary),
        titleSmall:     withColor(titleSmall,   AppColors.light.textPrimary),
        bodyLarge:      withColor(bodyLarge,    AppColors.light.textSecondary),
        bodyMedium:     withColor(bodyMedium,   AppColors.light.textPrimary),
        bodySmall:      withColor(bodySmall,    AppColors.light.textMuted),
        labelLarge:     withColor(labelLarge,   AppColors.light.textSecondary),
        labelMedium:    withColor(labelMedium,  AppColors.light.textMuted),
        labelSmall:     withColor(labelSmall,   AppColors.light.textMuted),
      );

  static TextTheme get dark => TextTheme(
        headlineLarge:  withColor(heading1,     AppColors.dark.textPrimary),
        headlineMedium: withColor(heading2,     AppColors.dark.textPrimary),
        headlineSmall:  withColor(heading3,     AppColors.dark.textPrimary),
        titleLarge:     withColor(titleLarge,   AppColors.dark.textPrimary),
        titleMedium:    withColor(titleMedium,  AppColors.dark.textPrimary),
        titleSmall:     withColor(titleSmall,   AppColors.dark.textPrimary),
        bodyLarge:      withColor(bodyLarge,    AppColors.dark.textSecondary),
        bodyMedium:     withColor(bodyMedium,   AppColors.dark.textSecondary),
        bodySmall:      withColor(bodySmall,    AppColors.dark.textMuted),
        labelLarge:     withColor(labelLarge,   AppColors.dark.textPrimary),
        labelMedium:    withColor(labelMedium,  AppColors.dark.textMuted),
        labelSmall:     withColor(labelSmall,   AppColors.dark.textMuted),
      );

  static TextStyle withColor(TextStyle style, Color color) =>
      style.copyWith(color: color);

  // Headlines
  static TextStyle get heading1 => GoogleFonts.fraunces(
        fontSize: 44,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      );

  static TextStyle get heading2 => GoogleFonts.fraunces(
        fontSize: 32,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get heading3 => GoogleFonts.fraunces(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      );

  // Titles
  static TextStyle get titleLarge => GoogleFonts.bricolageGrotesque(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleMedium => GoogleFonts.bricolageGrotesque(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleSmall => GoogleFonts.bricolageGrotesque(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  // Body
  static TextStyle get bodyLarge => GoogleFonts.bricolageGrotesque(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.bricolageGrotesque(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get bodySmall => GoogleFonts.bricolageGrotesque(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
      );

  // Labels
  static TextStyle get labelLarge => GoogleFonts.outfit(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get labelMedium => GoogleFonts.bricolageGrotesque(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      );

  static TextStyle get labelSmall => GoogleFonts.bricolageGrotesque(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      );
}