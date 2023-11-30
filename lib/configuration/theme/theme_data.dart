import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
      primaryColor: AppColors.primaryColor,
      primaryColorDark: AppColors.primaryColorDark,
      primaryColorLight: AppColors.primaryColorLight,
      cardColor: AppColors.primaryColorLight,
      scaffoldBackgroundColor: AppColors.primaryColorDark,
      appBarTheme: const AppBarTheme(
          centerTitle: true, backgroundColor: AppColors.primaryColor));
}
