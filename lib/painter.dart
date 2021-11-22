import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  final List<Offset> offsetList;
  const Painter(this.offsetList);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    for (final offset in offsetList) {
      canvas.drawCircle(offset, 1, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
