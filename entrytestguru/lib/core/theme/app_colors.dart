// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors
  static const Color primary900 = Color(0xFF1B365D);
  static const Color primary700 = Color(0xFF2D5A87);
  static const Color primary500 = Color(0xFF4A7BA7);
  static const Color primary300 = Color(0xFF7BA3C7);
  static const Color primary100 = Color(0xFFE8F2FF);

  // User Tier Colors
  static const Color anonymousPrimary = Color(0xFF6B7280);
  static const Color freePrimary = Color(0xFF2D5A87);
  static const Color paidPrimary = Color(0xFF1B365D);

  // ARDE Probability Colors
  static const Color ardeHigh = Color(0xFFDC2626); // >70%
  static const Color ardeMedium = Color(0xFFF59E0B); // 30-70%
  static const Color ardeLow = Color(0xFF6B7280); // 0-30%

  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Dark Theme Colors
  static const Color darkBgPrimary = Color(0xFF0F172A);
  static const Color darkBgSecondary = Color(0xFF1E293B);
  static const Color darkBgTertiary = Color(0xFF334155);
  static const Color darkBgAccent = Color(0xFF475569);

  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
  static const Color darkTextTertiary = Color(0xFF94A3B8);
  static const Color darkTextMuted = Color(0xFF64748B);

  // Light Theme Colors
  static const Color lightBgPrimary = Color(0xFFFFFFFF);
  static const Color lightBgSecondary = Color(0xFFF8FAFC);
  static const Color lightBgTertiary = Color(0xFFF1F5F9);
  static const Color lightBgAccent = Color(0xFFE2E8F0);

  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF334155);
  static const Color lightTextTertiary = Color(0xFF475569);
  static const Color lightTextMuted = Color(0xFF64748B);

  // Legacy aliases for backward compatibility
  static const Color lightText = lightTextPrimary;
  static const Color lightBackground = lightBgSecondary;
  static const Color lightPrimary = primary700;
  static const Color lightSecondary = ardeHigh;
  static const Color lightAccent = warning;

  static const Color darkText = darkTextPrimary;
  static const Color darkBackground = darkBgPrimary;
  static const Color darkPrimary = primary500;
  static const Color darkSecondary = ardeHigh;
  static const Color darkAccent = warning;

  // Material 3 Primary Scale
  static const Color primary50 = Color(0xFFF0F9FF);
  static const Color primary200 = Color(0xFFBAE6FD);
  static const Color primary400 = Color(0xFF38BDF8);
  static const Color primary600 = Color(0xFF0284C7);
  static const Color primary800 = Color(0xFF075985);
  static const Color primary950 = Color(0xFF0C4A6E);

  // Secondary Scale
  static const Color secondary50 = Color(0xFFFEF2F2);
  static const Color secondary100 = Color(0xFFFEE2E2);
  static const Color secondary200 = Color(0xFFFECACA);
  static const Color secondary400 = Color(0xFFF87171);
  static const Color secondary500 = Color(0xFFEF4444);
  static const Color secondary600 = Color(0xFFDC2626);
  static const Color secondary700 = Color(0xFFB91C1C);
  static const Color secondary800 = Color(0xFF991B1B);
  static const Color secondary900 = Color(0xFF7F1D1D);

  // Tertiary Scale
  static const Color tertiary50 = Color(0xFFFFFBEB);
  static const Color tertiary100 = Color(0xFFFEF3C7);
  static const Color tertiary200 = Color(0xFFFDE68A);
  static const Color tertiary400 = Color(0xFFF59E0B);
  static const Color tertiary500 = Color(0xFFD97706);
  static const Color tertiary600 = Color(0xFFB45309);
  static const Color tertiary700 = Color(0xFF92400E);
  static const Color tertiary800 = Color(0xFF78350F);
  static const Color tertiary900 = Color(0xFF451A03);

  // Neutral Scale
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFEEEEEE);
  static const Color neutral300 = Color(0xFFE0E0E0);
  static const Color neutral400 = Color(0xFFBDBDBD);
  static const Color neutral500 = Color(0xFF9E9E9E);
  static const Color neutral600 = Color(0xFF757575);
  static const Color neutral700 = Color(0xFF616161);
  static const Color neutral800 = Color(0xFF424242);
  static const Color neutral900 = Color(0xFF212121);

  // Material 3 Additional Colors
  static const Color surface = lightBgPrimary;
  static const Color surfaceVariant = lightBgTertiary;
  static const Color outline = neutral400;
  static const Color outlineVariant = neutral300;
  static const Color shadow = neutral900;
  static const Color scrim = neutral900;
  static const Color inverseSurface = darkBgPrimary;
  static const Color inverseOnSurface = darkTextPrimary;
  static const Color inversePrimary = primary300;
}
