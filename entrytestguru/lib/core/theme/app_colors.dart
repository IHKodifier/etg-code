// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Your Anchor Colors from the palette
  static const Color lightText = Color(0xFF1C1C28); // Dark navy text
  static const Color lightBackground = Color(
    0xFFF5F5F7,
  ); // Light gray background
  static const Color lightPrimary = Color(0xFF3B4A87); // Navy blue primary
  static const Color lightSecondary = Color(0xFFe82d37); // Coral secondary
  static const Color lightAccent = Color(0xFFD4A574); // Golden accent

  static const Color darkText = Color(0xFFE5E5EA); // Light gray text
  static const Color darkBackground = Color(0xFF1C1C28); // Dark navy background
  static const Color darkPrimary = Color(0xFF7B8FC7); // Light blue primary
  static const Color darkSecondary = Color(0xFFB04545); // Deep red secondary
  static const Color darkAccent = Color(0xFFD4A574); // Golden accent (same)

  // Material 3 Primary Scale (Using navy blue as primary)
  static const Color primary50 = Color(0xFFF2F3F8); // Very light navy tint
  static const Color primary100 = Color(0xFFE1E4F0); // Light navy
  static const Color primary200 = Color(0xFFC3CAE1); // Medium light navy
  static const Color primary300 = Color(0xFFA5AFD2); // Light navy blend
  static const Color primary400 = Color(0xFF8695C3); // Medium navy
  static const Color primary500 = Color(
    0xFF3B4A87,
  ); // Your navy blue (light primary)
  static const Color primary600 = Color(0xFF323F75); // Darker navy
  static const Color primary700 = Color(0xFF2A3463); // Deep navy
  static const Color primary800 = Color(0xFF212951); // Very deep navy
  static const Color primary900 = Color(
    0xFF1C1C28,
  ); // Your dark navy (text/background)

  // Secondary Scale (Using coral/red as secondary)
  static const Color secondary50 = Color(0xFFFDF2F2); // Very light coral tint
  static const Color secondary100 = Color(0xFFFBE1E1); // Light coral
  static const Color secondary200 = Color(0xFFF6BBBB); // Medium light coral
  static const Color secondary300 = Color(0xFFF19595); // Light coral blend
  static const Color secondary400 = Color(0xFFEC7070); // Medium coral
  static const Color secondary500 = Color(
    0xFFE85A5A,
  ); // Your coral (light secondary)
  static const Color secondary600 = Color(
    0xFFB04545,
  ); // Your deep red (dark secondary)
  static const Color secondary700 = Color(0xFF953737); // Darker red
  static const Color secondary800 = Color(0xFF7A2929); // Deep red
  static const Color secondary900 = Color(0xFF5F1B1B); // Darkest red

  // Tertiary Scale (Using golden accent)
  static const Color tertiary50 = Color(0xFFFEFBF7); // Very light golden tint
  static const Color tertiary100 = Color(0xFFFDF5E8); // Light golden
  static const Color tertiary200 = Color(0xFFFAE8C7); // Medium light golden
  static const Color tertiary300 = Color(0xFFF7DBA6); // Light golden blend
  static const Color tertiary400 = Color(0xFFF4CE85); // Medium golden
  static const Color tertiary500 = Color(0xFFD4A574); // Your golden accent
  static const Color tertiary600 = Color(0xFFB8905F); // Darker golden
  static const Color tertiary700 = Color(0xFF9C7B4A); // Deep golden
  static const Color tertiary800 = Color(0xFF806635); // Very deep golden
  static const Color tertiary900 = Color(0xFF645120); // Darkest golden

  // Neutral Scale (Based on your backgrounds)
  static const Color neutral50 = Color(0xFFFAFAFC); // Very light neutral
  static const Color neutral100 = Color(0xFFF5F5F7); // Your light background
  static const Color neutral200 = Color(0xFFEBEBEF); // Light neutral
  static const Color neutral300 = Color(0xFFD1D1D8); // Medium light neutral
  static const Color neutral400 = Color(0xFFB7B7C1); // Medium neutral
  static const Color neutral500 = Color(0xFF9D9DAA); // Medium dark neutral
  static const Color neutral600 = Color(0xFF838393); // Dark neutral
  static const Color neutral700 = Color(0xFF69697C); // Deep neutral
  static const Color neutral800 = Color(0xFF4F4F65); // Very deep neutral
  static const Color neutral900 = Color(0xFF1C1C28); // Your dark navy

  // User Tier Colors
  static const Color anonymousPrimary = Color(0xFF9D9DAA); // Medium neutral
  static const Color freePrimary = Color(0xFF3B4A87); // Your navy blue
  static const Color paidPrimary = Color(0xFFE85A5A); // Your coral

  // ARDE Probability Colors
  static const Color ardeHigh = Color(0xFFE85A5A); // Coral for high priority
  static const Color ardeMedium = Color(0xFFD4A574); // Golden for medium
  static const Color ardeLow = Color(0xFF9D9DAA); // Neutral for low

  // Semantic Colors
  static const Color success = Color(0xFF28A745); // Standard green
  static const Color warning = Color(0xFFD4A574); // Your golden accent
  static const Color error = Color(0xFFE85A5A); // Your coral
  static const Color info = Color(0xFF3B4A87); // Your navy blue

  // Dark Theme Colors
  static const Color darkBgPrimary = Color(0xFF1C1C28); // Your dark navy
  static const Color darkBgSecondary = Color(
    0xFF212951,
  ); // Slightly lighter navy
  static const Color darkBgTertiary = Color(0xFF2A3463); // Medium navy
  static const Color darkBgAccent = Color(0xFF323F75); // Lighter navy

  static const Color darkTextPrimary = Color(
    0xFFE5E5EA,
  ); // Your light gray text
  static const Color darkTextSecondary = Color(
    0xFFD1D1D8,
  ); // Medium light neutral
  static const Color darkTextTertiary = Color(0xFFB7B7C1); // Medium neutral
  static const Color darkTextMuted = Color(0xFF9D9DAA); // Medium dark neutral

  // Light Theme Colors
  static const Color lightBgPrimary = Color(0xFFFFFFFF); // Pure white
  static const Color lightBgSecondary = Color(
    0xFFF5F5F7,
  ); // Your light background
  static const Color lightBgTertiary = Color(0xFFEBEBEF); // Light neutral
  static const Color lightBgAccent = Color(0xFFD1D1D8); // Medium light neutral

  static const Color lightTextPrimary = Color(
    0xFF1C1C28,
  ); // Your dark navy text
  static const Color lightTextSecondary = Color(
    0xFF4F4F65,
  ); // Very deep neutral
  static const Color lightTextTertiary = Color(0xFF69697C); // Deep neutral
  static const Color lightTextMuted = Color(0xFF838393); // Dark neutral

  // Material 3 Additional Colors
  static const Color surface = Color(0xFFF5F5F7); // Your light background
  static const Color surfaceVariant = Color(0xFFEBEBEF); // Light neutral
  static const Color outline = Color(0xFF838393); // Dark neutral
  static const Color outlineVariant = Color(0xFFB7B7C1); // Medium neutral
  static const Color shadow = Color(0xFF1C1C28); // Your dark navy
  static const Color scrim = Color(0xFF1C1C28); // Your dark navy
  static const Color inverseSurface = Color(0xFF1C1C28); // Your dark navy
  static const Color inverseOnSurface = Color(
    0xFFE5E5EA,
  ); // Your light gray text
  static const Color inversePrimary = Color(
    0xFF7B8FC7,
  ); // Your light blue (dark primary)
}
