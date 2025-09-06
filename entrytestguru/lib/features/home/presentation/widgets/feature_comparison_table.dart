// lib/features/home/presentation/widgets/feature_comparison_table.dart
import 'package:flutter/material.dart';

class FeatureComparisonTable extends StatelessWidget {
  const FeatureComparisonTable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 1024;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 16,
        vertical: 80,
      ),
      child: Column(
        children: [
          Text(
            'Compare Plans',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 64),
          _buildComparisonTable(context),
        ],
      ),
    );
  }

  Widget _buildComparisonTable(BuildContext context) {
    final theme = Theme.of(context);

    final features = [
      'Questions per day',
      'Devices',
      'AI Explanations',
      'Sprint exams',
      'Simulated real exams',
      'Analytics',
      'Cross-device sync',
      'Social features',
      'Advanced analytics',
      'Priority support',
    ];

    final plans = ['Anonymous', 'Free', 'Pro'];

    // Feature values matrix: string values for each plan-feature combination
    final featureValues = {
      'Anonymous': [
        '20', // Questions per day
        '1', // Devices
        '2/day', // AI Explanations
        '1', // Sprint exams
        '1 half-length', // Simulated real exams
        'Basic', // Analytics
        'No', // Cross-device sync
        'No', // Social features
        'No', // Advanced analytics
        'No', // Priority support
      ],
      'Free': [
        '50', // Questions per day
        '3', // Devices
        '4/day', // AI Explanations
        '4 total', // Sprint exams
        '2', // Simulated real exams
        'Basic', // Analytics
        'Yes', // Cross-device sync
        'No', // Social features
        'No', // Advanced analytics
        'No', // Priority support
      ],
      'Pro': [
        'Unlimited', // Questions per day
        'Unlimited', // Devices
        'Unlimited', // AI Explanations
        'Unlimited', // Sprint exams
        'Unlimited', // Simulated real exams
        'Advanced', // Analytics
        'Yes', // Cross-device sync
        'Yes', // Social features
        'Yes', // Advanced analytics
        'Yes', // Priority support
      ],
    };

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 32,
            headingRowHeight: 56,
            dataRowHeight: 48,
            border: TableBorder.all(
              color: theme.colorScheme.outline.withOpacity(0.2),
              width: 1,
            ),
            columns: [
              DataColumn(
                label: Container(
                  width: 140,
                  child: Text(
                    'Features',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              ...plans.map(
                (plan) => DataColumn(
                  label: Container(
                    width: 100,
                    alignment: Alignment.center,
                    child: Text(
                      plan,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: plan == 'Pro'
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
            rows: features.asMap().entries.map((entry) {
              final feature = entry.value;
              final index = entry.key;

              return DataRow(
                color: MaterialStateProperty.resolveWith<Color?>((
                  Set<MaterialState> states,
                ) {
                  if (index % 2 == 0) {
                    return theme.colorScheme.surface.withOpacity(0.3);
                  }
                  return null;
                }),
                cells: [
                  DataCell(
                    Container(
                      width: 140,
                      child: Text(
                        feature,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  ...plans.map(
                    (plan) => DataCell(
                      Container(
                        width: 100,
                        alignment: Alignment.center,
                        child: _buildFeatureValue(
                          context,
                          featureValues[plan]![index],
                          plan,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureValue(BuildContext context, String value, String plan) {
    final theme = Theme.of(context);

    Color textColor;
    FontWeight fontWeight = FontWeight.normal;

    // Green for positive features (Yes, Advanced, Unlimited)
    if (value == 'Unlimited' || value == 'Yes' || value == 'Advanced') {
      textColor = Colors.green.shade700;
      fontWeight = FontWeight.bold;
    } else {
      // Gray for everything else (limitations, numbers, "No", etc.)
      textColor = Colors.grey.shade600;
      fontWeight = FontWeight.normal;
    }

    return Text(
      value,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: textColor,
        fontWeight: fontWeight,
      ),
      textAlign: TextAlign.center,
    );
  }
}
