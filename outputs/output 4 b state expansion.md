# EntryTestGuru - Flutter UI State Specifications

## Authentication & User Management

### Anonymous User Experience
#### Anonymous User State 1 - Welcome Screen
* **Scaffold**: Main layout with `AppBar` containing app logo and "Sign In" `TextButton`
* **Welcome Card**: `Container` with `AppColors.lightBgPrimary` background and rounded corners using `BorderRadius.circular(16)`
* **Hero Section**: `Column` with app icon, welcome text using `AppTextStyles.headlineLarge`, and subtitle using `AppTextStyles.bodyLarge`
* **CTA Buttons**: `ButtonBar` with primary "Continue as Guest" `ElevatedButton` and secondary "Sign Up" `OutlinedButton`
* **Feature Preview**: `ListView.builder` showing 3 benefit cards with icons and descriptions
* **Animations**: `AnimatedOpacity` for welcome text, `SlideTransition` for feature cards with staggered timing

#### Anonymous User State 2 - Usage Limit Display
* **Top Banner**: `Container` with `AppColors.warning.withOpacity(0.1)` background showing "Browser session limits active"
* **Progress Indicators**: `Row` of `CircularProgressIndicator` widgets showing MCQ usage (18/20) and explanation usage (1/2)
* **Usage Cards**: `Wrap` widget containing `Chip` elements for each limit with progress percentages
* **Upgrade Prompt**: Subtle `Card` with "Unlock unlimited access + sync" message and `AppColors.freePrimary` accent
* **Countdown Timer**: `Text` widget showing "Resets in: 14h 23m" using `AppTextStyles.bodySmall` with `AppColors.warning` color and warning icon
* **Upgrade Preview**: `Card` with elevated styling and `AppColors.freePrimary` accent border
* **Action Buttons**: `ButtonBar` with primary "Start Practicing" `ElevatedButton` and secondary "Sign Up Instead" `TextButton`
* **Animations**: `AnimatedList` with staggered `SlideTransition` using `Interval` curves, `TweenAnimationBuilder` for upgrade card pulse effect

### Device Management (Registered Users)
#### Device Management State 1 - Device Registry Overview
* **AppBar**: Custom `AppBar` with "Connected Devices" title and device count badge using `Chip`
* **Device Cards**: `ListView.builder` with `Card` widgets containing:
  * `ListTile` with device `Icon` (Icons.phone_iphone, Icons.laptop_mac) and custom name using `TextField` for editing
  * Platform details using `TextStyle` with `AppColors.onSurface.withOpacity(0.7)`
  * Browser sessions as `ExpansionTile` showing individual sessions with `Chip` widgets
  * Status using `Row` with `Container` circle (green/gray) and timestamp text
  * `PopupMenuButton` with three dots and "Remove Device" option
* **Empty Slots**: For users with less than 3 devices, show remaining slots as grayed-out placeholder cards with "Available Device Slot" text
* **Real-time Updates**: `StreamBuilder` or Riverpod listeners with `AnimatedSwitcher` for status changes
* **Security Alert**: `MaterialBanner` with yellow background when new device detected, using `Actions` for buttons

#### Device Management State 2 - Device Limit Reached
* **Modal**: `showModalBottomSheet` or `showDialog` with full-screen `Container` using dark background
* **Header**: "Account Limit Reached" with warning icon using large text style and error color
* **Message**: "You can connect up to 3 devices. Remove one to continue." using body text style
* **Device Selection**: `ListView` of current devices with radio buttons (`Radio<String>`) for selection to remove
* **Remove Button**: `ElevatedButton` with destructive color variant, disabled until device selected
* **Cancel Option**: `TextButton` with "Cancel" text in primary color
* **Animations**: Modal slides up using `SlideTransition` from bottom, device list with `AnimatedList` for smooth removal

## Question Bank & Content Management

### Content Discovery & Filtering
#### Filter Interface State 1 - Default View
* **AppBar**: Custom with "Practice Mode" title and filter icon button showing active filter count badge
* **Filter Chips**: `Wrap` widget with current applied filters as dismissible `Chip` widgets using primary container background
* **Quick Filters**: `SingleChildScrollView` horizontal with preset filter buttons like "High ARDE", "My Weak Areas"
* **Question Preview**: `Container` with border showing "847 questions available, ~45 min estimated" using body medium text
* **Start Button**: `ElevatedButton` with "Start Practice Session" text, full-width and prominent
* **Animations**: Filter chips animate in with `SlideTransition`, question count updates with `TweenAnimationBuilder`

