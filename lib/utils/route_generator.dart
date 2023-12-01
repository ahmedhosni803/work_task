import 'package:flutter/material.dart';
import 'package:task/models/popular_response.dart';
import 'package:task/pages/popular_details/details_screen.dart';

import '../pages/home/home_screen.dart';
import '../pages/splash/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case SplashScreen.route:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
      case HomeScreen.route:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case DetailsScreen.route:
        return MaterialPageRoute(
          builder: (context) => DetailsScreen(arg as PersonResults),
        );
      default:
        return _error();
    }
  }

  static Route<dynamic> _error() {
    return MaterialPageRoute(
      builder: (context) {
        return const Scaffold(
          body: Center(
            child: Text("Error"),
          ),
        );
      },
    );
  }
}
