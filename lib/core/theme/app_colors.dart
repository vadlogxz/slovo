import 'package:flutter/material.dart';

// ── Private primitive palette ─────────────────────────────────────────────────
class _Palette {
  _Palette._();


  static const violet = Color(0xFF5B2EE8);
  static const violetDark = Color(0xff1A1025);
  static const violetLight = Color(0xff7A6E85);
  static const violet12 = Color(0x1e4e5bd6); // 12% opacity
  static const surfaceViolet = Color(0xFFE8E7E9);
  static const surfaceAccentTint = Color(0xFFF0EBFF);
  static const surfaceAccentBorder = Color(0x335B2EE8); // violet @ 20%
  static const surfaceIconBadge = Color(0xFFF0EBE3);

  static const teal = Color(0xFF00C9A7);
  static const yellow = Color(0xFFFFE566);
  static const orange = Color(0xFFFE9F43);
  static const pink = Color(0xFFD6409F);
  static const pink60 = Color(0x96D6409F); // 60%
  static const red = Color(0xFFFF5C5C);
  static const red60 = Color(0x96E5484D); // 60%

  // Neutral — surfaces & text
  static const white = Color(0xFFFFFFFF);
  static const grey50 = Color(0xFFFDFAF3);
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
    required this.surfaceAccent,
    required this.surfaceAccentTint,
    required this.surfaceIconBadge,
    required this.outline,
    required this.shadow,
    required this.success,
    required this.warning,
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
  final Color surfaceAccent;
  final Color surfaceAccentTint;
  final Color surfaceIconBadge;
  final Color outline;
  final Color shadow;

  // Feedback states
  final Color success;
  final Color warning;
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
    surface: _Palette.surfaceViolet,
    surfaceSubtle: _Palette.grey50,
    surfaceElevated: _Palette.grey100,
    surfaceAccent: _Palette.surfaceAccentBorder,
    surfaceAccentTint: _Palette.surfaceAccentTint,
    surfaceIconBadge: _Palette.surfaceIconBadge,
    outline: _Palette.grey200,
    shadow: _Palette.shadow10,
    success: _Palette.teal,
    warning: _Palette.orange,
    error: _Palette.red,
    error60: _Palette.red60,
    pink: _Palette.pink,
    pink60: _Palette.pink60,
    rating: _Palette.yellow,
    textPrimary: _Palette.violetDark,
    textSecondary: _Palette.violetLight,
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
    surfaceAccent: _Palette.surfaceAccentBorder,
    surfaceAccentTint: _Palette.surfaceAccentTint,
    surfaceIconBadge: _Palette.surfaceIconBadge,
    outline: _Palette.dark800,
    shadow: _Palette.shadow20,
    success: _Palette.teal,
    warning: _Palette.orange,
    error: _Palette.red,
    error60: _Palette.red60,
    pink: _Palette.pink,
    pink60: _Palette.pink60,
    rating: _Palette.yellow,
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
    Color? surfaceAccent,
    Color? surfaceAccentTint,
    Color? surfaceIconBadge,
    Color? outline,
    Color? shadow,
    Color? success,
    Color? warning,
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
    surfaceAccent: surfaceAccent ?? this.surfaceAccent,
    surfaceAccentTint: surfaceAccentTint ?? this.surfaceAccentTint,
    surfaceIconBadge: surfaceIconBadge ?? this.surfaceIconBadge,
    outline: outline ?? this.outline,
    shadow: shadow ?? this.shadow,
    success: success ?? this.success,
    warning: warning ?? this.warning,
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
      surfaceAccent: Color.lerp(surfaceAccent, other.surfaceAccent, t)!,
      surfaceAccentTint: Color.lerp(surfaceAccentTint, other.surfaceAccentTint, t)!,
      surfaceIconBadge: Color.lerp(surfaceIconBadge, other.surfaceIconBadge, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
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
