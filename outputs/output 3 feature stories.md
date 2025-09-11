# EntryTestGuru - Feature Stories

## Features List

### Authentication & User Management

#### Anonymous User Flow (Browser-Session Experience)

- **User Stories**
  - As an anonymous student, I want to try the platform on my current browser session, so that I can evaluate if it's worth my time before committing
  - As an anonymous user, I want to see exactly what limits I have on this browser, so that I understand the value of upgrading
  - As a trial user, I want to seamlessly upgrade when I hit my limits, so that my learning isn't interrupted
  - As an anonymous user, I understand my progress won't sync across devices or browsers, so that I can make informed decisions about upgrading

#### UX/UI Considerations
**Step-by-step User Journey:**
- User lands on welcome screen with clear "Continue as Guest" prominent button alongside "Sign Up" options
- Onboarding flow shows exam category selection with visual preview of question types and ARDE data availability
- Dashboard displays usage meter showing "18/20 practice questions remaining today on this browser" with progress bar
- Each interaction shows gentle reminder of tier benefits and browser-session limitations without being intrusive
- When approaching limits, soft prompts appear: "2 questions left today on this browser - unlock unlimited practice + sync across devices"
- Limit reached state shows motivational upgrade screen emphasizing cross-device sync and advanced features

- **Core Experience**
  - **Firebase Anonymous Tracking**: All limits and progress tied to Firebase Anonymous UID with browser session persistence, with clear messaging about browser-session limitations
  - **No Cross-Device Sync**: Prominent messaging that progress won't transfer between devices/browsers without account registration
  - **Simplified Analytics**: Basic session statistics without granular performance tracking or historical trends
  - **Limited AI Access**: Basic explanations without conversation history or advanced AI tutoring features
  - **Upgrade Incentives**: Clear value propositions highlighting cross-device sync, advanced analytics, and AI features

- **Advanced Users & Edge Cases**
  - **Firebase Anonymous UID Binding**: Daily limits (20 MCQs + 2 explanations) tied to Firebase Anonymous UID with browser session persistence
  - **Cloud Storage Backup**: Anonymous progress stored in Firebase with UID-based organization, no cross-browser synchronization
  - **Browser Session Tracking**: Usage limits persist across browser sessions but not across different browsers or incognito modes
  - **No Cross-Device Sync**: All anonymous progress tied to specific Firebase Anonymous UID, separate tracking for each browser/device
  - **Upgrade Path**: Seamless migration flow using Firebase Auth UID linking to transfer anonymous progress when registering for account

