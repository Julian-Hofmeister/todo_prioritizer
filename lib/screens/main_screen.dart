import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const String id = "main_screen";
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFDD80),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFFDD80),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_to_home_screen),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_to_home_screen),
            label: "home2",
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(3, -3), // changes position of shadow
              ),
            ]),
            child: CustomPaint(
              painter: ShapesPainter(),
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }
}

class ShapesPainter extends CustomPainter {
  double x = 0;

  @override
  void paint(Canvas canvas, Size size) {
    final color1 = Paint();
    final color2 = Paint();
    final color3 = Paint();

    // create a path
    var path1 = Path();
    color1.color = Color(0xFFF8F8F8);
    path1.lineTo(0, 70);
    path1.lineTo(size.width, 120);
    path1.lineTo(size.width, 0);
    path1.close();
    canvas.drawPath(path1, color1);

    // var path2 = Path();
    // color2.color = Color(0xFFFFDD80);
    // path2.lineTo(0, 350 + x);
    // path2.lineTo(size.width, 400 + x);
    // path2.lineTo(size.width, 120);
    // path2.lineTo(0, 70);
    // path2.close();
    // canvas.drawPath(path2, color2);

    // var path3 = Path();
    // color3.color = Color(0xFFF8F8F8);
    // path3.lineTo(0, size.height);
    // path3.lineTo(size.width, size.height);
    // path3.lineTo(size.width, 400 + x);
    // path3.lineTo(0, 350 + x);
    // path3.close();
    // canvas.drawPath(path3, color3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
