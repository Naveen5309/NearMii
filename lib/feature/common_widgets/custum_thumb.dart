import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CustomThumbShape extends SfThumbShape {
  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required RenderBox? child,
    dynamic currentValue,
    SfRangeValues? currentValues,
    required Animation<double> enableAnimation,
    required Paint? paint,
    required RenderBox parentBox,
    required TextDirection textDirection,
    required SfSliderThemeData themeData,
    required SfThumb? thumb,
  }) {
    final Canvas canvas = context.canvas;

    // Outer Transparent Circle
    final Paint outerCirclePaint = Paint()
      ..color = themeData.activeTrackColor!.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 20, outerCirclePaint);

    // Border Circle
    final Paint borderPaint = Paint()
      ..color = themeData.activeTrackColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(center, 20, borderPaint);

    // Inner Thumb
    final Paint thumbPaint = Paint()..color = themeData.thumbColor!;
    canvas.drawCircle(center, 10, thumbPaint);
  }
}
