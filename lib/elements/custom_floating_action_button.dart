import 'package:flutter/material.dart';
import 'package:todo_prioritizer/constants.dart';

// ignore: must_be_immutable
class CustomFloatingActionButton extends StatelessWidget {
  CustomFloatingActionButton({
    this.backgroundColor,
    this.icon,
    this.action,
    this.height,
  });

  Color backgroundColor;
  Icon icon;
  Function action;
  double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: height,
      width: MediaQuery.of(context).size.width,
      child: Container(
        width: 48,
        height: 48,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: action,
            elevation: 5,
            backgroundColor: backgroundColor,
            child: icon,
          ),
        ),
      ),
    );
  }
}