#### Flutter Implementation Example
```dart
// lib/features/auth/widgets/anonymous_welcome.dart
class AnonymousWelcomeWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.explore, size: 48, color: Colors.blue),
            Text('Try EntryTestGuru', style: Theme.of(context).textTheme.headlineSmall),
            Text('20 questions daily + 2 AI explanations'),
            ElevatedButton(
              onPressed: () => ref.read(authProvider.notifier).signInAnonymously(),
              child: Text('Continue as Guest'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

#### Multi-Device Authentication System (Registered Users Only)

- **User Stories**
  - As a registered student with multiple devices, I want to see all my connected devices, so that I can manage my account security
  - As a registered user adding a 4th device, I want to easily remove an old device, so that I can access my account on my new device
  - As a security-conscious registered user, I want to know when someone tries to access my account, so that I can protect my data
  - As a registered user with multiple browsers, I want them treated as one device, so that I don't waste device slots unnecessarily

#### UX/UI Considerations
**Step-by-step User Journey (Registered Users):**
- Registered user attempts login on 4th device and sees friendly blocking screen: "Account limit reached"
- Interactive device list shows: "My Laptop (Chrome, Firefox, Safari) - Last active 2 hours ago"
- Each device card has "Remove" button with confirmation dialog explaining immediate logout
- Push notification sent to existing devices: "New login attempt from iPhone - Manage devices"
- Real-time updates show device status changes across all active sessions

- **Core Experience**
  - **Device Registry**: Clean card-based layout with device icons, custom names, and session indicators (registered users only)
  - **Active Status**: Green dot indicators for online devices with "Last seen" timestamps (registered users only)
  - **Browser Consolidation**: Desktop devices show expandable browser session list with individual session management (registered users only)
  - **Removal Flow**: Smooth slide-out animation with confirmation dialog and immediate cross-device updates (registered users only)

#### Flutter Device Management Implementation
```dart
// lib/features/device/widgets/device_list.dart
class DeviceListWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(deviceProvider);
    
    return ListView.builder(
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return Card(
          child: ExpansionTile(
            leading: Icon(_getDeviceIcon(device.platform)),
            title: Text(device.name),
            subtitle: Text('Active ${device.lastSeen}'),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text('Remove Device'),
                  onTap: () => _removeDevice(ref, device),
                ),
              ],
            ),
            children: device.browserSessions.map((session) =>
              ListTile(
                dense: true,
                leading: Icon(Icons.web),
                title: Text(session.browser),
                trailing: Text(session.lastActive),
              ),
            ).toList(),
          ),
        );
      },
    );
  }
}
```

#### Anonymous User Browser Session Limitations

- **Core Experience**
  - **No Device Management Interface**: Anonymous users have no access to device management features
  - **Single Browser Session Experience**: All functionality tied to current Firebase Anonymous UID with clear messaging about browser-session limitations
  - **No Cross-Device Notifications**: No push notifications or device status tracking for anonymous users
  - **Upgrade Incentive**: Clear messaging about device management and cross-device sync benefits when registering for an account

---

### Question Bank & Content Management System

#### Content Discovery & Filtering

- **User Stories**
  - As a focused student, I want to filter questions by ARDE probability, so that I can prioritize high-yield topics
  - As a struggling student, I want to focus on my weak areas, so that I can improve my overall performance
  - As a content creator, I want to see which questions need more variations, so that I can prioritize my content creation
  - As an admin, I want to track question performance, so that I can identify content gaps

#### Flutter Filter Implementation
```dart
// lib/features/practice/widgets/question_filter.dart
class QuestionFilterWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<QuestionFilterWidget> createState() => _QuestionFilterWidgetState();
}

