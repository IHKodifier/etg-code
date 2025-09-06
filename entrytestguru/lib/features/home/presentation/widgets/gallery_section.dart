// lib/widgets/gallery_section.dart
import 'package:flutter/material.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 16,
        vertical: 80,
      ),
      child: Column(
        children: [
          Text(
            'Explore Latest Projects',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
              // textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 64),
          _buildGalleryGrid(context),
        ],
      ),
    );
  }

  Widget _buildGalleryGrid(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isDesktop ? 4 : 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: List.generate(4, (index) {
        final colors = [
          theme.colorScheme.primary,
          theme.colorScheme.secondary,
          theme.colorScheme.tertiary,
          theme.colorScheme.primary.withOpacity(0.7),
        ];

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [colors[index], colors[index].withOpacity(0.7)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Icon(Icons.image, size: 40, color: Colors.white),
          ),
        );
      }),
    );
  }
}
