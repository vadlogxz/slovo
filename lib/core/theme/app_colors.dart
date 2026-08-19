import 'package:flutter/material.dart';

// ── Private primitive palette ─────────────────────────────────────────────────
class _Palette {
  _Palette._();

  // Brand — Violet
  static const violet = Color(0xFF4e5bd6);
  static const violetDark = Color(0xff3c40a8);
  static const violet12 = Color(0x1e4e5bd6); // 12% opacity

  // Feedback
  static const green = Color(0xFF30A46C);
  static const green12 = Color(0x1e30A46C); // 12%
  static const orange = Color(0xFFF76B15);
  static const orange60 = Color(0x96F76B15); // 60%
  static const pink = Color(0xFFD6409F);
  static const pink60 = Color(0x96D6409F); // 60%
  static const red = Color(0xFFE5484D);
  static const red60 = Color(0x96E5484D); // 60%
  static const gold = Color(0xFFc9a227);

  // Neutral — surfaces & text
  static const white = Color(0xFFFFFFFF);
  static const grey50 = Color(0xFFf5f6fa);
  static const grey100 = Color(0xFFeeeffd);
  static const grey200 = Color(0xFFe9eaf1);
  static const grey600 = Color(0xFF71768a);
  static const grey700 = Color(0xFF666b7e);
  static const grey900 = Color(0xFF13141c);

  // On-brand (text on primary-colored surfaces)
  static const lavender = Color(0xFFBFC5FF);

  // Neutral — Dark surfaces
  static const dark950 = Color(0xFF0e0f14);
  static const dark800 = Color(0xFF2a2c3a);

  // Shadows
  static const shadow10 = Color(0x1a000000); // 10%
  static const shadow20 = Color(0x33000000); // 20%
}

