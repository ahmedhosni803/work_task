import 'package:flutter/material.dart';
import 'package:task/screens/home_screen/home_screen.dart';

class AppRoute {
  static Map<String, Widget Function(BuildContext)> routes = {
    HomeScreen.route: (_) => HomeScreen(),
  };
  static String initialRoute = HomeScreen.route;
}
