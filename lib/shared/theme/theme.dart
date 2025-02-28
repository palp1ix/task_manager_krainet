import 'package:flutter/material.dart';
import 'package:task_manager_krainet/shared/theme/colors.dart';
import 'package:task_manager_krainet/shared/theme/fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.accentLight,
      scaffoldBackgroundColor: AppColors.whiteBackground,
      colorScheme: ColorScheme.light(
          primary: AppColors.accentLight,
          secondary: AppColors.accentLight,
          surface: AppColors.whiteBackground,
          onSurface: AppColors.onWhiteBackground,
          surfaceContainer: AppColors.whiteBackgroundContainer),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
            fontFamily: AppFonts.mainFont,
            fontWeight: FontWeight.w700,
            fontSize: 22),
        bodyMedium: TextStyle(fontFamily: AppFonts.mainFont, fontSize: 18),
        bodySmall: TextStyle(
            fontFamily: AppFonts.mainFont,
            fontSize: 14,
            fontWeight: FontWeight.w300),
      ));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.accentDark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: ColorScheme.dark(
          primary: AppColors.accentDark,
          secondary: AppColors.accentDark,
          surface: AppColors.darkBackground,
          onSurface: AppColors.onDarkBackground,
          surfaceContainer: AppColors.darkBackgroundContainer),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
            fontFamily: AppFonts.mainFont,
            fontWeight: FontWeight.w700,
            fontSize: 22),
        bodyMedium: TextStyle(fontFamily: AppFonts.mainFont, fontSize: 18),
        bodySmall: TextStyle(
            fontFamily: AppFonts.mainFont,
            fontSize: 14,
            fontWeight: FontWeight.w300),
      ));
}
