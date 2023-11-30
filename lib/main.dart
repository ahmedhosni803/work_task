import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:task/configuration/routes.dart';
import 'package:task/configuration/theme/theme_data.dart';
import 'package:task/providers/details_provider.dart';
import 'package:task/providers/home_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HomeViewModel()..getPopular(1)),
    ChangeNotifierProvider(create: (_) => DetailsViewModel(), lazy: true),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (_, orientation, screenType) {
        return MaterialApp(
          theme: AppTheme.theme,
          routes: AppRoute.routes,
          initialRoute: AppRoute.initialRoute,
        );
      },
    );
  }
}
