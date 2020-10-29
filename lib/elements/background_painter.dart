import 'package:flutter/material.dart';

class ShapesPainter extends CustomPainter {
  ShapesPainter({this.y, this.color});
  double y;
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawColor(Color(0), BlendMode.clear);
    final paintColor = Paint();
    paintColor.color = color;

    var path1 = Path();
    path1.lineTo(0, 0);
    path1.lineTo(0, 70);
    path1.lineTo(size.width, 120);
    path1.lineTo(size.width, 0);
    path1.close();
    canvas.drawShadow(path1, Colors.black, 6.0, false);
    canvas.drawPath(path1, paintColor);

    var path2 = Path();
    path2.lineTo(0, 1000);
    path2.lineTo(size.width, 1000);
    path2.lineTo(size.width, 400 + y);
    path2.lineTo(0, 350 + y);
    path2.close();
    canvas.drawShadow(path2, Colors.black, 18.0, false);
    canvas.drawPath(path2, paintColor);

    // var path3 = Path();
    // color3.color = Color(0xFFF8F8F8);
    // path3.lineTo(0, size.height);
    // path3.lineTo(size.width, size.height);
    // path3.lineTo(size.width, 400 + x);
    // path3.lineTo(0, 350 + x);
    // path3.close();
    // canvas.drawPath(path3, color3);
    // // create a path1
    // var path1 = Path();
    // color1.color = Color(0xFFF8F8F8);
    // path1.lineTo(0, 70);
    // path1.lineTo(size.width, 120);
    // path1.lineTo(size.width, 0);
    // path1.lineTo(0, 0);
    // path1.close();
    // canvas.drawPath(path1, color1);
    //
    // var path2 = Path();
    // color2.color = Color(0xFFFFDD80);
    // path2.lineTo(0, 350 + x);
    // path2.lineTo(size.width, 400 + x);
    // path2.lineTo(size.width, 120);
    // path2.lineTo(0, 70);
    // path2.close();
    // canvas.drawPath(path2, color2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
