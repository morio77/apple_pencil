import 'dart:ui';

import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  final List<List<Offset>> dragOffsetLists;
  final PointMode pointMode;
  const Painter(this.dragOffsetLists, this.pointMode);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    for (final offsetList in dragOffsetLists) {
      canvas.drawPoints(pointMode, offsetList, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
