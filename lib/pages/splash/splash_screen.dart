import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:task/pages/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      Navigator.pushReplacementNamed(context, HomeScreen.route);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextLiquidFill(
          loadDuration: const Duration(seconds: 2),
          waveDuration: const Duration(seconds: 2),
          text: 'Welcome',
          waveColor: const Color(0xff5D9CEC),
          boxBackgroundColor: const Color(0xff060E1E),
          textStyle: TextStyle(
            fontSize: 60.dp,
            fontWeight: FontWeight.bold,
          ),
          boxHeight: 300),
    ));
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