class _QuestionFilterWidgetState extends ConsumerState<QuestionFilterWidget> {
  final Set<String> selectedSubjects = {};
  double difficultyMin = 1.0;
  double difficultyMax = 5.0;
  ArdeLevel? selectedArde;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSubjectFilter(),
        _buildDifficultySlider(),
        _buildArdeFilter(),
        _buildQuestionPreview(),
        _buildStartButton(),
      ],
    );
  }

  Widget _buildSubjectFilter() {
    return ExpansionTile(
      title: Text('Subjects'),
      children: [
        Wrap(
          children: ['Physics', 'Chemistry', 'Biology', 'Math'].map((subject) =>
            FilterChip(
              label: Text(subject),
              selected: selectedSubjects.contains(subject),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedSubjects.add(subject);
                  } else {
                    selectedSubjects.remove(subject);
                  }
                });
                _updateQuestionCount();
              },
            ),
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildDifficultySlider() {
    return Column(
      children: [
        Text('Difficulty Range'),
        RangeSlider(
          values: RangeValues(difficultyMin, difficultyMax),
          min: 1.0,
          max: 5.0,
          divisions: 4,
          labels: RangeLabels(
            difficultyMin.round().toString(),
            difficultyMax.round().toString(),
          ),
          onChanged: (values) {
            setState(() {
              difficultyMin = values.start;
              difficultyMax = values.end;
            });
            _updateQuestionCount();
          },
        ),
      ],
    );
  }

  Widget _buildArdeFilter() {
    return Column(
      children: [
        Text('ARDE Probability'),
        ToggleButtons(
          children: [
            Text('High'),
            Text('Medium'), 
            Text('Low'),
          ],
          isSelected: [
            selectedArde == ArdeLevel.high,
            selectedArde == ArdeLevel.medium,
            selectedArde == ArdeLevel.low,
          ],
          onPressed: (index) {
            setState(() {
              selectedArde = ArdeLevel.values[index];
            });
            _updateQuestionCount();
          },
        ),
      ],
    );
  }

  Widget _buildQuestionPreview() {
    return Consumer(
      builder: (context, ref, child) {
        final questionCount = ref.watch(filteredQuestionCountProvider);
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('$questionCount questions available, ~${(questionCount * 1.5).round()} min estimated'),
        );
      },
    );
  }

  Widget _buildStartButton() {
    return ElevatedButton(
      onPressed: () {
        final filters = QuestionFilters(
          subjects: selectedSubjects,
          difficultyRange: DifficultyRange(difficultyMin, difficultyMax),
          ardeLevel: selectedArde,
        );
        ref.read(practiceProvider.notifier).startSession(filters);
      },
      child: Text('Start Practice Session'),
    );
  }

  void _updateQuestionCount() {
    // Update filter provider to recalculate question count
    final filters = QuestionFilters(
      subjects: selectedSubjects,
      difficultyRange: DifficultyRange(difficultyMin, difficultyMax),
      ardeLevel: selectedArde,
    );
    ref.read(questionFiltersProvider.notifier).updateFilters(filters);
  }
}
```

---

### Practice Mode & Learning Engine

#### Interactive Learning Experience

- **User Stories**
  - As a practicing student, I want immediate feedback on my answers, so that I can learn from my mistakes quickly
  - As a time-conscious student, I want to see how long I'm taking per question, so that I can improve my speed
  - As a visual learner, I want rich explanations with diagrams, so that I can understand concepts better
  - As a mobile user, I want smooth offline practice, so that I can study during my commute

#### Flutter Practice Implementation
```dart
// lib/features/practice/widgets/practice_question.dart
class PracticeQuestionWidget extends ConsumerStatefulWidget {
  final Question question;
  
  @override
  ConsumerState<PracticeQuestionWidget> createState() => _PracticeQuestionWidgetState();
}

