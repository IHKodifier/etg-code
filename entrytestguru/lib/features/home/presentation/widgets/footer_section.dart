// lib/widgets/footer_section.dart
import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 16,
        vertical: 40,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: theme.colorScheme.outline.withOpacity(0.1)),
        ),
      ),
      child: Column(
        children: [
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildCompanyInfo(context)),
                Expanded(
                  child: _buildFooterColumn(context, 'Product', [
                    'Features',
                    'Pricing',
                    'Security',
                  ]),
                ),
                Expanded(
                  child: _buildFooterColumn(context, 'Company', [
                    'About',
                    'Blog',
                    'Careers',
                  ]),
                ),
                Expanded(
                  child: _buildFooterColumn(context, 'Support', [
                    'Help Center',
                    'Contact',
                    'Status',
                  ]),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCompanyInfo(context),
                const SizedBox(height: 32),
                _buildFooterColumn(context, 'Product', [
                  'Features',
                  'Pricing',
                  'Security',
                ]),
                const SizedBox(height: 24),
                _buildFooterColumn(context, 'Company', [
                  'About',
                  'Blog',
                  'Careers',
                ]),
                const SizedBox(height: 24),
                _buildFooterColumn(context, 'Support', [
                  'Help Center',
                  'Contact',
                  'Status',
                ]),
              ],
            ),
          const SizedBox(height: 32),
          Divider(color: theme.colorScheme.outline.withOpacity(0.1)),
          const SizedBox(height: 16),
          Text(
            '© 2024 Essentials. All rights reserved.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyInfo(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.hexagon, color: theme.colorScheme.primary, size: 24),
            const SizedBox(width: 8),
            Text(
              'Essentials',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'The world\'s most powerful business intelligence platform designed for modern teams.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterColumn(
    BuildContext context,
    String title,
    List<String> items,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),
              child: Text(
                item,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
