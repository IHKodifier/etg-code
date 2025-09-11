// lib/widgets/hero_section.dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/firebase_auth_service.dart';

class HeroSection extends ConsumerWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 768;
    final isTablet = screenSize.width > 576 && screenSize.width <= 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 16,
        vertical: isDesktop ? 80 : 40,
      ),
      child: Column(
        children: [
          if (isDesktop)
            Row(
              children: [
                Expanded(flex: 6, child: _buildContent(context, ref)),
                const SizedBox(width: 64),
                Expanded(flex: 4, child: _buildIllustration(context)),
              ],
            )
          else
            Column(
              children: [
                _buildIllustration(context),
                const SizedBox(height: 40),
                _buildContent(context, ref),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: [
            SelectableText(
              'Welcome to ',
              style: theme.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: isDesktop ? 48 : 32,
                height: 1.2,
                color: theme.colorScheme.onSurface,
              ),
            ),
            TypewriterText(
              text: 'EntryTestGuru',
              style: theme.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: isDesktop ? 48 : 32,
                height: 1.2,
              ),
              speed: const Duration(milliseconds: 120),
              pauseDuration: const Duration(seconds: 3),
              primaryColor: theme.colorScheme.primary,
              secondaryColor: const Color(0xFFE85A5A), // Coral secondary color
              baseColor: theme.colorScheme.onSurface,
            ),
          ],
        ),
        const SizedBox(height: 16),
        SelectableText(
          'Master Your Entry Tests with Intelligent Analytics and Adaptive Learning.',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
            fontSize: isDesktop ? 28 : 20,
          ),
        ),
        const SizedBox(height: 24),
        SelectableText(
          'Transform your business with cutting-edge analytics and insights. Our platform provides comprehensive data visualization and reporting tools to help you make informed decisions.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  print('HeroSection: Initiating anonymous sign-in...');
                  final authService = ref.read(authServiceProvider);
                  final authTokens = await authService.signInAnonymously();
                  print(
                    'HeroSection: Anonymous sign-in successful for user UID: ${authTokens.user.id}',
                  );
                  // Navigation will happen automatically via AuthWrapper
                } catch (e) {
                  print('HeroSection: Anonymous sign-in failed: $e');
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to sign in anonymously: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
                side: BorderSide(color: theme.colorScheme.primary),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Learn More',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIllustration(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
      color: theme.colorScheme.surface,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(48),
          boxShadow: [
            BoxShadow(
              offset: Offset(10, 5),
              blurRadius: 15,
              spreadRadius: 2,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background elements
            Positioned(
              top: 40,
              left: 40,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Positioned(
              top: 60,
              right: 60,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            // Central illustration placeholder
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(48),
                child: Image.asset(
                  'assets/images/hero_image.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration speed;
  final Duration pauseDuration;
  final Color primaryColor;
  final Color secondaryColor;
  final Color baseColor;

  const TypewriterText({
    super.key,
    required this.text,
    this.style,
    this.speed = const Duration(milliseconds: 120),
    this.pauseDuration = const Duration(seconds: 2),
    required this.primaryColor,
    required this.secondaryColor,
    required this.baseColor,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayText = '';
  int _currentIndex = 0;
  Timer? _timer;
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTyping() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(widget.speed, (timer) {
      if (_currentIndex < widget.text.length) {
        if (mounted) {
          setState(() {
            _currentIndex++;
            _displayText = widget.text.substring(0, _currentIndex);
            _isComplete = false;
          });
        }
      } else {
        // Text is complete, pause before resetting
        _timer?.cancel();
        if (mounted) {
          setState(() {
            _isComplete = true;
          });
        }
        // Use a separate timer for the pause to avoid conflicts
        Timer(widget.pauseDuration, () {
          if (mounted) {
            _resetAndRestart();
          }
        });
        return; // Exit the periodic callback
      }
    });
  }

  void _resetAndRestart() {
    setState(() {
      _displayText = '';
      _currentIndex = 0;
      _isComplete = false;
    });
    _startTyping();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(children: _buildTextSpans()));
  }

  List<TextSpan> _buildTextSpans() {
    List<TextSpan> spans = [];
    String currentText = _displayText;

    // "Welcome to " - base color
    if (currentText.startsWith('Welcome to ')) {
      spans.add(
        TextSpan(
          text: 'Welcome to ',
          style: widget.style?.copyWith(color: widget.baseColor),
        ),
      );
      currentText = currentText.substring('Welcome to '.length);
    }

    // "EntryTest" - primary color
    if (currentText.startsWith('EntryTest')) {
      spans.add(
        TextSpan(
          text: 'EntryTest',
          style: widget.style?.copyWith(color: widget.primaryColor),
        ),
      );
      currentText = currentText.substring('EntryTest'.length);
    } else if (currentText.contains('EntryTest')) {
      // Partial "EntryTest"
      String partial = currentText.substring(
        0,
        currentText.indexOf('EntryTest') + 'EntryTest'.length,
      );
      spans.add(
        TextSpan(
          text: partial,
          style: widget.style?.copyWith(color: widget.primaryColor),
        ),
      );
      currentText = currentText.substring(partial.length);
    }

    // "Guru" - secondary color
    if (currentText.startsWith('Guru')) {
      spans.add(
        TextSpan(
          text: 'Guru',
          style: widget.style?.copyWith(color: widget.secondaryColor),
        ),
      );
    } else if (currentText.isNotEmpty) {
      // Partial "Guru" or remaining text
      spans.add(
        TextSpan(
          text: currentText,
          style: widget.style?.copyWith(color: widget.secondaryColor),
        ),
      );
    }

    return spans;
  }
}