// ── Semantic color tokens ─────────────────────────────────────────────────────
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.primary12,
    required this.primaryDark,
    required this.surface,
    required this.surfaceSubtle,
    required this.surfaceElevated,
    required this.outline,
    required this.shadow,
    required this.success,
    required this.success12,
    required this.warning,
    required this.warning60,
    required this.error,
    required this.error60,
    required this.pink,
    required this.pink60,
    required this.rating,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.textInverse,
    required this.textInverseMuted,
    required this.textOnBrand,
    required this.textOnBrandMuted,
  });

  // Brand
  final Color primary;
  final Color primary12;
  final Color primaryDark;

  // Surfaces
  final Color surface;
  final Color surfaceSubtle;
  final Color surfaceElevated;
  final Color outline;
  final Color shadow;

  // Feedback states
  final Color success;
  final Color success12;
  final Color warning;
  final Color warning60;
  final Color error;
  final Color error60;
  final Color pink;
  final Color pink60;
  final Color rating;

  // Text
  final Color textPrimary; // main text on current bg
  final Color textSecondary; // body / subdued text
  final Color textMuted; // hints, captions, disabled
  final Color textInverse;      // text on colored or opposite-mode bg
  final Color textInverseMuted; // muted text on opposite-mode bg
  final Color textOnBrand;      // primary text on brand-colored surfaces
  final Color textOnBrandMuted; // secondary/muted text on brand-colored surfaces

  // ── Light ──────────────────────────────────────────────────────────────────
  static const light = AppColors(
    primary: _Palette.violet,
    primary12: _Palette.violet12,
    primaryDark: _Palette.violetDark,
    surface: _Palette.white,
    surfaceSubtle: _Palette.grey50,
    surfaceElevated: _Palette.grey100,
    outline: _Palette.grey200,
    shadow: _Palette.shadow10,
    success: _Palette.green,
    success12: _Palette.green12,
    warning: _Palette.orange,
    warning60: _Palette.orange60,
    error: _Palette.red,
    error60: _Palette.red60,
    pink: _Palette.pink,
    pink60: _Palette.pink60,
    rating: _Palette.gold,
    textPrimary: _Palette.grey900,
    textSecondary: _Palette.grey600,
    textMuted: _Palette.grey700,
    textInverse: _Palette.white,
    textInverseMuted: _Palette.grey600,
    textOnBrand: _Palette.white,
    textOnBrandMuted: _Palette.lavender,
  );

  // ── Dark ───────────────────────────────────────────────────────────────────
  static const dark = AppColors(
    primary: _Palette.violet,
    primary12: _Palette.violet12,
    primaryDark: _Palette.violetDark,
    surface: _Palette.dark950,
    surfaceSubtle: _Palette.dark800,
    surfaceElevated: _Palette.dark800,
    outline: _Palette.dark800,
    shadow: _Palette.shadow20,
    success: _Palette.green,
    success12: _Palette.green12,
    warning: _Palette.orange,
    warning60: _Palette.orange60,
    error: _Palette.red,
    error60: _Palette.red60,
    pink: _Palette.pink,
    pink60: _Palette.pink60,
    rating: _Palette.gold,
    textPrimary: _Palette.white,
    textSecondary: _Palette.grey600,
    textMuted: _Palette.grey700,
    textInverse: _Palette.grey900,
    textInverseMuted: _Palette.grey600,
    textOnBrand: _Palette.white,
    textOnBrandMuted: _Palette.lavender,
  );

  @override
  AppColors copyWith({
    Color? primary,
    Color? primary12,
    Color? primaryDark,
    Color? surface,
    Color? surfaceSubtle,
    Color? surfaceElevated,
    Color? outline,
    Color? shadow,
    Color? success,
    Color? success12,
    Color? warning,
    Color? warning60,
    Color? error,
    Color? error60,
    Color? pink,
    Color? pink60,
    Color? rating,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? textInverse,
    Color? textInverseMuted,
    Color? textOnBrand,
    Color? textOnBrandMuted,
  }) => AppColors(
    primary: primary ?? this.primary,
    primary12: primary12 ?? this.primary12,
    primaryDark: primaryDark ?? this.primaryDark,
    surface: surface ?? this.surface,
    surfaceSubtle: surfaceSubtle ?? this.surfaceSubtle,
    surfaceElevated: surfaceElevated ?? this.surfaceElevated,
    outline: outline ?? this.outline,
    shadow: shadow ?? this.shadow,
    success: success ?? this.success,
    success12: success12 ?? this.success12,
    warning: warning ?? this.warning,
    warning60: warning60 ?? this.warning60,
    error: error ?? this.error,
    error60: error60 ?? this.error60,
    pink: pink ?? this.pink,
    pink60: pink60 ?? this.pink60,
    rating: rating ?? this.rating,
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    textMuted: textMuted ?? this.textMuted,
    textInverse: textInverse ?? this.textInverse,
    textInverseMuted: textInverseMuted ?? this.textInverseMuted,
    textOnBrand: textOnBrand ?? this.textOnBrand,
    textOnBrandMuted: textOnBrandMuted ?? this.textOnBrandMuted,
  );

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      primary12: Color.lerp(primary12, other.primary12, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceSubtle: Color.lerp(surfaceSubtle, other.surfaceSubtle, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      success: Color.lerp(success, other.success, t)!,
      success12: Color.lerp(success12, other.success12, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warning60: Color.lerp(warning60, other.warning60, t)!,
      error: Color.lerp(error, other.error, t)!,
      error60: Color.lerp(error60, other.error60, t)!,
      pink: Color.lerp(pink, other.pink, t)!,
      pink60: Color.lerp(pink60, other.pink60, t)!,
      rating: Color.lerp(rating, other.rating, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textOnBrand: Color.lerp(textOnBrand, other.textOnBrand, t)!,
      textOnBrandMuted: Color.lerp(textOnBrandMuted, other.textOnBrandMuted, t)!,
      textInverse: Color.lerp(textInverse, other.textInverse, t)!,
      textInverseMuted: Color.lerp(
        textInverseMuted,
        other.textInverseMuted,
        t,
      )!,
    );
  }
}

// ── Convenience accessor ──────────────────────────────────────────────────────
extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
