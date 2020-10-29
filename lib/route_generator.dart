import 'package:flutter/material.dart';
import 'package:todo_prioritizer/screens/login_screen.dart';
import 'package:todo_prioritizer/screens/main_screen.dart';
import 'package:todo_prioritizer/screens/new_task_screen.dart';
import 'package:todo_prioritizer/screens/registration_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case MainScreen.id:
        return MaterialPageRoute(builder: (_) => MainScreen());

      case NewTaskScreen.id:
        return MaterialPageRoute(builder: (_) => NewTaskScreen());

      case RegistrationScreen.id:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());

      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text("ERROR"),
          ),
        );
      },
    );
  }
}
