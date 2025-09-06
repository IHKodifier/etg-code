// lib/widgets/app_card.dart
import 'package:flutter/material.dart';
import '../core/theme/app_dimensions.dart';
import '../core/utils/responsive_utils.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? elevation;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.elevation,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    EdgeInsetsGeometry cardPadding;
    if (padding != null) {
      cardPadding = padding!;
    } else if (isDesktop) {
      cardPadding = const EdgeInsets.all(AppDimensions.space6);
    } else if (isTablet) {
      cardPadding = const EdgeInsets.all(AppDimensions.space5);
    } else {
      cardPadding = const EdgeInsets.all(AppDimensions.space4);
    }

    return Card(
      elevation: elevation ?? 2,
      color: backgroundColor ?? Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: Padding(padding: cardPadding, child: child),
      ),
    );
  }
}
