// lib/widgets/pricing_section.dart
import 'package:flutter/material.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

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
            'Choose your plan',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
              // textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 64),
          _buildPricingCards(context),
        ],
      ),
    );
  }

  Widget _buildPricingCards(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 1024;

    final plans = [
      _PricingPlan(
        name: 'Anonymous',
        price: '0',
        period: 'forever',
        description: 'Try our platform without even signing up',
        features: [
          '20 questions per day',
          '2 AI explanations per day',
          '1 sprint exam',
          '1 half-length simulated exam',
          '1 device',
          'Basic analytics',
        ],
        isPopular: false,
      ),
      _PricingPlan(
        name: 'Free',
        price: '0',
        period: '2 weeks',
        description: '2-week trial to test the platform',
        features: [
          '50 questions per day',
          '4 AI explanations per day',
          '4 sprint exams total',
          '2 simulated real exams',
          '3 devices with sync',
          'Basic analytics',
          'Cross-device sync',
        ],
        isPopular: false,
      ),
      _PricingPlan(
        name: 'Pro',
        price: '9.99',
        period: 'month',
        description: 'For serious exam preparation',
        features: [
          'Unlimited questions',
          'Unlimited AI explanations',
          'Unlimited sprint exams',
          'Unlimited simulated exams',
          'Unlimited devices',
          'Advanced analytics',
          'Social features',
          'Priority support',
          'Cross-device sync',
        ],
        isPopular: true,
      ),
    ];

    if (isDesktop) {
      return Row(
        children: plans
            .map(
              (plan) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _buildPricingCard(context, plan),
                ),
              ),
            )
            .toList(),
      );
    } else {
      return Column(
        children: plans
            .map(
              (plan) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: _buildPricingCard(context, plan),
              ),
            )
            .toList(),
      );
    }
  }

  Widget _buildPricingCard(BuildContext context, _PricingPlan plan) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: plan.isPopular
            ? theme.colorScheme.primary.withOpacity(0.05)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: plan.isPopular
              ? theme.colorScheme.primary
              : theme.colorScheme.outline.withOpacity(0.1),
          width: plan.isPopular ? 2 : 1,
        ),
        boxShadow: plan.isPopular
            ? [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        children: [
          if (plan.isPopular)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Most Popular',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          if (plan.isPopular) const SizedBox(height: 16),

          Text(
            plan.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),

          plan.name == 'Anonymous'
              ? Text(
                  'Free',
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                )
              : RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '\$${plan.price}',
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      TextSpan(
                        text: '/${plan.period}',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
          const SizedBox(height: 16),

          Text(
            plan.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          ...plan.features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      feature,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: plan.isPopular
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surface,
                foregroundColor: plan.isPopular
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.primary,
                side: plan.isPopular
                    ? null
                    : BorderSide(color: theme.colorScheme.primary),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Choose Plan',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PricingPlan {
  final String name;
  final String price;
  final String period;
  final String description;
  final List<String> features;
  final bool isPopular;

  _PricingPlan({
    required this.name,
    required this.price,
    required this.period,
    required this.description,
    required this.features,
    required this.isPopular,
  });
}
