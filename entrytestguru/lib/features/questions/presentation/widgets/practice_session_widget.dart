import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/practice_session_provider.dart';
import '../../data/services/question_api_service.dart';

/// Provider for current question in practice session
final currentQuestionProvider =
    FutureProvider.family<Map<String, dynamic>?, String>((
      ref,
      questionId,
    ) async {
      if (questionId.isEmpty) return null;

      final questionService = ref.watch(QuestionApiService.provider);
      try {
        final question = await questionService.getQuestion(questionId);
        return question?.toJson();
      } catch (e) {
        return null;
      }
    });

class PracticeSessionWidget extends ConsumerStatefulWidget {
  final String sessionId;

  const PracticeSessionWidget({super.key, required this.sessionId});

  @override
  ConsumerState<PracticeSessionWidget> createState() =>
      _PracticeSessionWidgetState();
}

class _PracticeSessionWidgetState extends ConsumerState<PracticeSessionWidget> {
  DateTime? _questionStartTime;
  List<String> _selectedAnswers = [];
  bool _hasSubmittedAnswer = false;

  @override
  void initState() {
    super.initState();
    // Load session when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(currentPracticeSessionProvider.notifier)
          .loadSession(widget.sessionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sessionAsync = ref.watch(currentPracticeSessionProvider);
    final notifier = ref.read(currentPracticeSessionProvider.notifier);

    return sessionAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error: $error',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => notifier.loadSession(widget.sessionId),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (session) {
        if (session == null) {
          return const Scaffold(body: Center(child: Text('Session not found')));
        }

        // Get current question
        final currentQuestionAsync = session.currentQuestionId != null
            ? ref.watch(currentQuestionProvider(session.currentQuestionId!))
            : null;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Practice Session'),
            actions: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  '${session.progressPercentage?.round() ?? 0}%',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              // Progress bar
              LinearProgressIndicator(
                value: (session.progressPercentage ?? 0) / 100.0,
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              ),

              // Session info
              Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Row(
                  children: [
                    Text(
                      'Question ${session.currentQuestionIndex + 1} of ${session.totalQuestions}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Spacer(),
                    Text(
                      '${session.answeredQuestions}/${session.totalQuestions} answered',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),

              // Question content
              Expanded(
                child:
                    currentQuestionAsync?.when(
                      data: (question) {
                        if (question == null) {
                          return const Center(
                            child: Text('Question not found'),
                          );
                        }

                        return SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Question text
                              _buildQuestionText(question),

                              const SizedBox(height: 24),

                              // Options
                              _buildOptions(question),

                              const SizedBox(height: 24),

                              // Submit button or result feedback
                              if (!_hasSubmittedAnswer)
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: ElevatedButton(
                                    onPressed: _selectedAnswers.isNotEmpty
                                        ? () => _submitAnswer(
                                            notifier,
                                            session,
                                            question['id'],
                                          )
                                        : null,
                                    child: const Text('Submit Answer'),
                                  ),
                                )
                              else
                                _buildResultFeedback(),

                              const SizedBox(height: 16),

                              // Next question button
                              if (_hasSubmittedAnswer)
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: ElevatedButton(
                                    onPressed: session.hasNextQuestion
                                        ? () => _nextQuestion(notifier)
                                        : () => _completeSession(notifier),
                                    child: Text(
                                      session.hasNextQuestion
                                          ? 'Next Question'
                                          : 'Complete Session',
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stack) =>
                          Center(child: Text('Error loading question: $error')),
                    ) ??
                    const Center(child: Text('No question available')),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuestionText(Map<String, dynamic> question) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question['question_text'] ?? 'Question text not available',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptions(Map<String, dynamic> question) {
    final options = question['options'] as List<dynamic>? ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select your answer:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        ...options.map((option) {
          final optionId = option['id'] as String;
          final isSelected = _selectedAnswers.contains(optionId);

          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            color: isSelected
                ? Theme.of(context).colorScheme.primaryContainer
                : null,
            child: InkWell(
              onTap: _hasSubmittedAnswer
                  ? null
                  : () {
                      setState(() {
                        if (_selectedAnswers.contains(optionId)) {
                          _selectedAnswers.remove(optionId);
                        } else {
                          _selectedAnswers.add(optionId);
                        }
                      });
                    },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outline,
                          width: 2,
                        ),
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              size: 16,
                              color: Theme.of(context).colorScheme.onPrimary,
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        option['text'] ?? 'Option text not available',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildResultFeedback() {
    // For now, just show a simple feedback
    // TODO: Get actual result from attempt recording
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.info, color: Colors.blue, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Answer submitted! Check your result after completing the session.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.blue.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitAnswer(
    CurrentPracticeSessionNotifier notifier,
    dynamic session,
    String questionId,
  ) async {
    if (_selectedAnswers.isEmpty) return;

    final timeSpent = _questionStartTime != null
        ? DateTime.now().difference(_questionStartTime!).inMilliseconds
        : 0;

    try {
      await notifier.recordAttempt(
        questionId: questionId,
        selectedAnswers: _selectedAnswers,
        timeSpent: timeSpent,
      );

      setState(() {
        _hasSubmittedAnswer = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Answer submitted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to submit answer: $e')));
    }
  }

  void _nextQuestion(CurrentPracticeSessionNotifier notifier) async {
    // Reset state for next question
    setState(() {
      _selectedAnswers = [];
      _hasSubmittedAnswer = false;
      _questionStartTime = DateTime.now();
    });

    // Reload session to get next question
    await notifier.loadSession(widget.sessionId);
  }

  void _completeSession(CurrentPracticeSessionNotifier notifier) async {
    try {
      await notifier.completeSession();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Session completed!')));
      // TODO: Navigate to results screen
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to complete session: $e')));
    }
  }
}
