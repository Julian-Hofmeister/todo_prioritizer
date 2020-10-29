import 'package:flutter/material.dart';
import 'package:todo_prioritizer/screens/main_screen.dart';

// ignore: must_be_immutable
class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar({this.accentColor});

  Color accentColor;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: accentColor,
      elevation: 18,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment_turned_in_rounded),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wb_sunny_outlined),
          label: 'Dream Up',
        ),
      ],
      selectedItemColor: Colors.white,
    );
  }
}
