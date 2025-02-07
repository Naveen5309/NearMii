import 'dart:ui';

import 'package:NearMii/config/helper.dart';
import 'package:flutter/material.dart';

class CommonDottedBorder extends StatelessWidget {
  final Widget child;
  final double? borderRadius;

  const CommonDottedBorder({this.borderRadius, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedBorderPainter(radius: borderRadius),
      child: child,
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final double? radius;
  final double? strokeWidth;
  final Color? borderColor;

  DottedBorderPainter({this.radius, this.borderColor, this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor ?? AppColor.orangeE57300
      ..strokeWidth = strokeWidth ?? 1
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius ?? 0)));

    const dashWidth = 7.0;
    const dashSpace = 7.0;
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        canvas.drawPath(
            pathMetric.extractPath(distance, distance + dashWidth), paint);
        distance += dashWidth + dashSpace;
      }
      distance = 0.0; // Reset for multiple metrics
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
