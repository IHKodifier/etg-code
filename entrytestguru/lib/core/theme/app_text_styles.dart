// lib/core/theme/app_text_styles.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Base font family - Using Crimson Text for academic feel
  static String get fontFamily => GoogleFonts.crimsonText().fontFamily!;
  static String get accentFontFamily => GoogleFonts.inter().fontFamily!;

  // Display Styles (Large headings)
  static TextStyle get displayLarge => GoogleFonts.crimsonText(
    fontSize: 36.0,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.5,
  );

  static TextStyle get displayMedium => GoogleFonts.crimsonText(
    fontSize: 30.0,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: -0.25,
  );

  static TextStyle get displaySmall => GoogleFonts.crimsonText(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  // Headline Styles
  static TextStyle get headlineLarge => GoogleFonts.crimsonText(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static TextStyle get headlineMedium => GoogleFonts.crimsonText(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  static TextStyle get headlineSmall => GoogleFonts.crimsonText(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  // Body Styles - Inter for better readability
  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  // Label Styles
  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.1,
  );

  static TextStyle get labelMedium => GoogleFonts.inter(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );

  static TextStyle get labelSmall => GoogleFonts.inter(
    fontSize: 10.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );

  // Specialized Styles
  static TextStyle get questionText => GoogleFonts.crimsonText(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle get mcqOption => GoogleFonts.inter(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static TextStyle get mathContent => GoogleFonts.crimsonText(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  static TextStyle get monoCode => GoogleFonts.jetBrainsMono(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );
}
