import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AppColors.bgColor,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightGrey,
      hintStyle: TextStyle(color: AppColors.greyColor, fontSize: 17),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      labelMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      labelSmall: TextStyle(fontSize: 15, color: Colors.black),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF222222),
      hintStyle: TextStyle(color: Colors.white70, fontSize: 17),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white70),
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
      labelMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
      labelSmall: TextStyle(fontSize: 15, color: Colors.white),
    ),
  );
}