#### Filter Interface State 2 - Expanded Filters
* **Modal Sheet**: `showModalBottomSheet` with `DraggableScrollableSheet` for full filter interface
* **Filter Categories**: `ExpansionTile` widgets for each category (Subject, Difficulty, ARDE Probability, Performance)
* **Subject Hierarchy**: Nested `ExpansionTile` structure with `Checkbox` widgets for multi-selection
* **Difficulty Slider**: `Slider` widget with custom thumb using star icons, 1-5 range with primary color
* **ARDE Badges**: `ToggleButtons` widget with badge components for High/Medium/Low selection
* **Real-time Preview**: Floating `Container` at bottom with live question count using `StreamBuilder` or `ValueNotifier`
* **Apply Button**: Fixed bottom `ElevatedButton` with apply text and question count
* **Animations**: Expansion tiles with `AnimatedContainer`, slider thumb with `ScaleTransition` on interaction

### Practice Mode Interface
#### Practice Mode State 1 - Question Display
* **AppBar**: Minimal with progress indicator "Question 5 of 20" using `LinearProgressIndicator` and timer display
* **Question Card**: `Card` containing:
  * Header `Row` with question number and ARDE badge widget showing probability
  * Question text using question text style with math rendering support via `flutter_math_fork` if needed
  * Image support using `CachedNetworkImage` for question diagrams
* **MCQ Options**: `Column` of `GestureDetector` wrapped containers
  * Each option as `Container` with `AnimatedContainer` for selection state
  * Option circle with letter (A, B, C, D) using custom `Container` with circular decoration
  * Selected state: Primary color background with white text
  * Unselected state: transparent with border using outline color
* **Usage Indicator**: Top banner showing "18/20 questions remaining today on this browser" with progress bar
* **Submit Button**: Bottom `ElevatedButton` disabled until option selected, with "Submit Answer" text
* **Animations**: Option selection with `AnimatedScale` and `AnimatedContainer` color transitions

#### Practice Mode State 2 - Answer Feedback
* **Feedback Overlay**: `AnimatedContainer` overlay on selected option showing correct/incorrect state
  * Correct: Green background with checkmark icon using `Icons.check_circle`
  * Incorrect: Red background with X icon using `Icons.cancel`
* **Correct Answer Highlight**: If user wrong, correct option highlighted with green `AnimatedContainer`
* **Explanation Card**: `AnimatedSize` expanding card with:
  * Tabbed interface using `TabBar` with "Explanation" and "AI Tutor" tabs
  * Text explanation with body medium text and diagram support
  * "Ask AI" button using `ElevatedButton` with robot icon, showing explanation count remaining
* **Next Button**: Bottom `ElevatedButton` to continue to next question
* **Animations**: Feedback overlay slides in with `SlideTransition`, explanation card expands with `AnimatedSize`

## Sprint Exams & Simulated Real Exams

### Exam Configuration Interface
#### Sprint Exam Setup State 1 - Configuration Screen
* **AppBar**: "Create Sprint Exam" title with help icon for configuration tips
* **Configuration Form**: `Form` widget with multiple sections:
  * Question count slider using `Slider` (5-50 range) with real-time preview
  * Time limit picker using `TimePicker` widget with suggested defaults
  * Subject selection using `ExpansionTile` with nested `Checkbox` widgets
  * Difficulty distribution using multiple `Slider` widgets for each level
  * ARDE probability weight using `Slider` (0-100%) with visual examples
* **Live Preview**: `Card` showing selected criteria with question count estimate and difficulty chart
* **Start Button**: Large `ElevatedButton` with "Start Sprint Exam" and estimated duration
* **Animations**: Configuration changes trigger `TweenAnimationBuilder` for count updates, preview card pulses when updated

#### Exam Interface State 1 - Active Exam Mode
* **Full Screen**: `Scaffold` with minimal UI, using `SystemChrome.setEnabledSystemUIMode` for immersion
* **Timer**: Prominent countdown display using large text with color changes (green → yellow → red)
* **Question Display**: Clean layout with question number, text, and options without distractions
* **Navigation**: Bottom row with "Previous", "Next", and "Submit" buttons using `ButtonBar`
* **Question Palette**: Slide-out drawer showing all questions with attempt status (attempted/unattempted/marked)
* **Submit Confirmation**: `AlertDialog` with exam summary and final confirmation
* **Animations**: Timer color transitions, question slides with `PageView` transitions

