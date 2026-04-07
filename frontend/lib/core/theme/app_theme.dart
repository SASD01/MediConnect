import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      surface: AppColors.background,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontSize: 22,
          height: 1.2,
          fontWeight: FontWeight.w700,
          color: AppColors.title,
        ),
        titleLarge: TextStyle(
          fontSize: 17,
          height: 1.25,
          fontWeight: FontWeight.w700,
          color: AppColors.title,
        ),
        bodyLarge: TextStyle(
          fontSize: 12,
          height: 1.4,
          fontWeight: FontWeight.w500,
          color: AppColors.subtitle,
        ),
        labelLarge: TextStyle(
          fontSize: 11,
          height: 1.25,
          fontWeight: FontWeight.w600,
          color: AppColors.subtitle,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.subtitle,
          textStyle: const TextStyle(
            fontSize: 11,
            height: 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          elevation: 0,
        ),
      ),
    );
  }
}
