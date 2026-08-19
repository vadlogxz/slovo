import 'package:flutter/material.dart';

class AppPressable extends StatefulWidget {
  const AppPressable({super.key, this.onTap, required this.builder, Duration? duration, double? pressedScale})
    : duration = duration ?? const Duration(milliseconds: 100),
      pressedScale = pressedScale ?? 0.95;

  final Widget Function(BuildContext context, bool isPressed) builder;
  final void Function()? onTap;
  final Duration duration;
  final double pressedScale;

  @override
  State<AppPressable> createState() => _AppPressableState();
}

class _AppPressableState extends State<AppPressable> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (details) {
        setState(() {
          _isPressed = true;
        });
      },
      onPointerUp: (details) {
        setState(() {
          _isPressed = false;
        });
      },
      onPointerCancel: (details) {
        setState(() {
          _isPressed = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
            duration: widget.duration,
            scale: _isPressed ? widget.pressedScale : 1.0,
            curve: Curves.easeOut,
            child: widget.builder(context, _isPressed)),
      ),
    );
  }
}
