import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/question_filter.dart';
import '../../data/models/question_enums.dart';
import '../states/present_question_state.dart';
import '../providers/present_question_provider.dart';

class PresentQuestionWidget extends ConsumerStatefulWidget {
  final QuestionFilter? initialFilter;

  const PresentQuestionWidget({super.key, this.initialFilter});

  @override
  ConsumerState<PresentQuestionWidget> createState() =>
      _PresentQuestionWidgetState();
}

class _PresentQuestionWidgetState extends ConsumerState<PresentQuestionWidget> {
  @override
  void initState() {
    super.initState();
    // Load questions when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final filter = widget.initialFilter ?? const QuestionFilter();
      ref.read(presentQuestionNotifierProvider.notifier).loadQuestions(filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(presentQuestionNotifierProvider);
    final notifier = ref.read(presentQuestionNotifierProvider.notifier);

    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.errorMessage!,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final filter = widget.initialFilter ?? const QuestionFilter();
                  notifier.loadQuestions(filter);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (state.currentQuestion == null) {
      return const Scaffold(
        body: Center(child: Text('No questions available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Questions'),
        actions: [
          // Progress indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '${(state.progress * 100).round()}%',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress bar
          LinearProgressIndicator(
            value: state.progress,
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          ),

          // Question content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question text
                  _buildQuestionText(state),

                  const SizedBox(height: 24),

                  // Options
                  _buildOptions(state, notifier),

                  const SizedBox(height: 24),

                  // Action buttons
                  _buildActionButtons(state, notifier),

                  const SizedBox(height: 24),

                  // Explanation (shown after answering)
                  if (state.showExplanation) _buildExplanation(state),

                  // Score feedback
                  if (state.isAnswered) _buildScoreFeedback(state),
                ],
              ),
            ),
          ),

          // Navigation buttons
          _buildNavigationButtons(state, notifier),
        ],
      ),
    );
  }

  Widget _buildQuestionText(PresentQuestionState state) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question type badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                state.isMultipleChoice ? 'Multiple Choice' : 'Single Choice',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Question text
            Text(
              state.currentQuestion!.questionText,
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 8),

            // Question metadata
            Row(
              children: [
                Text(
                  '${state.currentQuestion!.subject} • ${state.currentQuestion!.topic}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                Text(
                  state.currentQuestion!.difficultyDisplay,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _getDifficultyColor(
                      state.currentQuestion!.difficulty,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptions(
    PresentQuestionState state,
    PresentQuestionNotifier notifier,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select your answer${state.isMultipleChoice ? '(s)' : ''}:',
          style: Theme.of(context).textTheme.titleMedium,
        ),

        const SizedBox(height: 12),

        ...state.currentQuestion!.options.map((option) {
          final isSelected = state.isAnswerSelected(option.id);
          final isCorrect = state.isAnswerCorrect(option.id);
          final showCorrectness = state.isAnswered;

          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            color: showCorrectness
                ? (isCorrect
                      ? Colors.green.shade50
                      : (isSelected ? Colors.red.shade50 : null))
                : (isSelected
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null),
            child: InkWell(
              onTap: state.isAnswered
                  ? null
                  : () => notifier.selectAnswer(option.id),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Selection indicator
                    Container(
                      width: 32,
                      height: 32,
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
                              state.isMultipleChoice
                                  ? Icons.check
                                  : Icons.radio_button_checked,
                              size: 20,
                              color: Theme.of(context).colorScheme.onPrimary,
                            )
                          : null,
                    ),

                    const SizedBox(width: 12),

                    // Option label
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          option.id,
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Option text
                    Expanded(
                      child: Text(
                        option.displayText,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),

                    // Correctness indicator
                    if (showCorrectness)
                      Icon(
                        isCorrect
                            ? Icons.check_circle
                            : (isSelected ? Icons.cancel : Icons.circle),
                        color: isCorrect
                            ? Colors.green
                            : (isSelected ? Colors.red : Colors.grey),
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

  Widget _buildActionButtons(
    PresentQuestionState state,
    PresentQuestionNotifier notifier,
  ) {
    if (state.isAnswered) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => notifier.toggleExplanation(),
              icon: Icon(
                state.showExplanation ? Icons.visibility_off : Icons.visibility,
              ),
              label: Text(
                state.showExplanation ? 'Hide Explanation' : 'Show Explanation',
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => notifier.resetCurrentQuestion(),
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ),
        ],
      );
    } else {
      return SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: state.canSubmitAnswer
              ? () => notifier.submitAnswer()
              : null,
          child: const Text('Submit Answer'),
        ),
      );
    }
  }

  Widget _buildExplanation(PresentQuestionState state) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Explanation',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              state.currentQuestion!.explanationText,
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            if (state.currentQuestion!.explanationSteps != null &&
                state.currentQuestion!.explanationSteps!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Step by step:',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...state.currentQuestion!.explanationSteps!.map((step) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: Theme.of(context).textTheme.bodyMedium),
                      Expanded(
                        child: Text(
                          step,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildScoreFeedback(PresentQuestionState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: state.isCorrect ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: state.isCorrect ? Colors.green.shade200 : Colors.red.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(
            state.isCorrect ? Icons.check_circle : Icons.cancel,
            color: state.isCorrect ? Colors.green : Colors.red,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              state.isCorrect
                  ? 'Correct! Well done.'
                  : 'Incorrect. Review the explanation above.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: state.isCorrect
                    ? Colors.green.shade800
                    : Colors.red.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (state.scoreText.isNotEmpty)
            Text(
              state.scoreText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: state.isCorrect
                    ? Colors.green.shade800
                    : Colors.red.shade800,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(
    PresentQuestionState state,
    PresentQuestionNotifier notifier,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: state.hasPreviousQuestion
                  ? () => notifier.previousQuestion()
                  : null,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Previous'),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: ElevatedButton.icon(
              onPressed: state.hasNextQuestion
                  ? () => notifier.nextQuestion()
                  : null,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.veryEasy:
      case DifficultyLevel.easy:
        return Colors.green;
      case DifficultyLevel.medium:
        return Colors.orange;
      case DifficultyLevel.hard:
      case DifficultyLevel.veryHard:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
