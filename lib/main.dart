import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:task/pages/home/home_view_model.dart';
import 'package:task/pages/home/services/local_service/home_local_service.dart';
import 'package:task/pages/popular_details/popular_details_view_model.dart';
import 'package:task/utils/route_generator.dart';
import 'package:task/utils/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HomeLocalService.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      lazy: false,
    ),
    ChangeNotifierProvider(
        create: (_) => PopularDetailsViewModel()..checkConnected(),
        lazy: false),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (_, orientation, screenType) {
        return MaterialApp(
          theme: AppTheme.theme,
          onGenerateRoute: RouteGenerator.generateRoute,
          // routes: AppRoute.routes,
          // initialRoute: AppRoute.initialRoute,
        );
      },
    );
  }
}
