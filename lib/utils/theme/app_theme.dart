import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
      textTheme: TextTheme(
        titleMedium: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold),
        titleSmall: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold),
        bodySmall: TextStyle(
            color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
      ),
      primaryColor: AppColors.primaryColor,
      primaryColorDark: AppColors.primaryColorDark,
      primaryColorLight: AppColors.primaryColorLight,
      cardColor: AppColors.primaryColorLight,
      scaffoldBackgroundColor: AppColors.primaryColorDark,
      appBarTheme: const AppBarTheme(
          centerTitle: true, backgroundColor: AppColors.primaryColor));
}
