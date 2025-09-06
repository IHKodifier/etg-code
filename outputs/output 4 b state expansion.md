# EntryTestGuru - UI States Brief

## Authentication & User Management

### Welcome Screen
#### Welcome Screen State 1 - Initial Landing
* **Background**: Clean gradient using `LinearGradient` from `AppColors.lightBgPrimary` to `AppColors.lightBgSecondary` (light theme) or `AppColors.darkBgPrimary` to `AppColors.darkBgSecondary` (dark theme)
* **Header**: App logo "EntryTestGuru" centered with `AppTextStyles.displayLarge` in `AppColors.primary700`
* **Theme Switcher**: `Positioned` widget top-right corner with `FloatingActionButton` using `Theme.of(context).colorScheme.surface` background, immediately functional but SharedPreferences persistence only available post-signup
* **Hero Section**: `Center` widget with `SvgPicture` or `Image.asset` showing exam preparation graphics with `Container` background using `AppColors.primary100`
* **Primary CTA**: `AppButton` widget with `ButtonType.primary` and `UserTier.anonymous`, full-width with `EdgeInsets.all(AppDimensions.space6)`
* **Secondary CTAs**: `Row` of social login buttons using `OutlinedButton` with `AppColors.freePrimary` border
* **Tertiary Option**: `TextButton` with "Sign in with Email" using `AppTextStyles.labelLarge` and `AppColors.primary500`
* **Footer**: `Text` widget with `AppTextStyles.bodySmall` and `AppColors.lightTextMuted`
* **Animations**: `AnimatedList` with `SlideTransition` and `FadeTransition`, `TweenAnimationBuilder` for hero illustration floating effect using `Transform.translate`

#### Welcome Screen State 2 - Loading Authentication
* **Overlay**: `Stack` with semi-transparent `Container` using `Theme.of(context).colorScheme.surface` with 0.8 opacity and `BackdropFilter` blur
* **Loading Indicator**: `Center` with `CircularProgressIndicator` in `AppColors.primary700` and `Text` below using `AppTextStyles.bodyMedium`
* **Background Elements**: Dimmed welcome screen content using `Opacity` widget with 0.6 value
* **Animations**: `RotationTransition` for circular progress with `AnimationController` using `vsync: this`

### Onboarding Flow
#### Onboarding State 1 - Exam Category Selection
* **AppBar**: Custom `AppBar` with "Choose Your Target Exam" using `AppTextStyles.headlineLarge` and `IconButton` back arrow
* **Progress Indicator**: `LinearProgressIndicator` showing "1 of 2" with value 0.5, styled with `AppColors.primary500`
* **Category Cards**: `GridView.builder` with 2 columns mobile (using `ResponsiveUtils.isMobile(context)`), 3 columns tablet
  * Each card is `AppCard` widget with `GestureDetector` for selection
  * Selected state uses `AnimatedContainer` with `AppColors.primary100` background and `AppColors.primary700` border
  * `ArdeBadge` widget showing "10,000+ Questions" with `ArdeProbability.medium`
* **Card Content**: `Column` with exam name using `AppTextStyles.headlineSmall`, description with `AppTextStyles.bodyMedium`, question count with `AppTextStyles.labelMedium`
* **Continue Button**: `Positioned` at bottom with `SafeArea`, `AppButton` enabled/disabled based on selection state
* **Animations**: Card selection using `AnimatedScale` (1.0 → 1.02) with `Curves.easeInOut` and `AnimatedContainer` for border color transition

#### Onboarding State 2 - Feature Preview (Anonymous Users)
* **AppBar**: Custom header with selected exam category using `Chip` widget
* **Feature List**: `ListView` with feature cards using `AppCard` widgets
  * Each card has `ListTile` with `AcademicIcon` and feature description
  * "Device-only limits" warning using `Container` with `AppColors.warning` background and `AppTextStyles.labelSmall`
* **Limitation Badge**: `Banner` widget or `Material` banner with `AppColors.warning` color and warning icon
* **Upgrade Preview**: `AppCard` with elevated styling and `AppColors.freePrimary` accent border
* **Action Buttons**: `ButtonBar` with primary "Start Practicing" `AppButton` and secondary "Sign Up Instead" `TextButton`
* **Animations**: `AnimatedList` with staggered `SlideTransition` using `Interval` curves, `TweenAnimationBuilder` for upgrade card pulse effect

