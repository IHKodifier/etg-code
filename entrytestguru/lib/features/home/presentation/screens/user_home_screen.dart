import 'package:entrytestguru/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/user.dart';
import '../../../../core/services/firebase_auth_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/navigation_rail.dart';

// just arandom commit for a new push to remote repo
// after the creation of new repo to come out of github actions commit  disasters
class UserHomeScreen extends ConsumerWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final authService = ref.read(authServiceProvider);

    print('UserHomeScreen: Building with auth state - $authState');

    return authState.when(
      data: (user) {
        print('UserHomeScreen: User data received - $user');
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
                    } else if (value == 'sign_up') {
                      // Handle sign up for anonymous users
                      print('Sign Up selected for anonymous user');
                      // Navigate to login screen for sign up
                      Navigator.pushNamed(context, '/login');
                    }
                  },
                  itemBuilder: (BuildContext context) => user.isAnonymous
                      ? [
                          const PopupMenuItem<String>(
                            value: 'sign_up',
                            child: Text('Sign Up'),
                          ),
                        ]
                      : [
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
            _buildRoleBasedQuickActions(context, user),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleBasedQuickActions(BuildContext context, User user) {
    final userRole = user.role;
    final userTier = user.tier;

    // Admin and Content Creator get different actions
    if (userRole == 'admin' || userRole == 'contentCreator') {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: 'Manage Questions',
                  onPressed: () {
                    Navigator.pushNamed(context, '/questions');
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  text: 'Practice MCQs',
                  onPressed: () {
                    Navigator.pushNamed(context, '/practice');
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
                  text: 'Review Submissions',
                  type: ButtonType.outline,
                  onPressed: () {
                    // TODO: Navigate to review dashboard
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Review dashboard coming soon!'),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  text: 'Analytics',
                  type: ButtonType.outline,
                  onPressed: () {
                    // TODO: Navigate to analytics
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Analytics dashboard coming soon!'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      );
    }

    // Content Reviewer gets review-focused actions
    if (userRole == 'contentReviewer') {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: 'Review Questions',
                  onPressed: () {
                    // TODO: Navigate to review dashboard
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Review dashboard coming soon!'),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  text: 'Practice MCQs',
                  onPressed: () {
                    Navigator.pushNamed(context, '/practice');
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
                  text: 'Approved Questions',
                  type: ButtonType.outline,
                  onPressed: () {
                    // TODO: Navigate to approved questions
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Approved questions view coming soon!'),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  text: 'Pending Reviews',
                  type: ButtonType.outline,
                  onPressed: () {
                    // TODO: Navigate to pending reviews
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pending reviews view coming soon!'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      );
    }

    // Regular users get standard practice actions
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: 'Practice MCQs',
                onPressed: () {
                  Navigator.pushNamed(context, '/practice');
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppButton(
                text: 'Take Exam',
                onPressed: () {
                  // TODO: Navigate to exam
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Exam feature coming soon!')),
                  );
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
                  // TODO: Navigate to review mistakes
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Review mistakes feature coming soon!'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppButton(
                text: 'View Progress',
                type: ButtonType.outline,
                onPressed: () {
                  // TODO: Navigate to progress
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Progress view coming soon!')),
                  );
                },
              ),
            ),
          ],
        ),
        // Show upgrade prompt for free users
        if (userTier == 'free' || userTier == 'anonymous') ...[
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primary200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.upgrade, color: AppColors.primary600),
                    const SizedBox(width: 8),
                    Text(
                      'Upgrade to Paid',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  userTier == 'anonymous'
                      ? 'Create an account to unlock unlimited questions and premium features!'
                      : 'Get unlimited access to all questions, advanced analytics, and priority support.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.primary600),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    text: userTier == 'anonymous'
                        ? 'Create Account'
                        : 'Upgrade Now',
                    onPressed: () {
                      // TODO: Navigate to upgrade flow
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Upgrade flow coming soon!'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
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
              'Your Account',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            // Role and Tier Information
            Card(
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _getTierIcon(user.tier),
                          color: _getTierColor(user.tier),
                          size: 32,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user.tier.capitalize()} Plan',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _getTierDescription(user.tier),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Role Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getRoleColor(user.role).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _getRoleColor(user.role),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        _getRoleDisplayName(user.role),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getRoleColor(user.role),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Subscription expiry for paid users
                    if (user.tier == 'paid' &&
                        user.subscriptionExpiry != null) ...[
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Expires: ${_formatDate(user.subscriptionExpiry!)}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ],
                    // Trial expiry for anonymous users
                    if (user.tier == 'anonymous' &&
                        user.trialExpiry != null) ...[
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 16,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Trial expires: ${_formatDate(user.trialExpiry!)}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTierIcon(String tier) {
    switch (tier) {
      case 'paid':
        return Icons.workspace_premium;
      case 'free':
        return Icons.star_border;
      case 'anonymous':
        return Icons.person_outline;
      default:
        return Icons.help_outline;
    }
  }

  Color _getTierColor(String tier) {
    switch (tier) {
      case 'paid':
        return Colors.amber;
      case 'free':
        return AppColors.primary600;
      case 'anonymous':
        return Colors.grey;
      default:
        return AppColors.primary600;
    }
  }

  String _getTierDescription(String tier) {
    switch (tier) {
      case 'paid':
        return 'Unlimited access to all features and premium support';
      case 'free':
        return 'Basic access with daily limits (50 MCQs/day, 4 explanations/day)';
      case 'anonymous':
        return 'Trial access with limited features (20 MCQs/day, 2 explanations/day)';
      default:
        return 'Unknown tier';
    }
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'admin':
        return Colors.red;
      case 'contentReviewer':
        return Colors.blue;
      case 'contentCreator':
        return Colors.green;
      case 'regularUser':
        return Colors.purple;
      default:
        return AppColors.primary600;
    }
  }

  String _getRoleDisplayName(String role) {
    switch (role) {
      case 'admin':
        return 'Administrator';
      case 'contentReviewer':
        return 'Content Reviewer';
      case 'contentCreator':
        return 'Content Creator';
      case 'regularUser':
        return 'Regular User';
      default:
        return 'User';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
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
                onPressed: () async {
                  final authService = ref.read(authServiceProvider);
                  final currentUser = await authService.getCurrentUser();
                  await authService.signOut();
                  print(
                    'UserHomeScreen: Sign out successful for user UID: ${currentUser?.id}',
                  );
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
