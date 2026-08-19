import 'package:flutter/material.dart';

class StaggerRevealAnimation extends StatelessWidget {
  final Animation<double> fade;
  final Animation<Offset> slide;
  final Widget child;

  const StaggerRevealAnimation({super.key, required this.fade, required this.slide, required this.child});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: fade, child: SlideTransition(position: slide, child: child));
  }
}
