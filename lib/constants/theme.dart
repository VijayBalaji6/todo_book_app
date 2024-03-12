import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';

class AppTheme {
  static final ThemeData myAppTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      primary: AppColors.primaryDark,
      secondary: AppColors.primaryDark,
      seedColor: AppColors.secondaryLight,
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
