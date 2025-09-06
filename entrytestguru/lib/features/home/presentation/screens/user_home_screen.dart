import 'package:entrytestguru/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/user.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/navigation_rail.dart';

class UserHomeScreen extends ConsumerWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final authService = ref.read(authServiceProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return _buildUserHomeContent(context, user, ref);
        } else {
          // This shouldn't happen, but fallback to login if needed
          return const Center(child: Text('User not found'));
        }
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              const Text('Error loading user data'),
              const SizedBox(height: 8),
              Text(error.toString(), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Retry by invalidating the provider
                  ref.invalidate(authStateProvider);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserHomeContent(BuildContext context, User user, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 576 && screenSize.width <= 768;

    if (isTablet) {
      // Tablet layout with navigation rail
      return Scaffold(
        body: Row(
          children: [
            const AppNavigationRail(), // No scroll controller for user home
            Expanded(
              child: CustomScrollView(
                slivers: [
                  _buildAppBar(context, user, ref),
                  _buildWelcomeSection(context, user),
                  _buildStatsSection(context, user),
                  _buildQuickActionsSection(context, user),
                  _buildExamInfoSection(context, user),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      // Desktop and mobile layout with app bar
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            _buildAppBar(context, user, ref),
            _buildWelcomeSection(context, user),
            _buildStatsSection(context, user),
            _buildQuickActionsSection(context, user),
            _buildExamInfoSection(context, user),
          ],
        ),
      );
    }
  }

  Widget _buildAppBar(BuildContext context, User user, WidgetRef ref) {
    final authService = ref.read(authServiceProvider);
    return SliverAppBar(
      expandedHeight: 80,
      floating: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.getResponsivePadding(context),
          vertical: AppDimensions.space3,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  tooltip: 'Back',
                ),
                const SizedBox(
                  width: 16,
                ), // Spacing between back button and logo
                Image.asset(
                  'assets/images/ETG-Logo-dark.png',
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // User info and sign out
                if (user.profile['displayName'] != null)
                  Text(
                    user.profile['displayName'],
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                else if (user.email != null)
                  Text(
                    user.email!,
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                else
                  const Text('Guest', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 8),
                // const IconButton(
                //   Icons.account_circle,
                //   onPressed: pop,
                //   size: 24),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.account_circle), // Profile icon
                  onSelected: (String value) {
                    if (value == 'edit_profile') {
                      // Handle edit profile
                      print('Edit Profile selected');
                    } else if (value == 'sign_out') {
                      // Handle sign out
                      print('Sign Out selected');
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: 'edit_profile',
                      child: Text('Edit Profile'),
                    ),
                    PopupMenuItem<String>(
                      value: 'sign_out',
                      child: const Text('Sign Out'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: signOutConfirmationDialogbuilder,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, User user) {
    String greeting = _getGreeting();
    String userName = user.profile['displayName'] ?? user.email ?? 'User';

    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.getResponsivePadding(context),
          vertical: AppDimensions.space8,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary600, AppColors.primary700],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$greeting,',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            if (user.examType != null)
              Text(
                'Preparing for ${user.examType!.toUpperCase()}',
                style: const TextStyle(fontSize: 18, color: Colors.white70),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, User user) {
    final usageStats = user.usageStats;

    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppDimensions.space6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Progress',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStatCard(
                  context,
                  title: 'MCQs Practiced',
                  value: usageStats['practice_mcqs_today']?.toString() ?? '0',
                  icon: Icons.quiz,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  context,
                  title: 'Explanations',
                  value:
                      usageStats['explanations_used_today']?.toString() ?? '0',
                  icon: Icons.lightbulb,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStatCard(
                  context,
                  title: 'Sprint Exams',
                  value: usageStats['sprint_exams_used']?.toString() ?? '0',
                  icon: Icons.speed,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  context,
                  title: 'Full Exams',
                  value: usageStats['simulated_exams_used']?.toString() ?? '0',
                  icon: Icons.assignment,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: AppColors.primary600),
                  const SizedBox(width: 8),
                  Text(title, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionsSection(BuildContext context, User user) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppDimensions.space6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: 'Practice MCQs',
                    onPressed: () {
                      // Navigate to MCQ practice
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppButton(
                    text: 'Take Exam',
                    onPressed: () {
                      // Navigate to exam
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: 'Review Mistakes',
                    type: ButtonType.outline,
                    onPressed: () {
                      // Navigate to review
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppButton(
                    text: 'View Progress',
                    type: ButtonType.outline,
                    onPressed: () {
                      // Navigate to progress
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExamInfoSection(BuildContext context, User user) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppDimensions.space6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Subscription',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      user.tier == 'premium'
                          ? Icons.star
                          : Icons.workspace_premium_outlined,
                      color: user.tier == 'premium'
                          ? Colors.amber
                          : AppColors.primary600,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.tier.capitalize(),
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.tier == 'premium'
                              ? 'Full access to all features'
                              : 'Limited access to basic features',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Widget signOutConfirmationDialogbuilder(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => AlertDialog(
        contentPadding: const EdgeInsets.all(AppDimensions.cardPaddingDesktop),
        elevation: 5,
        content: Text(
          'Are you sure you want to log out ?',
          style: AppTextStyles.displayMedium,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppButton(
                text: 'Cancel',
                onPressed: () => Navigator.pop(context),
                type: ButtonType.outline,
              ),
              AppButton(
                text: 'Yes, Sign out',
                onPressed: () {
                  final authService = ref.read(authServiceProvider);
                  authService.signOut();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

extension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