## Analytics & Performance Tracking

### Dashboard Interface
#### Analytics Dashboard State 1 - Overview
* **AppBar**: "Performance Analytics" with date range selector and export icon
* **Key Metrics Cards**: `GridView` of metric cards showing:
  * Overall accuracy percentage with circular progress indicator
  * Study streak counter with flame icon and current/best streak
  * Time spent studying with clock icon and weekly comparison
  * Questions attempted with trend arrow (up/down)
* **Performance Chart**: `Container` with line chart showing accuracy trends over time using `fl_chart` package
* **Subject Breakdown**: `ExpansionTile` widgets for each subject showing topic-level performance with progress bars
* **Recommendations**: `Card` with AI-generated study suggestions and action buttons
* **Animations**: Metrics cards animate in with staggered timing, charts draw with line animation

#### Analytics Dashboard State 2 - Detailed View
* **Filter Controls**: `Row` with `DropdownButton` widgets for time range, subject, and metric type
* **Interactive Charts**: Tappable chart elements using `fl_chart` with zoom and pan support
* **Data Tables**: `DataTable` widget showing detailed question-level performance
* **Comparison Mode**: Toggle to compare with peers or previous performance
* **Export Options**: `FloatingActionButton` with export menu for PDF/CSV generation
* **Animations**: Chart transitions when changing filters, table rows highlight on tap

## Social Features & Community

### Leaderboard Interface
#### Leaderboard State 1 - Rankings Display
* **AppBar**: "Leaderboards" with category selector and personal rank badge
* **Tab Bar**: `TabBar` with categories (Weekly, Monthly, All-time, Friends)
* **Ranking List**: `ListView.builder` with user cards showing:
  * Rank number with medal icons for top 3
  * User avatar (anonymized) with username
  * Score/accuracy with progress visualization
  * Rank change indicator (up/down arrows)
* **Personal Position**: Highlighted card showing current user position with surrounding ranks
* **Opt-out Option**: Bottom sheet with privacy controls and explanation
* **Animations**: List items slide in with staggered `SlideTransition`, rank changes with `AnimatedCounter`

#### Study Groups State 1 - Group Dashboard
* **Group Header**: Group name, member count, and group performance metrics
* **Member List**: `ListView` of member cards with:
  * Member avatar and name
  * Current streak and recent activity
  * Contribution percentage to group goals
  * Online status indicator
* **Group Challenges**: Active challenge cards with progress bars and time remaining
* **Collective Goals**: Progress indicators for group targets using `LinearProgressIndicator`
* **Chat Integration**: Quick access to group chat with unread message count
* **Animations**: Member status updates with `FadeTransition`, progress bars with smooth animations

## Subscription & Monetization

### Upgrade Prompts
#### Limit Reached State 1 - Graceful Blocking
* **Modal Overlay**: `showDialog` with custom dialog design
* **Progress Visual**: `CircularProgressIndicator` showing 100% completion (20/20 questions used)
* **Congratulations Message**: "Great job! You've completed today's practice session" with positive messaging
* **Upgrade Benefits**: `Column` of feature comparisons:
  * Anonymous vs Free vs Paid tiers in table format
  * Highlighted benefits like "Unlimited questions", "Cross-device sync"
  * Social features and advanced analytics previews
* **Action Buttons**: Primary "Upgrade Now" `ElevatedButton` and secondary "Tomorrow" option
* **Success Stories**: Testimonial card with user improvement statistics
* **Animations**: Modal slides up with `SlideTransition`, benefits list with staggered reveals

#### Payment Flow State 1 - Paddle Integration
* **Pricing Cards**: `PageView` of subscription options:
  * Monthly and yearly plans with savings badges
  * Feature comparison checklist
  * Regional pricing with currency auto-detection
* **Payment Methods**: Integration with Paddle widget showing available payment options
* **Security Indicators**: SSL badges and secure payment messaging
* **Terms Agreement**: `Checkbox` with terms and privacy policy links
* **Processing State**: Loading overlay during payment with security messaging
* **Animations**: Price card transitions, loading states with `CircularProgressIndicator`

## Flutter-Specific Implementation Examples

