import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_prioritizer/route_generator.dart';
import 'package:todo_prioritizer/screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MainScreen.id,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
