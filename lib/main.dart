import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_prioritizer/constants.dart';
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
      theme: ThemeData(
        primaryColor: green,
        fontFamily: 'Roboto',
      ).copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      // ThemeData.from(
      //   colorScheme: const ColorScheme.light(),
      // ).copyWith(
      //   pageTransitionsTheme: const PageTransitionsTheme(
      //     builders: <TargetPlatform, PageTransitionsBuilder>{
      //       TargetPlatform.android: ZoomPageTransitionsBuilder(),
      //     },
      //   ),
      // ),
      initialRoute: MainScreen.id,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
