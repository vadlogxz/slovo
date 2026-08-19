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
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  static const _duration = Duration(milliseconds: 80);

  static const _flatShadow = [BoxShadow(color: Colors.transparent)];

  // Glow tint derived from AppGradients.primary's own second stop, so the
  // default drop-shadow always matches the brand gradient instead of a
  // hand-copied hex value that could drift from it.
  List<BoxShadow> get _shadowResting {
    final tint = AppGradients.primary.colors[1];
    return [
      BoxShadow(
        color: tint.withAlpha(0x99),
        blurRadius: 8,
        spreadRadius: -2,
        offset: const Offset(0, 4),
      ),
      BoxShadow(
        color: tint.withAlpha(0x46),
        blurRadius: 24,
        spreadRadius: -6,
        offset: const Offset(0, 14),
      ),
    ];
  }

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
        child: AnimatedContainer(
          duration: _duration,
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? AppSpacing.md,
            ),
            border: widget.border,
            boxShadow: _isPressed
                ? (widget.pressedBoxShadow != null
                      ? [widget.pressedBoxShadow!]
                      : (widget.flat ? _flatShadow : _shadowPressed))
                : (widget.boxShadow != null
                      ? [widget.boxShadow!]
                      : (widget.flat ? _flatShadow : _shadowResting)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              widget.borderRadius != null
                  ? widget.borderRadius!
                  : AppSpacing.md,
            ),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      widget.contentPadding ??
                      const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                        horizontal: AppSpacing.lg,
                      ),
                  decoration: BoxDecoration(
                    gradient: widget.backgroundColor != null
                        ? null
                        : AppGradients.primary,
                    color: widget.backgroundColor,
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