### Device Management (Registered Users)
#### Device Management State 1 - Device Registry Overview
* **AppBar**: Custom `AppBar` with "Connected Devices" title and device count badge using `Chip`
* **Device Cards**: `ListView.builder` with `AppCard` widgets containing:
  * `ListTile` with device `Icon` (Icons.phone_iphone, Icons.laptop_mac) and custom name using `TextField` for editing
  * Platform details using `AppTextStyles.bodySmall` with `AppColors.lightTextSecondary`
  * Browser sessions as `ExpansionTile` showing individual sessions with `Chip` widgets
  * Status using `Row` with `Container` circle (green/gray) and timestamp text
  * `PopupMenuButton` with three dots and "Remove Device" option
* **Empty Slots**: For users with less than 3 devices, show remaining slots as grayed-out placeholder cards with "Available Device Slot" text
* **Real-time Updates**: `StreamBuilder` or Riverpod listeners with `AnimatedSwitcher` for status changes
* **Security Alert**: `MaterialBanner` with yellow background when new device detected, using `Actions` for buttons

#### Device Management State 2 - Device Limit Reached
* **Modal**: `showModalBottomSheet` or `showDialog` with full-screen `Container` using `AppColors.darkBgPrimary` background
* **Header**: "Account Limit Reached" with warning icon using `AppTextStyles.headlineLarge` and `AppColors.error`
* **Message**: "You can connect up to 3 devices. Remove one to continue." using `AppTextStyles.bodyLarge`
* **Device Selection**: `ListView` of current devices with radio buttons (`Radio<String>`) for selection to remove
* **Remove Button**: `AppButton` with `ButtonType.primary` in destructive color variant, disabled until device selected
* **Cancel Option**: `TextButton` with "Cancel" text in `AppColors.primary500`
* **Animations**: Modal slides up using `SlideTransition` from bottom, device list with `AnimatedList` for smooth removal

## Question Bank & Content Management

### Content Discovery & Filtering
#### Filter Interface State 1 - Default View
* **AppBar**: Custom with "Practice Mode" title and filter icon button showing active filter count badge
* **Filter Chips**: `Wrap` widget with current applied filters as dismissible `Chip` widgets using `AppColors.primary100` background
* **Quick Filters**: `SingleChildScrollView` horizontal with preset filter buttons like "High ARDE", "My Weak Areas"
* **Question Preview**: `Container` with border showing "847 questions available, ~45 min estimated" using `AppTextStyles.bodyMedium`
* **Start Button**: `AppButton` with "Start Practice Session" text, full-width and prominent
* **Animations**: Filter chips animate in with `SlideTransition`, question count updates with `TweenAnimationBuilder`

#### Filter Interface State 2 - Expanded Filters
* **Modal Sheet**: `showModalBottomSheet` with `DraggableScrollableSheet` for full filter interface
* **Filter Categories**: `ExpansionTile` widgets for each category (Subject, Difficulty, ARDE Probability, Performance)
* **Subject Hierarchy**: Nested `ExpansionTile` structure with `Checkbox` widgets for multi-selection
* **Difficulty Slider**: `Slider` widget with custom thumb using star icons, 1-5 range with `AppColors.primary500`
* **ARDE Badges**: `ToggleButtons` widget with `ArdeBadge` components for High/Medium/Low selection
* **Real-time Preview**: Floating `Container` at bottom with live question count using `StreamBuilder` or `ValueNotifier`
* **Apply Button**: Fixed bottom `AppButton` with apply text and question count
* **Animations**: Expansion tiles with `AnimatedContainer`, slider thumb with `ScaleTransition` on interaction

### Practice Mode Interface
#### Practice Mode State 1 - Question Display
* **AppBar**: Minimal with progress indicator "Question 5 of 20" using `LinearProgressIndicator` and timer display
* **Question Card**: `AppCard` containing:
  * Header `Row` with question number and `ArdeBadge` widget showing probability
  * Question text using `AppTextStyles.questionText` with math rendering support via `flutter_math_fork` if needed
  * Image support using `CachedNetworkImage` for question diagrams
