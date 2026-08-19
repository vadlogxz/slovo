import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';

/// Visual look of an [AppButton]: background, border, shadow and text style.
///
/// Use a named factory ([AppButtonStyle.primary], [AppButtonStyle.outline])
/// for the common cases. For a one-off button, build a custom instance or
/// tweak a preset with [copyWith] — see `_StartLearningButton` in
/// `home_screen.dart` for an example.
///
/// `isDisabled` is intentionally NOT part of this class: [AppButton] applies
/// a single uniform "disabled" look on top of any style, so every variant
/// stays disableable for free without repeating that logic here.
@immutable
class AppButtonStyle {
  const AppButtonStyle({
    required this.background,
    this.border,
    this.boxShadow,
    this.pressedBoxShadow,
    this.textStyle,
    this.pressedOverlayColor,
    this.disabledBackground,
    this.disabledBorder,
  });

  /// Solid brand-colored CTA. The default look when no [AppButtonStyle] is
  /// given to [AppButton].
  factory AppButtonStyle.primary(AppColors colors) {
    List<BoxShadow> shadowTintedBy(Color tint) => [
      BoxShadow(
        color: tint.withAlpha(0x33),
        blurRadius: 4,
        spreadRadius: -2,
        offset: const Offset(0, 2),
      ),
      BoxShadow(
        color: tint.withAlpha(0x1A),
        blurRadius: 8,
        spreadRadius: -6,
        offset: const Offset(0, 4),
      ),
    ];

    return AppButtonStyle(
      background: colors.primary,
      border: Border.all(color: colors.primaryDark, width: 2),
      boxShadow: shadowTintedBy(colors.primary),
      // Slightly deeper violet tint from the brand gradient, for a subtle
      // "sinking in" feel on press.
      pressedBoxShadow: shadowTintedBy(AppGradients.primary.colors[1]),
    );
  }

  /// Light surface with an outline border — secondary actions.
  factory AppButtonStyle.outline(AppColors colors) {
    return AppButtonStyle(
      background: colors.surface,
      border: Border.all(color: colors.outline),
      textStyle: TextStyle(
        color: colors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  final Color background;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final List<BoxShadow>? pressedBoxShadow;
  final TextStyle? textStyle;
  final Color? pressedOverlayColor;
  final Color? disabledBackground;
  final BoxBorder? disabledBorder;

  AppButtonStyle copyWith({
    Color? background,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
    List<BoxShadow>? pressedBoxShadow,
    TextStyle? textStyle,
    Color? pressedOverlayColor,
    Color? disabledBackground,
    BoxBorder? disabledBorder,
  }) {
    return AppButtonStyle(
      background: background ?? this.background,
      border: border ?? this.border,
      boxShadow: boxShadow ?? this.boxShadow,
      pressedBoxShadow: pressedBoxShadow ?? this.pressedBoxShadow,
      textStyle: textStyle ?? this.textStyle,
      pressedOverlayColor: pressedOverlayColor ?? this.pressedOverlayColor,
      disabledBackground: disabledBackground ?? this.disabledBackground,
      disabledBorder: disabledBorder ?? this.disabledBorder,
    );
  }
}
