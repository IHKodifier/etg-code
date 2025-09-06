import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../core/theme/app_dimensions.dart';

class ThemeSwitcher extends ConsumerWidget {
  final bool showLabels;

  const ThemeSwitcher({super.key, this.showLabels = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);

    if (showLabels) {
      return SegmentedButton<ThemeMode>(
        segments: const [
          ButtonSegment<ThemeMode>(
            value: ThemeMode.light,
            label: Text('Light'),
            icon: Icon(Icons.light_mode),
          ),
          ButtonSegment<ThemeMode>(
            value: ThemeMode.system,
            label: Text('System'),
            icon: Icon(Icons.brightness_auto),
          ),
          ButtonSegment<ThemeMode>(
            value: ThemeMode.dark,
            label: Text('Dark'),
            icon: Icon(Icons.dark_mode),
          ),
        ],
        selected: {themeMode},
        onSelectionChanged: (Set<ThemeMode> newSelection) {
          themeNotifier.setTheme(newSelection.first);
        },
      );
    }

    return PopupMenuButton<ThemeMode>(
      icon: Icon(_getThemeIcon(themeMode)),
      onSelected: themeNotifier.setTheme,
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.light,
          child: ListTile(
            leading: const Icon(Icons.light_mode),
            title: const Text('Light Theme'),
            trailing: themeMode == ThemeMode.light
                ? const Icon(Icons.check)
                : null,
            contentPadding: EdgeInsets.zero,
            dense: true,
          ),
        ),
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.system,
          child: ListTile(
            leading: const Icon(Icons.brightness_auto),
            title: const Text('System Theme'),
            trailing: themeMode == ThemeMode.system
                ? const Icon(Icons.check)
                : null,
            contentPadding: EdgeInsets.zero,
            dense: true,
          ),
        ),
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.dark,
          child: ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Theme'),
            trailing: themeMode == ThemeMode.dark
                ? const Icon(Icons.check)
                : null,
            contentPadding: EdgeInsets.zero,
            dense: true,
          ),
        ),
      ],
    );
  }

  IconData _getThemeIcon(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }
}
