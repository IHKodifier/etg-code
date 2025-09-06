// lib/widgets/features_section.dart
import 'package:flutter/material.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});
  //pointless comment added to enable pushing to remote
  //"fix: DR successfully recovered, Firebase config and landing page branch merging catastrophe"
  //
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 1024;
    final isTablet = screenSize.width > 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 16,
        vertical: 80,
      ),
      child: Column(
        children: [
          SelectableText(
            'Comprehensive Exam Preparation Platform',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,

              // textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 64),
          _buildFeatureGrid(context),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 1024;
    final isTablet = screenSize.width > 768;

    final features = [
      _FeatureData(
        icon: Icons.insights,
        title: 'ARDE Intelligence',
        description:
            'Questions tagged with actual exam appearance probability and historical frequency data. Focus on what matters most for your upcoming test.',
      ),
      _FeatureData(
        icon: Icons.analytics,
        title: 'Precision Analytics',
        description:
            'Track time-per-question, attempt patterns, and topic mastery with surgical precision. Know exactly where you stand and what to improve.',
      ),
      _FeatureData(
        icon: Icons.refresh,
        title: 'Adaptive Question Variations',
        description:
            'Dynamic question variants that test true understanding, not memorization. Master concepts through intelligent question adaptation.',
      ),
      _FeatureData(
        icon: Icons.assignment,
        title: 'Realistic Exam Simulation',
        description:
            'Perfect replicas of actual exam conditions, timing, question count, marking schemes, and break intervals. Practice like it\'s the real thing.',
      ),
      _FeatureData(
        icon: Icons.schedule,
        title: 'Strategic Study Plans',
        description:
            'Time-compressed curricula that prioritize high-probability questions based on ARDE dates. Study smarter, not harder.',
      ),
      _FeatureData(
        icon: Icons.school,
        title: 'Expert-Created Content',
        description:
            '10,000+ questions with step-by-step explanations, video tutorials, and ARDE probability insights from subject matter experts.',
      ),
      _FeatureData(
        icon: Icons.devices,
        title: 'Multi-Device Management',
        description:
            'Access seamlessly across up to 3 devices with intelligent fingerprinting. Your progress syncs everywhere you study.',
      ),
      _FeatureData(
        icon: Icons.smart_toy,
        title: 'AI-Powered Tutoring',
        description:
            'Get instant follow-up tutoring for conceptual discussions. Ask questions, get clarifications, and deepen your understanding.',
      ),
      _FeatureData(
        icon: Icons.timer,
        title: 'Sprint Exams',
        description:
            'Custom sprint exams with 5-50 questions and configurable time limits. Build speed and accuracy with targeted practice sessions.',
      ),
      _FeatureData(
        icon: Icons.assignment_turned_in,
        title: 'Simulated Real Exams',
        description:
            'Full-length simulated exams matching actual ARDE conditions. Experience the pressure and timing of the real test.',
      ),
      _FeatureData(
        icon: Icons.group,
        title: 'Social Accountability',
        description:
            'Join study groups, compete on leaderboards, and participate in challenges. Stay motivated with peer accountability and friendly competition.',
      ),
      _FeatureData(
        icon: Icons.video_library,
        title: 'Learning Center',
        description:
            'Access video content, written guides, and interactive lessons from subject matter experts. Learn at your own pace with expert guidance.',
      ),
    ];

    if (isDesktop) {
      return GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 32,
        crossAxisSpacing: 32,
        children: features
            .map((feature) => _buildFeatureCard(context, feature))
            .toList(),
      );
    } else if (isTablet) {
      return GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 32,
        crossAxisSpacing: 32,
        children: features
            .map((feature) => _buildFeatureCard(context, feature))
            .toList(),
      );
    } else {
      return Column(
        children: features
            .map(
              (feature) => Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: _buildFeatureCard(context, feature),
              ),
            )
            .toList(),
      );
    }
  }

  Widget _buildFeatureCard(BuildContext context, _FeatureData feature) {
    final theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints(minHeight: 280),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Icon(
              feature.icon,
              size: 32,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: SelectableText(
              feature.title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              minLines: 1,
            ),
          ),
          const SizedBox(height: 12),
          Flexible(
            flex: 2,
            child: SelectableText(
              feature.description,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
                height: 1.4,
              ),
              textAlign: TextAlign.center,
              maxLines: 4,
              minLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureData {
  final IconData icon;
  final String title;
  final String description;

  _FeatureData({
    required this.icon,
    required this.title,
    required this.description,
  });
}