### Anonymous Usage Widget
```dart
class AnonymousUsageWidget extends ConsumerWidget {
  const AnonymousUsageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final usageLimits = authState.usageLimits;
    
    if (!authState.isAnonymous || usageLimits == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 12),
          _buildUsageIndicators(context, usageLimits),
          const SizedBox(height: 12),
          _buildUpgradeMessage(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.info_outline,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          'Browser Session Limits',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildUsageIndicators(BuildContext context, UsageLimits limits) {
    return Column(
      children: [
        _buildUsageRow(
          context,
          'Practice Questions',
          limits.currentMcqUsage,
          limits.dailyMcqLimit,
          Icons.quiz_outlined,
        ),
        const SizedBox(height: 8),
        _buildUsageRow(
          context,
          'AI Explanations',
          limits.currentExplanationUsage,
          limits.dailyExplanationLimit,
          Icons.psychology_outlined,
        ),
      ],
    );
  }

  Widget _buildUsageRow(
    BuildContext context,
    String label,
    int used,
    int total,
    IconData icon,
  ) {
    final progress = used / total;
    
    return Row(
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label),
                  Text('$used/$total'),
                ],
              ),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  progress < 0.8 ? Colors.blue : Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUpgradeMessage(BuildContext context) {
    return Text(
      'Usage resets daily for this browser session. Sign up for unlimited access + cross-device sync!',
      style: Theme.of(context).textTheme.bodySmall,
      textAlign: TextAlign.center,
    );
  }
}
```

### Device Management Widget (Registered Users)
```dart
class DeviceManagementWidget extends ConsumerWidget {
  const DeviceManagementWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(deviceProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connected Devices'),
        actions: [
          Chip(
            label: Text('${devices.length}/3'),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: devices.length + (3 - devices.length),
        itemBuilder: (context, index) {
          if (index < devices.length) {
            return _buildDeviceCard(context, devices[index], ref);
          } else {
            return _buildEmptySlotCard(context);
          }
        },
      ),
    );
  }

  Widget _buildDeviceCard(BuildContext context, Device device, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: Icon(_getDeviceIcon(device.platform)),
        title: Text(device.name),
        subtitle: Text('Last active: ${_formatLastActive(device.lastActive)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: device.isOnline ? Colors.green : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'remove',
                  child: Text('Remove Device'),
                ),
              ],
              onSelected: (value) {
                if (value == 'remove') {
                  _showRemoveDialog(context, device, ref);
                }
              },
            ),
          ],
        ),
        children: [
          ...device.browserSessions.map((session) => 
            ListTile(
              dense: true,
              leading: Icon(_getBrowserIcon(session.browser)),
              title: Text(session.browser),
              trailing: Text(session.lastActive),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySlotCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300]!,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.add, color: Colors.grey[400]),
            const SizedBox(width: 16),
            Text(
              'Available Device Slot',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getDeviceIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'ios':
        return Icons.phone_iphone;
      case 'android':
        return Icons.phone_android;
      case 'web':
        return Icons.laptop_mac;
      default:
        return Icons.device_unknown;
    }
  }

  IconData _getBrowserIcon(String browser) {
    switch (browser.toLowerCase()) {
      case 'chrome':
        return Icons.web;
      case 'firefox':
        return Icons.web;
      case 'safari':
        return Icons.web;
      default:
        return Icons.web;
    }
  }

  String _formatLastActive(DateTime lastActive) {
    final now = DateTime.now();
    final difference = now.difference(lastActive);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  void _showRemoveDialog(BuildContext context, Device device, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Device'),
        content: Text('Remove "${device.name}"? You will be logged out immediately on this device.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(deviceProvider.notifier).removeDevice(device.id);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}
```

