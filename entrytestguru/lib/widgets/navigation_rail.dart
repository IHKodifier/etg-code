import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import 'app_logo.dart';

class AppNavigationRail extends ConsumerStatefulWidget {
  final ScrollController? scrollController;

  const AppNavigationRail({super.key, this.scrollController});

  @override
  ConsumerState<AppNavigationRail> createState() => _AppNavigationRailState();
}

class _AppNavigationRailState extends ConsumerState<AppNavigationRail> {
  int _selectedIndex = 0;

  // Define scroll positions for different sections (approximate heights)
  final Map<int, double> _sectionOffsets = {
    0: 0, // Home/Hero section
    1: 600, // About section
    2: 1200, // Services section
    3: 1800, // Portfolio section
    4: 2400, // Blog section
    5: 3000, // Contact section
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeProvider);

    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
        // Handle navigation here
        _onDestinationSelected(context, index);
      },
      labelType: NavigationRailLabelType.all,
      backgroundColor: theme.scaffoldBackgroundColor,
      selectedLabelTextStyle: TextStyle(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelTextStyle: TextStyle(
        color: theme.colorScheme.onSurface.withOpacity(0.7),
      ),
      destinations: [
        NavigationRailDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home, color: theme.colorScheme.primary),
          label: const Text('Home'),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.info_outlined),
          selectedIcon: Icon(Icons.info, color: theme.colorScheme.primary),
          label: const Text('About'),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.build_outlined),
          selectedIcon: Icon(Icons.build, color: theme.colorScheme.primary),
          label: const Text('Services'),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.work_outlined),
          selectedIcon: Icon(Icons.work, color: theme.colorScheme.primary),
          label: const Text('Portfolio'),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.article_outlined),
          selectedIcon: Icon(Icons.article, color: theme.colorScheme.primary),
          label: const Text('Blog'),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.contact_mail_outlined),
          selectedIcon: Icon(
            Icons.contact_mail,
            color: theme.colorScheme.primary,
          ),
          label: const Text('Contact'),
        ),
      ],
      trailing: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Login/Sign Up buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TextButton(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Login', style: TextStyle(fontSize: 14)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ElevatedButton(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Sign Up', style: TextStyle(fontSize: 14)),
              ),
            ),
            const SizedBox(height: 16),
            // Theme Toggle
            PopupMenuButton<ThemeMode>(
              icon: Icon(
                theme.brightness == Brightness.light
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                color: theme.colorScheme.onSurface,
                size: 20,
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _onDestinationSelected(BuildContext context, int index) {
    if (widget.scrollController != null) {
      // Scroll to the appropriate section
      final offset = _sectionOffsets[index] ?? 0;
      widget.scrollController!.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      // Handle navigation for screens without scroll controller (like user home)
      // For now, just show a snackbar indicating the feature
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Navigation to ${getSectionName(index)} coming soon!'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  String getSectionName(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'About';
      case 2:
        return 'Services';
      case 3:
        return 'Portfolio';
      case 4:
        return 'Blog';
      case 5:
        return 'Contact';
      default:
        return 'Section';
    }
  }
}
