class AppDimensions {
  // Material 3 Window Size Classes
  static const String compact = 'COMPACT'; // 0-600dp (Phones, portrait tablets)
  static const String medium =
      'MEDIUM'; // 600-840dp (Large phones, small tablets)
  static const String expanded =
      'EXPANDED'; // 840dp+ (Tablets, desktops, foldables unfolded)

  // Material 3 Breakpoint Values
  static const double compactEnd = 600.0; // End of compact range
  static const double mediumStart = 601.0; // Start of medium range
  static const double mediumEnd = 840.0; // End of medium range
  static const double expandedStart = 841.0; // Start of expanded range

  // Legacy breakpoints for compatibility
  static const double mobileBreakpoint = 600.0; // Same as compactEnd
  static const double tabletBreakpoint = 600.0;
  static const double desktopBreakpoint = 840.0;

  // Spacing Scale (Material 3 8dp baseline grid)
  static const double space1 = 4.0; // 0.5 * 8dp
  static const double space2 = 8.0; // 1 * 8dp
  static const double space3 = 12.0; // 1.5 * 8dp
  static const double space4 = 16.0; // 2 * 8dp
  static const double space5 = 20.0; // 2.5 * 8dp
  static const double space6 = 24.0; // 3 * 8dp
  static const double space8 = 32.0; // 4 * 8dp
  static const double space10 = 40.0; // 5 * 8dp
  static const double space12 = 48.0; // 6 * 8dp
  static const double space16 = 64.0; // 8 * 8dp
  static const double space20 = 80.0; // 10 * 8dp

  // Material 3 Border Radius Scale
  static const double radiusNone = 0.0;
  static const double radiusExtraSmall = 4.0;
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusExtraLarge = 28.0;
  static const double radiusCircular = 1000.0; // Fully rounded

  // Legacy radius names
  static const double radiusXLarge = radiusExtraLarge;
  static const double radiusRound = radiusCircular;

  // Material 3 Touch Targets
  static const double minTouchTarget = 48.0; // Material 3 minimum
  static const double comfortableTouchTarget = 56.0; // Recommended size

  // Dynamic Card Padding (Material 3 spacing)
  static const double cardPaddingBase = 16.0; // Compact windows
  static const double cardPaddingMedium = 24.0; // Medium windows
  static const double cardPaddingLarge = 32.0; // Expanded windows

  // Legacy card padding names
  static const double cardPaddingMobile = cardPaddingBase;
  static const double cardPaddingTablet = cardPaddingMedium;
  static const double cardPaddingDesktop = cardPaddingLarge;
}
