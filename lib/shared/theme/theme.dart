import 'package:flutter/material.dart';
import 'package:task_manager_krainet/shared/colors.dart';

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
  );

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
  );
}
