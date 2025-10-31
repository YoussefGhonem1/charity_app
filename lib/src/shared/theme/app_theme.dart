import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: AppColors.primaryColor,
      brightness: Brightness.light,
    ).copyWith(
      surface: AppColors.bgColor,
    ),
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: AppColors.bgColor,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightGrey,
      hintStyle: TextStyle(color: AppColors.greyColor, fontSize: 17),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
      labelMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
      labelSmall: TextStyle(fontSize: 15, color: Colors.black),
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: AppColors.primaryColor,
      brightness: Brightness.dark,
    ).copyWith(
      surface: AppColors.darkSurface,
    ),
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: AppColors.darkBg,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.darkBg, elevation: 0, foregroundColor: AppColors.darkTextPrimary),
    cardColor: AppColors.darkSurface,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      hintStyle: TextStyle(color: AppColors.darkTextSecondary, fontSize: 17),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: AppColors.darkTextPrimary),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.darkTextPrimary),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.darkTextPrimary),
      bodyLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: AppColors.darkTextPrimary),
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.darkTextPrimary),
      labelMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.darkTextPrimary),
      labelSmall: TextStyle(fontSize: 15, color: AppColors.darkTextSecondary),
    ),
  );
}
