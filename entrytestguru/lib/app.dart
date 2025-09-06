import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'features/auth/presentation/screens/auth_wrapper.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/splash/presentation/screens/splash_screen.dart';

class EntryTestGuruApp extends ConsumerWidget {
  const EntryTestGuruApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return ScrollConfiguration(
      behavior: const CupertinoScrollBehavior(),
      child: MaterialApp(
        title: 'EntryTestGuru',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        home: const SplashScreen(), // Use splash screen for initial loading
        routes: {
          '/home': (context) => const AuthWrapper(),
          '/login': (context) => const LoginScreen(),
        },
      ),
    );
  }
}
