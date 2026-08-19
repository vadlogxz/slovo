import 'package:flutter/material.dart';

mixin StaggerAnimationMixin<T extends StatefulWidget>
    on State<T>, SingleTickerProviderStateMixin<T> {
  late final AnimationController controller;

  Duration get animationDuration => const Duration(milliseconds: 2000);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: animationDuration)
      ..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  ({Animation<double> fade, Animation<Offset> slide}) createStaggerAnimation({
    required double start,
    required double end,
    Offset beginOffset = const Offset(0, 0.2),
    Curve curve = Curves.easeOut,
  }) {
    final curveAnimation = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: curve),
    );

    final fade = Tween<double>(begin: 0.0, end: 1.0).animate(curveAnimation);
    final slide = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(curveAnimation);
    return (fade: fade, slide: slide);
  }
}
