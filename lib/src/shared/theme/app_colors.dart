import 'package:flutter/material.dart';

abstract class AppColors {
  static const MaterialColor primaryColor = MaterialColor(
    0xFFFE7277,
    <int, Color>{
       50: Color(0xFFFFEBEC),
      100: Color(0xFFFFCDCF),
      200: Color(0xFFFEAAB0),
      300: Color(0xFFFE8C93),
      400: Color(0xFFFE7277), 
      500: Color(0xFFFD5A61),
      600: Color(0xFFFD4D56),
      700: Color(0xFFFC3C46),
      800: Color(0xFFFB2A35),
      900: Color(0xFFFA0A1A),
    },
  );
  
  // Light theme colors
  static const Color bgColor = Color(0xFFFFFFFF);
  static const Color lightGrey = Color(0xFFF2F1F1);
  static const Color blackColor = Color(0xFF000000);
  static const Color greyColor = Color(0xFF9E9E9E);
  static const Color greyShade200 = Color(0xFFEEEEEE);
  static const Color greenColor = Color.fromARGB(255, 11, 148, 18);
  
  // Dark theme colors
  static const Color darkBgColor = Color(0xFF121212);
  static const Color darkLightGrey = Color(0xFF1E1E1E);
  static const Color darkGreyColor = Color(0xFF757575);
  static const Color darkGreyShade200 = Color(0xFF2C2C2C);
  
  // Theme-aware color helpers
  static Color backgroundColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? darkBgColor : bgColor;
  }
  
  static Color lightGreyColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? darkLightGrey : lightGrey;
  }
  
  static Color greyShade(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? darkGreyShade200 : greyShade200;
  }
  
  static Color grey(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? darkGreyColor : greyColor;
  }
}