import 'package:flutter/material.dart';
import '../theme/app_dimensions.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppDimensions.mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppDimensions.mobileBreakpoint &&
        width < AppDimensions.desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppDimensions.desktopBreakpoint;
  }

  static double getResponsivePadding(BuildContext context) {
    if (isDesktop(context)) {
      return AppDimensions.space6;
    } else if (isTablet(context)) {
      return AppDimensions.space5;
    } else {
      return AppDimensions.space4;
    }
  }

  static int getGridColumns(BuildContext context) {
    if (isDesktop(context)) {
      return 4;
    } else if (isTablet(context)) {
      return 3;
    } else {
      return 2;
    }
  }

  static double getMaxContentWidth(BuildContext context) {
    return isDesktop(context) ? 1200 : double.infinity;
  }
}
