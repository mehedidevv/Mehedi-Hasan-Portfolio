import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
      ),
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w800,
          height: 1.1,
        ),
        displayMedium: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          height: 1.15,
        ),
        headlineMedium: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textSecondary,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textSecondary,
          height: 1.5,
        ),
      ),
      dividerColor: AppColors.border,
    );
  }
}
