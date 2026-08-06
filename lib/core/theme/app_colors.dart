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

  static const red = Color(0xFFFF5C5C);

  // Neutral — surfaces & text
  static const white = Color(0xFFFFFFFF);
  static const grey50 = Color(0xFFFDFAF3);
  static const grey200 = Color(0xFFe9eaf1);
  static const grey600 = Color(0xFF71768a);
  static const grey700 = Color(0xFF666b7e);

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
    required this.surfaceAccent,
    required this.surfaceAccentTint,
    required this.surfaceIconBadge,
    required this.outline,
    required this.shadow,
    required this.error,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
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
  final Color surfaceAccent;
  final Color surfaceAccentTint;
  final Color surfaceIconBadge;
  final Color outline;
  final Color shadow;

  // Feedback states
  final Color error;

  // Text
  final Color textPrimary; // main text on current bg
  final Color textSecondary; // body / subdued text
  final Color textMuted; // hints, captions, disabled
  final Color textOnBrand;      // primary text on brand-colored surfaces
  final Color textOnBrandMuted; // secondary/muted text on brand-colored surfaces

  // ── Light ──────────────────────────────────────────────────────────────────
  static const light = AppColors(
    primary: _Palette.violet,
    primary12: _Palette.violet12,
    primaryDark: _Palette.violetDark,
    surface: _Palette.surfaceViolet,
    surfaceSubtle: _Palette.grey50,
    surfaceAccent: _Palette.surfaceAccentBorder,
    surfaceAccentTint: _Palette.surfaceAccentTint,
    surfaceIconBadge: _Palette.surfaceIconBadge,
    outline: _Palette.grey200,
    shadow: _Palette.shadow10,
    error: _Palette.red,
    textPrimary: _Palette.violetDark,
    textSecondary: _Palette.violetLight,
    textMuted: _Palette.grey700,
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
    surfaceAccent: _Palette.surfaceAccentBorder,
    surfaceAccentTint: _Palette.surfaceAccentTint,
    surfaceIconBadge: _Palette.surfaceIconBadge,
    outline: _Palette.dark800,
    shadow: _Palette.shadow20,
    error: _Palette.red,
    textPrimary: _Palette.white,
    textSecondary: _Palette.grey600,
    textMuted: _Palette.grey700,
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
    Color? surfaceAccent,
    Color? surfaceAccentTint,
    Color? surfaceIconBadge,
    Color? outline,
    Color? shadow,
    Color? error,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? textOnBrand,
    Color? textOnBrandMuted,
  }) => AppColors(
    primary: primary ?? this.primary,
    primary12: primary12 ?? this.primary12,
    primaryDark: primaryDark ?? this.primaryDark,
    surface: surface ?? this.surface,
    surfaceSubtle: surfaceSubtle ?? this.surfaceSubtle,
    surfaceAccent: surfaceAccent ?? this.surfaceAccent,
    surfaceAccentTint: surfaceAccentTint ?? this.surfaceAccentTint,
    surfaceIconBadge: surfaceIconBadge ?? this.surfaceIconBadge,
    outline: outline ?? this.outline,
    shadow: shadow ?? this.shadow,
    error: error ?? this.error,
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    textMuted: textMuted ?? this.textMuted,
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
      surfaceAccent: Color.lerp(surfaceAccent, other.surfaceAccent, t)!,
      surfaceAccentTint: Color.lerp(surfaceAccentTint, other.surfaceAccentTint, t)!,
      surfaceIconBadge: Color.lerp(surfaceIconBadge, other.surfaceIconBadge, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      error: Color.lerp(error, other.error, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textOnBrand: Color.lerp(textOnBrand, other.textOnBrand, t)!,
      textOnBrandMuted: Color.lerp(textOnBrandMuted, other.textOnBrandMuted, t)!,
    );
  }
}

// ── Convenience accessor ──────────────────────────────────────────────────────
extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
