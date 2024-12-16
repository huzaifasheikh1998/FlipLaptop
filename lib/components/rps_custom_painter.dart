import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9210526, size.height * 0.9999875);
    path_0.lineTo(size.width * 0.07894737, size.height * 0.9999875);
    path_0.arcToPoint(Offset(0, size.height * 0.8124898),
        radius:
            Radius.elliptical(size.width * 0.07894737, size.height * 0.1874977),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(0, size.height * 0.6873914);
    path_0.cubicTo(
        size.width * 0.0008368421,
        size.height * 0.6874914,
        size.width * 0.001721053,
        size.height * 0.6874914,
        size.width * 0.002631579,
        size.height * 0.6874914);
    path_0.arcToPoint(Offset(size.width * 0.002631579, size.height * 0.3249959),
        radius:
            Radius.elliptical(size.width * 0.07631579, size.height * 0.1812477),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.cubicTo(
        size.width * 0.001763158,
        size.height * 0.3249959,
        size.width * 0.0008736842,
        size.height * 0.3249959,
        0,
        size.height * 0.3251084);
    path_0.lineTo(0, size.height * 0.1874977);
    path_0.arcToPoint(Offset(size.width * 0.07894737, 0),
        radius:
            Radius.elliptical(size.width * 0.07894737, size.height * 0.1874977),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.9210526, 0);
    path_0.arcToPoint(Offset(size.width, size.height * 0.1874977),
        radius:
            Radius.elliptical(size.width * 0.07894737, size.height * 0.1874977),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width, size.height * 0.3251084);
    path_0.arcToPoint(Offset(size.width, size.height * 0.6874039),
        radius:
            Radius.elliptical(size.width * 0.07631579, size.height * 0.1812477),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.lineTo(size.width, size.height * 0.8124898);
    path_0.arcToPoint(Offset(size.width * 0.9210526, size.height * 0.9999875),
        radius:
            Radius.elliptical(size.width * 0.07894737, size.height * 0.1874977),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}