* **MCQ Options**: `Column` of `GestureDetector` wrapped containers
  * Each option as `Container` with `AnimatedContainer` for selection state
  * Option circle with letter (A, B, C, D) using custom `Container` with circular decoration
  * Selected state: `AppColors.primary700` background with white text
  * Unselected state: transparent with border using `AppColors.lightTextTertiary`
* **Usage Indicator**: Top banner showing "18/20 questions remaining today" with progress bar
* **Submit Button**: Bottom `AppButton` disabled until option selected, with "Submit Answer" text
* **Animations**: Option selection with `AnimatedScale` and `AnimatedContainer` color transitions

#### Practice Mode State 2 - Answer Feedback
* **Feedback Overlay**: `AnimatedContainer` overlay on selected option showing correct/incorrect state
  * Correct: Green background with checkmark icon using `Icons.check_circle`
  * Incorrect: Red background with X icon using `Icons.cancel`
* **Correct Answer Highlight**: If user wrong, correct option highlighted with green `AnimatedContainer`
* **Explanation Card**: `AnimatedSize` expanding card with:
  * Tabbed interface using `TabBar` with "Explanation" and "AI Tutor" tabs
  * Text explanation with `AppTextStyles.bodyMedium` and diagram support
  * "Ask AI" button using `AppButton` with robot icon, showing remaining explanations count
* **Next Button**: `AppButton` with "Next Question" text and arrow icon
* **Animations**: Feedback appears with `ScaleTransition`, explanation card slides down with `SlideTransition`

#### Practice Mode State 3 - AI Tutoring Chat
* **Chat Interface**: Full-screen `Column` with:
  * Header showing question context and "AI Tutor" title using `AppTextStyles.headlineSmall`
  * Chat messages using `ListView.builder` with message bubbles
  * User messages: Right-aligned `Container` with `AppColors.primary700` background
  * AI messages: Left-aligned `Container` with `AppColors.lightBgTertiary` background
* **Input Field**: Bottom `TextField` with send button using `IconButton` and microphone icon
* **Usage Counter**: Persistent header showing "3/4 explanations remaining today" with `LinearProgressIndicator`
* **Context Badge**: Small chip showing which question this chat relates to
* **Animations**: Messages appear with `SlideTransition` from bottom, typing indicator with animated dots

## Sprint Exams & Simulated Real Exams

### Exam Configuration
#### Sprint Configuration State 1 - Parameter Selection
* **AppBar**: "Create Sprint Exam" with help icon linking to exam format info
* **Configuration Cards**: Multiple `AppCard` widgets with:
  * Question Count: `Slider` widget with range 5-50, showing selected value prominently
  * Time Limit: Custom time picker using `showTimePicker` or time slider
  * Subject Distribution: `PieChart` widget from `fl_chart` package showing selected subjects
  * Difficulty Mix: Horizontal `ToggleButtons` for Easy/Medium/Hard distribution
  * ARDE Priority: `SegmentedButton` for High/Mixed/Low ARDE focus
* **Real-time Preview**: Bottom card showing "25 questions, 45 minutes, Physics-heavy" summary
* **Advanced Options**: `ExpansionTile` with additional settings like question type preferences
* **Create Button**: `AppButton` with "Create Sprint" text and timer icon
* **Animations**: Configuration changes trigger `TweenAnimationBuilder` updates to preview card

#### SRE Configuration State 1 - Exam Selection
* **Header**: "Simulated Real Exams" with official exam badges
* **Exam Cards**: `PageView` or `CarouselSlider` showing available real exam replicas:
  * Each card shows exam name, duration, question count, and difficulty
  * Official logos and "Exact Replica" badges using `ArdeBadge` styling
  * Previous attempt scores if available using mini bar charts
* **Exam Details**: Expanded card showing:
  * Marking scheme with negative marking info
  * Break timings and section-wise breakdown
  * Recommended preparation level
* **Start Button**: Prominent `AppButton` with "Begin Exam" text and warning about no pausing
* **Animations**: Card carousel with smooth `PageController` transitions

