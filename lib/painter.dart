import 'dart:ui';

import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  final List<List<Offset>> offsetListList;
  const Painter(this.offsetListList);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    for (final offsetList in offsetListList) {
      canvas.drawPoints(PointMode.polygon, offsetList, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
