// lib/widgets/blog_section.dart
import 'package:flutter/material.dart';

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 1024;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 16,
        vertical: 80,
      ),
      child: Column(
        children: [
          Text(
            'Our Blog',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
              // textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 64),
          _buildBlogGrid(context),
        ],
      ),
    );
  }

  Widget _buildBlogGrid(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1024;
    final blogPosts = [
      _BlogPost(
        'Getting Started with Analytics',
        'Learn the basics of business intelligence...',
      ),
      _BlogPost(
        'Advanced Data Visualization',
        'Discover powerful ways to present your data...',
      ),
      _BlogPost(
        'Team Collaboration Tips',
        'Best practices for working with your team...',
      ),
    ];

    if (isDesktop) {
      return Row(
        children: blogPosts
            .map(
              (post) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _buildBlogCard(context, post),
                ),
              ),
            )
            .toList(),
      );
    } else {
      return Column(
        children: blogPosts
            .map(
              (post) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: _buildBlogCard(context, post),
              ),
            )
            .toList(),
      );
    }
  }

  Widget _buildBlogCard(BuildContext context, _BlogPost post) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.article,
                size: 60,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  post.excerpt,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Read More',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BlogPost {
  final String title;
  final String excerpt;

  _BlogPost(this.title, this.excerpt);
}
