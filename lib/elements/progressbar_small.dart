import 'package:flutter/material.dart';
import 'package:todo_prioritizer/constants.dart';

// ignore: must_be_immutable
class ProgressBar extends StatelessWidget {
  ProgressBar({this.percent, this.accentColor});

  double percent;
  Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 5,
          decoration: BoxDecoration(
            color: Color(0xFFD2D2D2),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Container(
          width: percent * 0.8,
          height: 5,
          decoration: BoxDecoration(
            color: detailColor,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }
}
