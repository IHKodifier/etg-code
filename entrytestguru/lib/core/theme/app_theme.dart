// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.lightPrimary, // Navy blue
        secondary: AppColors.lightSecondary, // Coral
        tertiary: AppColors.lightAccent, // Golden
        surface: AppColors.lightBgSecondary, // Light gray background
        error: AppColors.error,
        onPrimary: Colors.white, // White on navy
        onSecondary: Colors.white, // White on coral
        onTertiary: AppColors.lightText, // Dark navy on golden
        onSurface: AppColors.lightTextPrimary, // Dark navy text
        onError: Colors.white,
        outline: AppColors.outline,
      ),
      scaffoldBackgroundColor: AppColors.lightBgPrimary,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBgPrimary,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.darkPrimary, // Light blue
        secondary: AppColors.darkSecondary, // Deep red
        tertiary: AppColors.darkAccent, // Golden (same as light)
        surface: AppColors.darkBgSecondary, // Lighter navy
        error: AppColors.darkSecondary, // Deep red
        onPrimary: AppColors.darkBackground, // Dark navy on light blue
        onSecondary: Colors.white, // White on deep red
        onTertiary: AppColors.darkBackground, // Dark navy on golden
        onSurface: AppColors.darkTextPrimary, // Light gray text
        onError: Colors.white,
        outline: AppColors.darkTextTertiary,
      ),
      scaffoldBackgroundColor: AppColors.darkBgPrimary,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBgPrimary,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
