import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';

class AppProgressBar extends StatefulWidget {
  const AppProgressBar({
    super.key,
    required this.value,
    this.height = 6.0,
    this.backgroundColor,
  });

  final double value;
  final double height;
  final Color? backgroundColor;

  @override
  State<AppProgressBar> createState() => _AppProgressBarState();
}

class _AppProgressBarState extends State<AppProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Tween<double> _tween;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _tween = Tween<double>(begin: 0.0, end: widget.value.clamp(0.0, 1.0));
    _animation = _tween.animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(AppProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _tween.begin = _animation.value;
      _tween.end = widget.value.clamp(0.0, 1.0);
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              color: Colors.white.withValues(alpha: 0.2),
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, _) => FractionallySizedBox(
                widthFactor: _animation.value,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                  decoration: BoxDecoration(color: widget.backgroundColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
