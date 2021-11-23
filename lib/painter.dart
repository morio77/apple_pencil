import 'dart:ui';

import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  final List<List<Offset>> dragOffsetLists;
  const Painter(this.dragOffsetLists);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    for (final offsetList in dragOffsetLists) {
      canvas.drawPoints(PointMode.points, offsetList, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
