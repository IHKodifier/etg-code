import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_card.dart';
import '../../data/models/practice_session.dart';
import '../providers/practice_session_provider.dart';
import '../widgets/practice_session_widget.dart';

class PracticeSessionCreateScreen extends ConsumerStatefulWidget {
  const PracticeSessionCreateScreen({super.key});

  @override
  ConsumerState<PracticeSessionCreateScreen> createState() =>
      _PracticeSessionCreateScreenState();
}

class _PracticeSessionCreateScreenState
    extends ConsumerState<PracticeSessionCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form state
  String _selectedExamType = 'ECAT';
  String? _selectedSubject;
  String? _selectedTopic;
  String? _selectedDifficulty;
  String? _selectedArdeProbability;
  int _questionCount = 10;

  // Available options
  final List<String> _examTypes = [
    'ECAT',
    'MCAT',
    'CCAT',
    'GMAT',
    'GRE',
    'SAT',
  ];
  final List<String> _subjects = [
    'Mathematics',
    'Physics',
    'Chemistry',
    'Biology',
    'English',
    'Intelligence',
    'Medical Sciences',
  ];
  final List<String> _difficulties = ['easy', 'medium', 'hard'];
  final List<String> _ardeProbabilities = ['low', 'medium', 'high'];

  @override
  Widget build(BuildContext context) {
    final creationState = ref.watch(practiceSessionCreationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const SelectableText('Create Practice Session'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.space4),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const SelectableText(
                  'Customize Your Practice Session',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppDimensions.space2),
                SelectableText(
                  'Choose your preferences to create a personalized practice experience.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppDimensions.space8),

                // Exam Type Selection
                _buildSectionHeader('Exam Type'),
                AppCard(
                  child: DropdownButtonFormField<String>(
                    value: _selectedExamType,
                    decoration: const InputDecoration(
                      labelText: 'Select Exam Type',
                      border: OutlineInputBorder(),
                    ),
                    items: _examTypes.map((examType) {
                      return DropdownMenuItem(
                        value: examType,
                        child: SelectableText(examType),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => _selectedExamType = value!);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an exam type';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: AppDimensions.space6),

                // Filters Section
                _buildSectionHeader('Filters (Optional)'),
                AppCard(
                  child: Column(
                    children: [
                      // Subject Filter
                      DropdownButtonFormField<String?>(
                        value: _selectedSubject,
                        decoration: const InputDecoration(
                          labelText: 'Subject (Optional)',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            child: SelectableText('All Subjects'),
                          ),
                          ..._subjects.map((subject) {
                            return DropdownMenuItem(
                              value: subject,
                              child: SelectableText(subject),
                            );
                          }),
                        ],
                        onChanged: (value) {
                          setState(() => _selectedSubject = value);
                        },
                      ),

                      const SizedBox(height: AppDimensions.space4),

                      // Topic Filter (would be populated based on subject)
                      DropdownButtonFormField<String?>(
                        value: _selectedTopic,
                        decoration: const InputDecoration(
                          labelText: 'Topic (Optional)',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: null,
                            child: SelectableText('All Topics'),
                          ),
                          // TODO: Populate based on selected subject
                        ],
                        onChanged: (value) {
                          setState(() => _selectedTopic = value);
                        },
                      ),

                      const SizedBox(height: AppDimensions.space4),

                      // Difficulty Filter
                      DropdownButtonFormField<String?>(
                        value: _selectedDifficulty,
                        decoration: const InputDecoration(
                          labelText: 'Difficulty (Optional)',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            child: SelectableText('All Difficulties'),
                          ),
                          ..._difficulties.map((difficulty) {
                            return DropdownMenuItem(
                              value: difficulty,
                              child: SelectableText(
                                difficulty[0].toUpperCase() +
                                    difficulty.substring(1),
                              ),
                            );
                          }),
                        ],
                        onChanged: (value) {
                          setState(() => _selectedDifficulty = value);
                        },
                      ),

                      const SizedBox(height: AppDimensions.space4),

                      // ARDE Probability Filter
                      DropdownButtonFormField<String?>(
                        value: _selectedArdeProbability,
                        decoration: const InputDecoration(
                          labelText: 'ARDE Probability (Optional)',
                          border: OutlineInputBorder(),
                          helperText:
                              'Focus on questions likely to appear in exams',
                        ),
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            child: SelectableText('All Questions'),
                          ),
                          ..._ardeProbabilities.map((probability) {
                            return DropdownMenuItem(
                              value: probability,
                              child: SelectableText(
                                '${probability[0].toUpperCase() + probability.substring(1)} Probability',
                              ),
                            );
                          }),
                        ],
                        onChanged: (value) {
                          setState(() => _selectedArdeProbability = value);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimensions.space6),

                // Question Count
                _buildSectionHeader('Number of Questions'),
                AppCard(
                  child: Column(
                    children: [
                      SelectableText(
                        '$_questionCount Questions',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Slider(
                        value: _questionCount.toDouble(),
                        min: 5,
                        max: 50,
                        divisions: 9,
                        label: _questionCount.toString(),
                        onChanged: (value) {
                          setState(() => _questionCount = value.toInt());
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SelectableText(
                            '5',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SelectableText(
                            '50',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimensions.space8),

                // Session Preview
                _buildSectionHeader('Session Preview'),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        'Your Practice Session',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppDimensions.space3),
                      _buildPreviewItem('Exam Type', _selectedExamType),
                      if (_selectedSubject != null)
                        _buildPreviewItem('Subject', _selectedSubject!),
                      if (_selectedTopic != null)
                        _buildPreviewItem('Topic', _selectedTopic!),
                      if (_selectedDifficulty != null)
                        _buildPreviewItem('Difficulty', _selectedDifficulty!),
                      if (_selectedArdeProbability != null)
                        _buildPreviewItem(
                          'ARDE Focus',
                          _selectedArdeProbability!,
                        ),
                      _buildPreviewItem('Questions', _questionCount.toString()),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimensions.space8),

                // Create Button
                SizedBox(
                  width: double.infinity,
                  child: creationState.when(
                    data: (sessionId) {
                      if (sessionId != null) {
                        // Session created successfully, navigate to practice
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PracticeSessionWidget(sessionId: sessionId),
                            ),
                          );
                        });
                      }
                      return AppButton(
                        text: 'Create Practice Session',
                        onPressed: _createSession,
                        isLoading: false,
                      );
                    },
                    loading: () => const AppButton(
                      text: 'Creating Session...',
                      onPressed: null,
                      isLoading: true,
                    ),
                    error: (error, stack) => Column(
                      children: [
                        SelectableText.rich(
                          TextSpan(
                            text: 'Error: $error',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppDimensions.space2),
                        AppButton(
                          text: 'Try Again',
                          onPressed: _createSession,
                          isLoading: false,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppDimensions.space4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.space3),
      child: SelectableText(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildPreviewItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.space1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SelectableText(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          SelectableText(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _createSession() {
    if (!_formKey.currentState!.validate()) return;

    final filterCriteria = PracticeSessionFilter(
      examType: _selectedExamType,
      subject: _selectedSubject,
      topic: _selectedTopic,
      difficulty: _selectedDifficulty,
      ardeProbability: _selectedArdeProbability,
      questionCount: _questionCount,
    );

    final settings = PracticeSessionSettings(
      showExplanations: true,
      randomizeOrder: true,
      allowSkipping: true,
    );

    ref
        .read(practiceSessionCreationProvider.notifier)
        .createSession(filterCriteria: filterCriteria, settings: settings);
  }
}
