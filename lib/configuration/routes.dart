import 'package:flutter/material.dart';
import 'package:task/screens/gallery_screen/gallery_screen.dart';
import 'package:task/screens/home_screen/home_screen.dart';

import '../screens/details_screen/details_screen.dart';

class AppRoute {
  static Map<String, Widget Function(BuildContext)> routes = {
    HomeScreen.route: (_) => HomeScreen(),
    DetailsScreen.route: (_) => DetailsScreen(),
    GalleryScreen.route: (_) => GalleryScreen(),
  };
  static String initialRoute = HomeScreen.route;
}
