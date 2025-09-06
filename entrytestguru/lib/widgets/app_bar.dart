import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/theme_provider.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import 'app_logo.dart';

// import '../../../../core/theme/app_colors.dart';

class AppBar extends ConsumerWidget {
  const AppBar({super.key});

  void _showMobileMenu(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true, // Allow full height usage
      builder: (BuildContext context) {
        final theme = Theme.of(context);
        final screenHeight = MediaQuery.of(context).size.height;

        return Container(
          constraints: BoxConstraints(
            maxHeight: screenHeight * 0.8, // Use up to 80% of screen height
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: theme.colorScheme.outline.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Menu',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),

              // Scrollable content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Navigation Items
                      _buildMobileMenuItem(
                        context,
                        'Home',
                        Icons.home_outlined,
                        () {
                          Navigator.pop(context);
                          // Scroll to top or navigate to home
                        },
                      ),
                      _buildMobileMenuItem(
                        context,
                        'About',
                        Icons.info_outlined,
                        () {
                          Navigator.pop(context);
                          // Navigate to about
                        },
                      ),
                      _buildMobileMenuItem(
                        context,
                        'Services',
                        Icons.build_outlined,
                        () {
                          Navigator.pop(context);
                          // Navigate to services
                        },
                      ),
                      _buildMobileMenuItem(
                        context,
                        'Portfolio',
                        Icons.work_outlined,
                        () {
                          Navigator.pop(context);
                          // Navigate to portfolio
                        },
                      ),
                      _buildMobileMenuItem(
                        context,
                        'Blog',
                        Icons.article_outlined,
                        () {
                          Navigator.pop(context);
                          // Navigate to blog
                        },
                      ),
                      _buildMobileMenuItem(
                        context,
                        'Contact',
                        Icons.contact_mail_outlined,
                        () {
                          Navigator.pop(context);
                          // Navigate to contact
                        },
                      ),

                      const Divider(height: 24),

                      // Auth Buttons
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: theme.colorScheme.onSurface,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              child: const Text('Login'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              child: const Text('Sign Up'),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Theme Toggle
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: theme.colorScheme.outline.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: Icon(
                            theme.brightness == Brightness.light
                                ? Icons.dark_mode_outlined
                                : Icons.light_mode_outlined,
                            color: theme.colorScheme.onSurface,
                          ),
                          title: const Text('Theme'),
                          trailing: PopupMenuButton<ThemeMode>(
                            icon: Icon(
                              theme.brightness == Brightness.light
                                  ? Icons.dark_mode_outlined
                                  : Icons.light_mode_outlined,
                              color: theme.colorScheme.onSurface,
                            ),
                            onSelected: (ThemeMode value) {
                              ref.read(themeProvider.notifier).setTheme(value);
                              Navigator.pop(context);
                            },
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem<ThemeMode>(
                                value: ThemeMode.light,
                                child: Row(
                                  children: [
                                    Icon(Icons.light_mode, size: 20),
                                    const SizedBox(width: 8),
                                    const Text('Light Theme'),
                                  ],
                                ),
                              ),
                              PopupMenuItem<ThemeMode>(
                                value: ThemeMode.dark,
                                child: Row(
                                  children: [
                                    Icon(Icons.dark_mode, size: 20),
                                    const SizedBox(width: 8),
                                    const Text('Dark Theme'),
                                  ],
                                ),
                              ),
                              PopupMenuItem<ThemeMode>(
                                value: ThemeMode.system,
                                child: Row(
                                  children: [
                                    Icon(Icons.brightness_auto, size: 20),
                                    const SizedBox(width: 8),
                                    const Text('System Theme'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: theme.colorScheme.surface,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    final isSmallDesktop =
        screenWidth > 768 && screenWidth < 1200; // Smaller desktop screens
    final themeMode = ref.watch(themeProvider);

    return SliverAppBar(
      floating: true,
      pinned: false,
      expandedHeight: 80,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 64 : 16,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            border: Border(
              bottom: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              // Logo
              const AppLogo(),

              const Spacer(),

              if (isDesktop) ...[
                // Navigation Items - make them more compact on smaller desktops
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildNavItem(
                          context,
                          'Home',
                          true,
                          isCompact: isSmallDesktop,
                        ),
                        _buildNavItem(
                          context,
                          'About',
                          false,
                          isCompact: isSmallDesktop,
                        ),
                        if (!isSmallDesktop || screenWidth > 1000) ...[
                          _buildNavItem(
                            context,
                            'Services',
                            false,
                            isCompact: isSmallDesktop,
                          ),
                          _buildNavItem(
                            context,
                            'Portfolio',
                            false,
                            isCompact: isSmallDesktop,
                          ),
                        ],
                        if (!isSmallDesktop) ...[
                          _buildNavItem(
                            context,
                            'Blog',
                            false,
                            isCompact: isSmallDesktop,
                          ),
                          _buildNavItem(
                            context,
                            'Contact',
                            false,
                            isCompact: isSmallDesktop,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Auth Buttons - make them more compact
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.onSurface,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallDesktop ? 8 : 12,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: isSmallDesktop ? 12 : 14),
                  ),
                ),

                const SizedBox(width: 8),

                // Sign Up Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallDesktop ? 8 : 12,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: isSmallDesktop ? 12 : 14),
                  ),
                ),

                const SizedBox(width: 8),

                // Theme Toggle
                PopupMenuButton<ThemeMode>(
                  icon: Icon(
                    theme.brightness == Brightness.light
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                    color: theme.colorScheme.onSurface,
                    size: isSmallDesktop ? 20 : 24,
                  ),
                  onSelected: (ThemeMode value) {
                    ref.read(themeProvider.notifier).setTheme(value);
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem<ThemeMode>(
                      value: ThemeMode.light,
                      child: Row(
                        children: [
                          Icon(Icons.light_mode, size: 20),
                          const SizedBox(width: 8),
                          const Text('Light Theme'),
                        ],
                      ),
                    ),
                    PopupMenuItem<ThemeMode>(
                      value: ThemeMode.dark,
                      child: Row(
                        children: [
                          Icon(Icons.dark_mode, size: 20),
                          const SizedBox(width: 8),
                          const Text('Dark Theme'),
                        ],
                      ),
                    ),
                    PopupMenuItem<ThemeMode>(
                      value: ThemeMode.system,
                      child: Row(
                        children: [
                          Icon(Icons.brightness_auto, size: 20),
                          const SizedBox(width: 8),
                          const Text('System Theme'),
                        ],
                      ),
                    ),
                  ],
                ),
              ] else ...[
                // Mobile menu button
                IconButton(
                  onPressed: () => _showMobileMenu(context, ref),
                  icon: Icon(Icons.menu, color: theme.colorScheme.onSurface),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String title,
    bool isActive, {
    bool isCompact = false,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isCompact ? 8 : 16),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: isActive
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface,
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: isCompact ? 8 : 16,
          ),
        ),
        child: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            fontSize: isCompact ? 13 : 14,
          ),
        ),
      ),
    );
  }
}
