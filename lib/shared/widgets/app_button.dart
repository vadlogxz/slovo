import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/shared/widgets/app_button_style.dart';
import 'package:slovo/shared/widgets/app_pressable.dart';

export 'app_button_style.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onTap,
    this.text,
    this.child,
    this.style,
    this.width,
    this.borderRadius,
    this.contentPadding,
    this.pressedScale = 0.97,
    this.isLoading = false,
    this.isDisabled = false,
  });

  final void Function()? onTap;
  final String? text;
  final Widget? child;

  /// How the button looks. Defaults to [AppButtonStyle.primary] when null —
  /// pass [AppButtonStyle.outline] or a custom [AppButtonStyle] to change it.
  final AppButtonStyle? style;
  final double? width;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final double pressedScale;
  final bool isLoading;
  final bool isDisabled;

  static const _duration = Duration(milliseconds: 80);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final activeStyle = style ?? AppButtonStyle.primary(colors);
    final radius = BorderRadius.circular(borderRadius ?? AppSpacing.md);

    return AppPressable(
      onTap: onTap,
      pressedScale: pressedScale,
      duration: _duration,
      builder: (context, isPressed) {
        // Each visual property is resolved independently, in order of
        // priority: disabled overrides everything, then pressed, then the
        // style's own default.
        final shadow = isDisabled
            ? null
            : isPressed
            ? activeStyle.pressedBoxShadow ?? activeStyle.boxShadow
            : activeStyle.boxShadow;

        final background = isDisabled
            ? activeStyle.disabledBackground ?? colors.outline
            : activeStyle.background;

        final border = isDisabled
            ? activeStyle.disabledBorder ??
                  Border.all(color: colors.outline, width: 2)
            : activeStyle.border;

        return AnimatedContainer(
          duration: _duration,
          curve: Curves.easeOut,
          decoration: BoxDecoration(borderRadius: radius, boxShadow: shadow),
          child: ClipRRect(
            borderRadius: radius,
            child: Stack(
              children: [
                // Background color
                Container(
                  width: width ?? double.infinity,
                  padding:
                      contentPadding ??
                      const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                        horizontal: AppSpacing.lg,
                      ),
                  decoration: BoxDecoration(
                    color: background,
                    border: border,
                    borderRadius: radius,
                  ),
                  child: Center(
                    child: isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colors.textOnBrand,
                            ),
                          )
                        : child ??
                              Text(
                                text ?? 'Button',
                                style:
                                    activeStyle.textStyle ??
                                    Theme.of(
                                      context,
                                    ).textTheme.labelLarge?.copyWith(
                                      color: colors.textOnBrand,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                  ),
                ),
                // Pressed overlay
                Positioned.fill(
                  child: AnimatedOpacity(
                    opacity: isPressed ? 1.0 : 0.0,
                    duration: _duration,
                    child: Container(
                      color: activeStyle.pressedOverlayColor ?? colors.shadow,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
