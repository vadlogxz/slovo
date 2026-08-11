import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';

class DashBorderPainter extends CustomPainter {
  DashBorderPainter({required this.color, double? strokeWidth, double? radius, double? dashWidth, double? dashGap})
    : strokeWidth = strokeWidth ?? 2.0,
      radius = radius ?? AppRadius.md,
      dashWidth = dashWidth ?? 10.0,
      dashGap = dashGap ?? 5.0;

  final Color color;
  final double strokeWidth;
  final double radius;
  final double dashWidth;
  final double dashGap;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final rrect = RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12));
    final path = Path()..addRRect(rrect);
    for(final metric in path.computeMetrics()) {
      double distance = 0;
      while(distance < metric.length) {
        final end = distance + dashWidth;
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance = end + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
