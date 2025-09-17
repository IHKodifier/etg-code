import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/user.dart';
import '../../../../core/services/firebase_auth_service.dart';
import '../widgets/add_question_widget.dart';
import '../widgets/present_question_widget.dart';

class QuestionBankScreen extends ConsumerStatefulWidget {
  const QuestionBankScreen({super.key});

  @override
  ConsumerState<QuestionBankScreen> createState() => _QuestionBankScreenState();
}

class _QuestionBankScreenState extends ConsumerState<QuestionBankScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late List<Widget> _tabs;
  late List<Widget> _tabViews;

  @override
  void initState() {
    super.initState();
    // Initialize with default values, will be updated in didChangeDependencies
    _tabController = TabController(length: 2, vsync: this);
    _tabs = [];
    _tabViews = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTabsBasedOnRole();
  }

  void _updateTabsBasedOnRole() {
    final authState = ref.watch(authStateProvider);
    final userRole = authState.maybeWhen(
      data: (user) => user?.role ?? 'regularUser',
      orElse: () => 'regularUser',
    );

    // Dispose old controller
    _tabController.dispose();

    // Create new tabs and views based on role
    if (userRole == 'admin' || userRole == 'contentCreator') {
      // Admin and Content Creator get both tabs
      _tabs = const [
        Tab(icon: Icon(Icons.add), text: 'Add Question'),
        Tab(icon: Icon(Icons.question_answer), text: 'Practice'),
      ];
      _tabViews = const [AddQuestionWidget(), PresentQuestionWidget()];
      _tabController = TabController(length: 2, vsync: this);
    } else if (userRole == 'contentReviewer') {
      // Content Reviewer gets review and practice tabs
      _tabs = const [
        Tab(icon: Icon(Icons.rate_review), text: 'Review'),
        Tab(icon: Icon(Icons.question_answer), text: 'Practice'),
      ];
      _tabViews = const [
        Center(child: Text('Review dashboard coming soon!')),
        PresentQuestionWidget(),
      ];
      _tabController = TabController(length: 2, vsync: this);
    } else {
      // Regular users only get practice tab
      _tabs = const [Tab(icon: Icon(Icons.question_answer), text: 'Practice')];
      _tabViews = const [PresentQuestionWidget()];
      _tabController = TabController(length: 1, vsync: this);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          return const Scaffold(body: Center(child: Text('User not found')));
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Question Bank'),
            bottom: _tabs.length > 1
                ? TabBar(controller: _tabController, tabs: _tabs)
                : null,
          ),
          body: _tabs.length > 1
              ? TabBarView(controller: _tabController, children: _tabViews)
              : _tabViews.first,
        );
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
}