### Exam Environment
#### Exam Mode State 1 - Active Exam
* **Immersive UI**: `SystemChrome.setEnabledSystemUIMode` to hide system UI elements
* **Header Bar**: Minimal with large timer display using `AppTextStyles.displayMedium` in countdown colors
  * Green timer for >30% time remaining
  * Yellow timer for 10-30% time remaining  
  * Red timer for <10% time remaining with subtle pulse animation
* **Question Navigation**: Bottom `BottomNavigationBar` or custom navigation with:
  * Question numbers as `GridView` of circular buttons
  * Attempted (green), current (blue), unattempted (gray) color coding
  * Bookmarked questions with star overlay icon
* **Question Display**: Clean `Container` with question text and MCQ options, minimal decoration
* **Connection Status**: Top banner if connection issues detected using `Connectivity` package
* **Submit Warning**: Modal dialog before final submission with attempt summary
* **Animations**: Timer color transitions with `TweenAnimationBuilder`, question changes with `PageTransition`

#### Exam Mode State 2 - Results & Analytics
* **Results Header**: Celebration animation with confetti using `confetti` package if good score
* **Score Card**: Large `Container` with:
  * Overall score as percentage with `CircularPercentIndicator`
  * Rank/percentile information with appropriate styling
  * Time taken vs allocated time comparison
* **Performance Breakdown**: `ExpansionTile` sections for:
  * Subject-wise performance using `BarChart` from `fl_chart`
  * Difficulty-wise accuracy with visual indicators
  * ARDE probability performance correlation
  * Time per question analysis with scatter plot
* **Detailed Review**: `ListView` of questions with performance indicators
* **Action Buttons**: `ButtonBar` with "Review Answers", "Retake Exam", "Share Results" options
* **Animations**: Score reveal with `AnimatedCounter`, charts animate in with staggered transitions

## Analytics & Performance Tracking

### Analytics Dashboard
#### Analytics State 1 - Overview Dashboard
* **AppBar**: "Performance Analytics" with date range selector and export icon
* **Key Metrics Cards**: `GridView` of metric cards using `AppCard`:
  * Overall accuracy percentage with `CircularPercentIndicator`
  * Questions attempted today/week with progress bar
  * Study streak with fire icon and counter
  * ARDE performance score with trend arrow
* **Performance Chart**: Large `LineChart` from `fl_chart` showing accuracy over time
  * Toggle buttons for time ranges (7D, 1M, 3M, ALL)
  * Dual axis showing accuracy and speed trends
* **Subject Breakdown**: Horizontal `BarChart` with subject names and accuracy percentages
* **Quick Insights**: `ListView` of insight cards with AI-generated recommendations
* **Animations**: Charts animate in with `AnimatedContainer`, metric cards pulse on data updates

#### Analytics State 2 - Subject Deep Dive
* **Subject Header**: Selected subject with icon and overall performance score
* **Topic Performance**: `TreeMap` or nested progress bars showing topic mastery levels
* **Difficulty Analysis**: `RadarChart` showing performance across difficulty levels
* **Question Type Breakdown**: `PieChart` with question format performance (MCQ, Calculation, etc.)
* **Time Analysis**: `ScatterPlot` showing time vs accuracy correlation
* **Improvement Suggestions**: `ExpansionTile` with specific recommendations for weak areas
* **Practice Recommendations**: Action cards suggesting specific question sets to practice
* **Animations**: Chart transitions with `Hero` widgets, data updates with `TweenAnimationBuilder`

## Social Features & Community

### Leaderboards
#### Leaderboards State 1 - Main Rankings
* **AppBar**: "Leaderboards" with filter options and opt-out settings icon
* **Filter Tabs**: `TabBar` with categories (Global, Friends, Study Group, Weekly, Monthly)
* **User Position**: Highlighted card showing current user's rank with `AnimatedContainer`
* **Rankings List**: `ListView.builder` with rank cards:
  * Position number with medal icons for top 3
  * User avatar using `CircleAvatar` with placeholder images
  * Username and score with progress indicators
  * Achievement badges for streaks, perfect scores, etc.
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
* **Action Buttons**: Primary "Upgrade Now" `AppButton` and secondary "Tomorrow" option
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