class _PracticeQuestionWidgetState extends ConsumerState<PracticeQuestionWidget>
    with TickerProviderStateMixin {
  
  int? selectedAnswer;
  bool isAnswered = false;
  late AnimationController _timerController;
  late AnimationController _feedbackController;

  @override
  void initState() {
    super.initState();
    _timerController = AnimationController(
      duration: Duration(seconds: 180), // 3 minutes per question
      vsync: this,
    );
    _feedbackController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _timerController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${widget.question.number}'),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator(
              value: _timerController.value,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation(
                _timerController.value > 0.8 ? Colors.red : Colors.blue,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildUsageIndicator(),
          Expanded(child: _buildQuestionContent()),
          _buildAnswerOptions(),
          _buildSubmitButton(),
          if (isAnswered) _buildExplanationSection(),
        ],
      ),
    );
  }

  Widget _buildUsageIndicator() {
    return Consumer(
      builder: (context, ref, child) {
        final usage = ref.watch(usageProvider);
        if (!usage.isAnonymous) return SizedBox.shrink();
        
        return Container(
          padding: EdgeInsets.all(8),
          color: Colors.orange[100],
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.orange),
              SizedBox(width: 8),
              Text('${usage.mcqsUsed}/${usage.mcqLimit} questions remaining today on this browser'),
              Spacer(),
              if (usage.mcqsUsed >= usage.mcqLimit - 2)
                TextButton(
                  onPressed: () => _showUpgradeDialog(),
                  child: Text('Upgrade'),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuestionContent() {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${widget.question.number}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                _buildArdeBadge(),
              ],
            ),
            SizedBox(height: 16),
            Text(
              widget.question.text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (widget.question.imageUrl != null) ...[
              SizedBox(height: 16),
              Image.network(widget.question.imageUrl!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildArdeBadge() {
    final color = widget.question.ardeProbability == ArdeLevel.high
        ? Colors.red
        : widget.question.ardeProbability == ArdeLevel.medium
            ? Colors.orange
            : Colors.grey;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '${widget.question.ardeProbability.name.toUpperCase()} ARDE',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAnswerOptions() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: widget.question.options.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          
          return GestureDetector(
            onTap: isAnswered ? null : () => setState(() => selectedAnswer = index),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getOptionColor(index),
                border: Border.all(
                  color: _getOptionBorderColor(index),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: _getOptionCircleColor(index),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        String.fromCharCode(65 + index), // A, B, C, D
                        style: TextStyle(
                          color: _getOptionTextColor(index),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      option,
                      style: TextStyle(color: _getOptionTextColor(index)),
                    ),
                  ),
                  if (isAnswered && index == widget.question.correctAnswer)
                    Icon(Icons.check_circle, color: Colors.white),
                  if (isAnswered && selectedAnswer == index && index != widget.question.correctAnswer)
                    Icon(Icons.cancel, color: Colors.white),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Color _getOptionColor(int index) {
    if (!isAnswered) {
      return selectedAnswer == index 
          ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
          : Colors.transparent;
    }
    
    if (index == widget.question.correctAnswer) {
      return Colors.green;
    } else if (selectedAnswer == index) {
      return Colors.red;
    }
    return Colors.transparent;
  }

  Color _getOptionBorderColor(int index) {
    if (!isAnswered) {
      return selectedAnswer == index 
          ? Theme.of(context).colorScheme.primary
          : Colors.grey[300]!;
    }
    
    if (index == widget.question.correctAnswer) {
      return Colors.green;
    } else if (selectedAnswer == index) {
      return Colors.red;
    }
    return Colors.grey[300]!;
  }

  Color _getOptionCircleColor(int index) {
    if (!isAnswered) {
      return selectedAnswer == index 
          ? Theme.of(context).colorScheme.primary
          : Colors.grey[300]!;
    }
    
    if (index == widget.question.correctAnswer) {
      return Colors.white;
    } else if (selectedAnswer == index) {
      return Colors.white;
    }
    return Colors.grey[300]!;
  }

  Color _getOptionTextColor(int index) {
    if (!isAnswered) {
      return Colors.black;
    }
    
    if (index == widget.question.correctAnswer || selectedAnswer == index) {
      return Colors.white;
    }
    return Colors.black;
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: selectedAnswer != null && !isAnswered ? _submitAnswer : null,
          child: Text(isAnswered ? 'Next Question' : 'Submit Answer'),
        ),
      ),
    );
  }

  void _submitAnswer() {
    setState(() => isAnswered = true);
    _feedbackController.forward();
    _timerController.stop();
    
    // Track usage
    ref.read(usageProvider.notifier).trackMCQUsage();
  }

  Widget _buildExplanationSection() {
    return AnimatedBuilder(
      animation: _feedbackController,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, 1),
            end: Offset.zero,
          ).animate(_feedbackController),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explanation',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 8),
                Text(widget.question.explanation),
                SizedBox(height: 12),
                Consumer(
                  builder: (context, ref, child) {
                    final usage = ref.watch(usageProvider);
                    return Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: usage.canUseExplanation ? _openAIChat : null,
                          icon: Icon(Icons.psychology),
                          label: Text(
                            usage.canUseExplanation 
                                ? 'Ask AI (${usage.explanationLimit - usage.explanationsUsed} left)'
                                : 'AI Limit Reached',
                          ),
                        ),
                        if (!usage.canUseExplanation) ...[
                          SizedBox(width: 8),
                          TextButton(
                            onPressed: _showUpgradeDialog,
                            child: Text('Upgrade for unlimited'),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openAIChat() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AIChatScreen(question: widget.question),
      ),
    );
  }

  void _showUpgradeDialog() {
    showDialog(
      context: context,
      builder: (context) => UpgradeDialog(),
    );
  }

  @override
  void dispose() {
    _timerController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }
}
```

---

### Analytics & Performance Tracking

#### Comprehensive Learning Insights

#### Flutter Analytics Implementation
```dart
// lib/features/analytics/widgets/analytics_dashboard.dart
class AnalyticsDashboardWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = ref.watch(analyticsProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Performance Analytics'),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () => _exportData(ref),
          ),
        ],
      ),
      body: analytics.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (data) => _buildDashboard(data),
      ),
    );
  }

  Widget _buildDashboard(AnalyticsData data) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildMetricCards(data),
          SizedBox(height: 24),
          _buildPerformanceChart(data),
          SizedBox(height: 24),
          _buildSubjectBreakdown(data),
          SizedBox(height: 24),
          _buildRecommendations(data),
        ],
      ),
    );
  }

  Widget _buildMetricCards(AnalyticsData data) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      children: [
        _buildMetricCard(
          'Overall Accuracy',
          '${data.overallAccuracy.toStringAsFixed(1)}%',
          Icons.target,
          Colors.blue,
        ),
        _buildMetricCard(
          'Study Streak',
          '${data.currentStreak} days',
          Icons.local_fire_department,
          Colors.orange,
        ),
        _buildMetricCard(
          'Questions Attempted',
          '${data.totalQuestions}',
          Icons.quiz,
          Colors.green,
        ),
        _buildMetricCard(
          'Time Studied',
          '${data.totalTimeHours}h',
          Icons.schedule,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceChart(AnalyticsData data) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Trend',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: data.performanceHistory.asMap().entries.map((entry) =>
                        FlSpot(entry.key.toDouble(), entry.value.accuracy)
                      ).toList(),
                      isCurved: true,
                      color: Colors.blue,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final date = data.performanceHistory[value.toInt()].date;
                          return Text('${date.month}/${date.day}');
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectBreakdown(AnalyticsData data) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Subject Performance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ...data.subjectPerformance.entries.map((entry) =>
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key),
                        Text('${entry.value.toStringAsFixed(1)}%'),
                      ],
                    ),
                    SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: entry.value / 100,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation(
                        entry.value >= 80 ? Colors.green :
                        entry.value >= 60 ? Colors.orange : Colors.red,
                      ),
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

  Widget _buildRecommendations(AnalyticsData data) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI Recommendations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ...data.recommendations.map((recommendation) =>
              ListTile(
                leading: Icon(Icons.lightbulb, color: Colors.yellow[700]),
                title: Text(recommendation.title),
                subtitle: Text(recommendation.description),
                trailing: ElevatedButton(
                  onPressed: () => _applyRecommendation(recommendation),
                  child: Text('Apply'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _exportData(WidgetRef ref) {
    // Export analytics data
    ref.read(analyticsProvider.notifier).exportData();
  }

  void _applyRecommendation(Recommendation recommendation) {
    // Apply the recommendation
  }
}
```

---

### Social Features & Community Platform

#### Flutter Social Implementation
```dart
// lib/features/social/widgets/leaderboard.dart
class LeaderboardWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<LeaderboardWidget> createState() => _LeaderboardWidgetState();
}

class _LeaderboardWidgetState extends ConsumerState<LeaderboardWidget>
    with SingleTickerProviderStateMixin {
  
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboards'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Weekly'),
            Tab(text: 'Monthly'),
            Tab(text: 'All Time'),
            Tab(text: 'Friends'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLeaderboardList(LeaderboardType.weekly),
          _buildLeaderboardList(LeaderboardType.monthly),
          _buildLeaderboardList(LeaderboardType.allTime),
          _buildLeaderboardList(LeaderboardType.friends),
        ],
      ),
    );
  }

  Widget _buildLeaderboardList(LeaderboardType type) {
    return Consumer(
      builder: (context, ref, child) {
        final leaderboard = ref.watch(leaderboardProvider(type));
        
        return leaderboard.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
          data: (users) => ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return _buildLeaderboardCard(user, index + 1);
            },
          ),
        );
      },
    );
  }

  Widget _buildLeaderboardCard(LeaderboardUser user, int rank) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: _buildRankWidget(rank),
        title: Text(user.displayName),
        subtitle: Text('${user.accuracy.toStringAsFixed(1)}% accuracy'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${user.score}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              user.trend > 0 ? '↗️ +${user.trend}' : user.trend < 0 ? '↘️ ${user.trend}' : '→ 0',
              style: TextStyle(
                color: user.trend > 0 ? Colors.green : user.trend < 0 ? Colors.red : Colors.grey,
              ),
            ),
          ],
        ),
        tileColor: user.isCurrentUser ? Colors.blue[50] : null,
      ),
    );
  }

  Widget _buildRankWidget(int rank) {
    if (rank <= 3) {
      final colors = [Colors.amber, Colors.grey, Colors.brown];
      final icons = [Icons.emoji_events, Icons.emoji_events, Icons.emoji_events];
      
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colors[rank - 1],
          shape: BoxShape.circle,
        ),
        child: Icon(
          icons[rank - 1],
          color: Colors.white,
        ),
      );
    }
    
    return CircleAvatar(
      backgroundColor: Colors.grey[300],
      child: Text(
        '$rank',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
```

---

### Subscription Management & Monetization

#### Flutter Upgrade Implementation
```dart
// lib/features/subscription/widgets/upgrade_dialog.dart
class UpgradeDialog extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star,
              size: 64,
              color: Colors.amber,
            ),
            SizedBox(height: 16),
            Text(
              'Unlock Your Potential',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            _buildFeatureComparison(),
            SizedBox(height: 24),
            _buildPricingOptions(),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Maybe Later'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _startUpgradeFlow(ref),
                    child: Text('Upgrade Now'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureComparison() {
    return Table(
      children: [
        TableRow(children: [
          Text('Feature', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Anonymous', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Premium', style: TextStyle(fontWeight: FontWeight.bold)),
        ]),
        TableRow(children: [
          Text('Daily Questions'),
          Text('20'),
          Text('Unlimited'),
        ]),
        TableRow(children: [
          Text('AI Explanations'),
          Text('2'),
          Text('Unlimited'),
        ]),
        TableRow(children: [
          Text('Cross-Device Sync'),
          Text('❌'),
          Text('✅'),
        ]),
        TableRow(children: [
          Text('Analytics'),
          Text('Basic'),
          Text('Advanced'),
        ]),
      ],
    );
  }

  Widget _buildPricingOptions() {
    return Row(
      children: [
        Expanded(
          child: _buildPricingCard(
            'Monthly',
            'PKR 2,000',
            '/month',
            false,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildPricingCard(
            'Yearly',
            'PKR 20,000',
            '/year',
            true,
            savings: '2 months free!',
          ),
        ),
      ],
    );
  }

  Widget _buildPricingCard(
    String title,
    String price,
    String period,
    bool isRecommended, {
    String? savings,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: isRecommended ? Colors.blue : Colors.grey,
          width: isRecommended ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
        color: isRecommended ? Colors.blue[50] : null,
      ),
      child: Column(
        children: [
          if (isRecommended) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'RECOMMENDED',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
          ],
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          Text(period),
          if (savings != null) ...[
            SizedBox(height: 4),
            Text(
              savings,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _startUpgradeFlow(WidgetRef ref) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaddlePaymentScreen(),
      ),
    );
  }
}
```

This completes the comprehensive Flutter feature stories with complete implementation examples for all major features, including anonymous user handling, device management, practice mode, analytics, social features, and subscription management.