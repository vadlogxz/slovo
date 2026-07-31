import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';

class AppButton extends StatefulWidget {
  final void Function()? onTap;
  final String? text;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final double? borderRadius;
  final BoxShadow? boxShadow;
  final BoxShadow? pressedBoxShadow;
  final BoxBorder? border;
  final Widget? child;
  final EdgeInsetsGeometry? contentPadding;
  final Color? pressedOverlayColor;
  final double pressedScale;
  final bool isLoading;
  final bool isDisabled;

  // Suppresses the default brand drop-shadow for secondary/flat buttons
  // (e.g. a muted-background action next to a primary CTA). Equivalent to
  // passing boxShadow/pressedBoxShadow: BoxShadow(color: Colors.transparent)
  // — set this instead of repeating that at every call site.
  final bool flat;

  const AppButton({
    super.key,
    required this.onTap,
    this.text,
    this.backgroundColor,
    this.textStyle,
    this.borderRadius,
    this.boxShadow,
    this.pressedBoxShadow,
    this.border,
    this.child,
    this.contentPadding,
    this.pressedOverlayColor,
    this.pressedScale = 0.97,
    this.isLoading = false,
    this.flat = false,
    this.isDisabled = false,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  static const _duration = Duration(milliseconds: 80);

  List<BoxShadow> get _shadowPressed {
    final tint = AppGradients.primary.colors[1];
    return [
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
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? widget.pressedScale : 1.0,
        duration: _duration,
        curve: Curves.easeOut,
        // Shadow and background color are animated separately to avoid the shadow being clipped by the button's border radius.
        child: AnimatedContainer(
          duration: _duration,
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? AppSpacing.md,
            ),
            boxShadow: widget.isDisabled
                ? null
                : _isPressed
                    ? widget.pressedBoxShadow != null
                        ? [widget.pressedBoxShadow!]
                        : _shadowPressed
                    : widget.boxShadow != null
                        ? [widget.boxShadow!]
                        : [
                            BoxShadow(
                              color: colors.primary.withAlpha(0x33),
                              blurRadius: 4,
                              spreadRadius: -2,
                              offset: const Offset(0, 2),
                            ),
                            BoxShadow(
                              color: colors.primary.withAlpha(0x1A),
                              blurRadius: 8,
                              spreadRadius: -6,
                              offset: const Offset(0, 4),
                            ),
                          ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? AppSpacing.md,
            ),
            child: Stack(
              children: [
                // Background color
                Container(
                  width: double.infinity,
                  padding:
                      widget.contentPadding ??
                      const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                        horizontal: AppSpacing.lg,
                      ),
                  decoration: BoxDecoration(
                    color: widget.isDisabled ? colors.outline : widget.backgroundColor ?? colors.primary,
                    border: widget.border ?? Border.all(color: widget.isDisabled ? colors.outline : colors.primaryDark, width: 2),
                    borderRadius: BorderRadius.circular(
                      widget.borderRadius ?? AppSpacing.md,
                    ),
                  ),
                  child: Center(
                    child: widget.isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colors.textOnBrand,
                            ),
                          )
                        : widget.child ??
                              Text(
                                widget.text ?? 'Button',
                                style:
                                    widget.textStyle ??
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
                    opacity: _isPressed ? 1.0 : 0.0,
                    duration: _duration,
                    child: Container(
                      color: widget.pressedOverlayColor ?? colors.shadow,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
