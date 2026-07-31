import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    super.key,
    required this.value,
    this.height = 6.0,
    this.gradient = AppGradients.primary,
  });

  final double value;
  final double height;
  final LinearGradient gradient;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
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
  void didUpdateWidget(ProgressBar oldWidget) {
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
    final colors = context.colors;
    final isComplete = widget.value >= 1.0;

    final activeGradient = isComplete
        ? LinearGradient(colors: [colors.success.withValues(alpha: 0.7), colors.success])
        : widget.gradient;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              color: isComplete ? colors.success.withValues(alpha: 0.08) : colors.primary12,
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, _) => FractionallySizedBox(
                widthFactor: _animation.value,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                  decoration: BoxDecoration(gradient: activeGradient),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}