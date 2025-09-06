// lib/widgets/arde_badge.dart
import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_dimensions.dart';

class ArdeBadge extends StatelessWidget {
  final ArdeProbability probability;
  final bool showLabel;

  const ArdeBadge({
    super.key,
    required this.probability,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.space3,
        vertical: AppDimensions.space2,
      ),
      decoration: BoxDecoration(
        color: _getBackgroundColor().withOpacity(0.1),
        border: Border.all(color: _getColor(), width: 1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusExtraLarge),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getIcon(), size: 12, color: _getColor()),
          if (showLabel) ...[
            const SizedBox(width: AppDimensions.space1),
            Text(
              _getLabel(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: _getColor(),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getColor() {
    switch (probability) {
      case ArdeProbability.high:
        return AppColors.ardeHigh;
      case ArdeProbability.medium:
        return AppColors.ardeMedium;
      case ArdeProbability.low:
        return AppColors.ardeLow;
    }
  }

  Color _getBackgroundColor() {
    return _getColor();
  }

  IconData _getIcon() {
    switch (probability) {
      case ArdeProbability.high:
        return Icons.trending_up;
      case ArdeProbability.medium:
        return Icons.trending_flat;
      case ArdeProbability.low:
        return Icons.trending_down;
    }
  }

  String _getLabel() {
    switch (probability) {
      case ArdeProbability.high:
        return 'HIGH ARDE';
      case ArdeProbability.medium:
        return 'MED ARDE';
      case ArdeProbability.low:
        return 'LOW ARDE';
    }
  }
}

enum ArdeProbability { high, medium, low }