### Practice Question Widget
```dart
class PracticeQuestionWidget extends ConsumerStatefulWidget {
  final Question question;
  final VoidCallback onAnswerSubmitted;

  const PracticeQuestionWidget({
    super.key,
    required this.question,
    required this.onAnswerSubmitted,
  });

  @override
  ConsumerState<PracticeQuestionWidget> createState() => _PracticeQuestionWidgetState();
}

class _PracticeQuestionWidgetState extends ConsumerState<PracticeQuestionWidget>
    with TickerProviderStateMixin {
  
  int? selectedOption;
  bool isAnswered = false;
  late AnimationController _feedbackController;
  late Animation<double> _feedbackAnimation;

  @override
  void initState() {
    super.initState();
    _feedbackController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _feedbackAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _feedbackController, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuestionHeader(),
            const SizedBox(height: 16),
            _buildQuestionText(),
            const SizedBox(height: 20),
            _buildOptions(),
            const SizedBox(height: 20),
            _buildSubmitButton(),
            if (isAnswered) ...[
              const SizedBox(height: 16),
              _buildExplanationSection(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Question ${widget.question.number}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getArdeBadgeColor(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _getArdeText(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Color _getArdeBadgeColor() {
    switch (widget.question.ardeProbability) {
      case ArdeProbability.high:
        return Colors.red;
      case ArdeProbability.medium:
        return Colors.orange;
      case ArdeProbability.low:
        return Colors.grey;
    }
  }

  String _getArdeText() {
    switch (widget.question.ardeProbability) {
      case ArdeProbability.high:
        return 'HIGH ARDE';
      case ArdeProbability.medium:
        return 'MED ARDE';
      case ArdeProbability.low:
        return 'LOW ARDE';
    }
  }

  Widget _buildQuestionText() {
    return Text(
      widget.question.text,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Widget _buildOptions() {
    return Column(
      children: widget.question.options.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;
        
        return GestureDetector(
          onTap: isAnswered ? null : () => _selectOption(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
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
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      color: _getOptionTextColor(index),
                    ),
                  ),
                ),
                if (isAnswered && index == widget.question.correctAnswer)
                  const Icon(Icons.check_circle, color: Colors.white),
                if (isAnswered && selectedOption == index && index != widget.question.correctAnswer)
                  const Icon(Icons.cancel, color: Colors.white),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _getOptionColor(int index) {
    if (!isAnswered) {
      return selectedOption == index 
          ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
          : Colors.transparent;
    }
    
    if (index == widget.question.correctAnswer) {
      return Colors.green;
    } else if (selectedOption == index) {
      return Colors.red;
    }
    return Colors.transparent;
  }

  Color _getOptionBorderColor(int index) {
    if (!isAnswered) {
      return selectedOption == index 
          ? Theme.of(context).colorScheme.primary
          : Colors.grey[300]!;
    }
    
    if (index == widget.question.correctAnswer) {
      return Colors.green;
    } else if (selectedOption == index) {
      return Colors.red;
    }
    return Colors.grey[300]!;
  }

  Color _getOptionCircleColor(int index) {
    if (!isAnswered) {
      return selectedOption == index 
          ? Theme.of(context).colorScheme.primary
          : Colors.grey[300]!;
    }
    
    if (index == widget.question.correctAnswer) {
      return Colors.white;
    } else if (selectedOption == index) {
      return Colors.white;
    }
    return Colors.grey[300]!;
  }

  Color _getOptionTextColor(int index) {
    if (!isAnswered) {
      return selectedOption == index ? Colors.black : Colors.black;
    }
    
    if (index == widget.question.correctAnswer || selectedOption == index) {
      return Colors.white;
    }
    return Colors.black;
  }

  void _selectOption(int index) {
    setState(() {
      selectedOption = index;
    });
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: selectedOption != null && !isAnswered ? _submitAnswer : null,
        child: Text(isAnswered ? 'Next Question' : 'Submit Answer'),
      ),
    );
  }

  void _submitAnswer() {
    setState(() {
      isAnswered = true;
    });
    _feedbackController.forward();
    
    // Track usage
    ref.read(usageProvider.notifier).trackMCQUsage();
    
    widget.onAnswerSubmitted();
  }

  Widget _buildExplanationSection() {
    return AnimatedBuilder(
      animation: _feedbackAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _feedbackAnimation.value,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explanation',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(widget.question.explanation),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: _canUseAI() ? _openAIChat : null,
                      icon: const Icon(Icons.psychology),
                      label: Text(_getAIButtonText()),
                    ),
                    const SizedBox(width: 8),
                    if (!_canUseAI())
                      Text(
                        'AI limit reached - upgrade for unlimited',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _canUseAI() {
    final usage = ref.read(usageProvider);
    return usage.canUseExplanation;
  }

  String _getAIButtonText() {
    final usage = ref.read(usageProvider);
    if (!usage.canUseExplanation) {
      return 'AI Limit Reached';
    }
    return 'Ask AI (${usage.explanationLimit - usage.explanationsUsed} left)';
  }

  void _openAIChat() {
    // Navigate to AI chat screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AIChatScreen(question: widget.question),
      ),
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
}
```

This completes all 5 updated documents with proper Flutter implementations, including:

1. **Flutter widgets** and UI components
2. **Riverpod state management** patterns
3. **Flutter-specific** animation and navigation
4. **Firebase Anonymous Auth** integration
5. **Device management** for registered users only
6. **Usage tracking** with proper Flutter state handling

All code examples are now Flutter/Dart specific with proper pub.dev packages and Flutter widget implementations.