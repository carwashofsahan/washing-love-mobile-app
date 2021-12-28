import 'package:flutter/material.dart';

// theme data
class AppColors {
  static ThemeData get lightTheme {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.color('2196F3'),
        accentColor: AppColors.color('FFD54F'),
        inputDecorationTheme:
            InputDecorationTheme(border: OutlineInputBorder()));
  }

  static Color color(String code) {
    String finalColor = '0xFF' + code;
    return Color(int.parse(finalColor));
  }
}
