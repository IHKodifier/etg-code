import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/question_api_service.dart';
import '../../data/models/question.dart';
import '../../data/models/question_filter.dart';
import '../../data/models/question_attempt.dart';
import '../states/present_question_state.dart';

/// Provider for the QuestionApiService
final questionApiServiceProvider = Provider<QuestionApiService>((ref) {
  // TODO: Get from dependency injection
  throw UnimplementedError('QuestionApiService provider not implemented');
});

/// StateNotifierProvider for managing present question state
final presentQuestionNotifierProvider =
    StateNotifierProvider<PresentQuestionNotifier, PresentQuestionState>((ref) {
      final apiService = ref.watch(questionApiServiceProvider);
      return PresentQuestionNotifier(apiService);
    });

/// StateNotifier for managing question presentation operations
class PresentQuestionNotifier extends StateNotifier<PresentQuestionState> {
  final QuestionApiService _apiService;

  PresentQuestionNotifier(this._apiService)
    : super(const PresentQuestionState());

  /// Load questions based on filter
  Future<void> loadQuestions(QuestionFilter filter) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      currentFilter: filter,
    );

    try {
      final questions = await _apiService.getFilteredQuestions(filter);
      state = state.copyWithQuestionsLoaded(questions);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load questions: ${e.toString()}',
      );
    }
  }

  /// Select/deselect an answer
  void selectAnswer(String answerId) {
    if (state.isAnswered) return;

    state = state.copyWithAnswerSelected(answerId);
  }

  /// Submit the current answer
  Future<void> submitAnswer() async {
    if (!state.canSubmitAnswer) return;

    final startTime = DateTime.now();
    final timeSpent = Duration(seconds: 30); // TODO: Track actual time

    state = state.copyWithAnswerSubmitted();

    try {
      final attempt = QuestionAttempt(
        questionId: state.currentQuestion!.id,
        sessionId: 'session_${DateTime.now().millisecondsSinceEpoch}',
        selectedAnswers: state.selectedAnswers,
        isCorrect: state.isCorrect,
        timeSpent: timeSpent,
        timestamp: startTime,
      );

      await _apiService.recordAttempt(attempt);

      state = state.copyWith(lastAttempt: attempt);
    } catch (e) {
      // Handle error but don't revert the answer submission
      state = state.copyWith(
        errorMessage: 'Failed to record attempt: ${e.toString()}',
      );
    }
  }

  /// Move to next question
  void nextQuestion() {
    state = state.copyWithNextQuestion();
  }

  /// Move to previous question
  void previousQuestion() {
    state = state.copyWithPreviousQuestion();
  }

  /// Toggle explanation visibility
  void toggleExplanation() {
    state = state.copyWith(showExplanation: !state.showExplanation);
  }

  /// Reset the current question state
  void resetCurrentQuestion() {
    state = state.copyWith(
      selectedAnswers: [],
      showExplanation: false,
      isAnswered: false,
      isCorrect: false,
      lastAttempt: null,
      errorMessage: null,
    );
  }

  /// Start a new session with different filter
  Future<void> startNewSession(QuestionFilter filter) async {
    await loadQuestions(filter);
  }

  /// Get question statistics
  Future<Map<String, dynamic>?> getQuestionStats() async {
    if (state.currentQuestion == null) return null;

    try {
      return await _apiService.getQuestionStats(state.currentQuestion!.id);
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Failed to load question stats: ${e.toString()}',
      );
      return null;
    }
  }

  /// Check if answer is correct
  bool isAnswerCorrect(String answerId) {
    return state.isAnswerCorrect(answerId);
  }

  /// Check if answer is selected
  bool isAnswerSelected(String answerId) {
    return state.isAnswerSelected(answerId);
  }

  /// Get progress percentage
  double get progress => state.progress;

  /// Get score text for current question
  String get scoreText => state.scoreText;

  /// Check if current question is multiple choice
  bool get isMultipleChoice => state.isMultipleChoice;

  /// Check if current question is single choice
  bool get isSingleChoice => state.isSingleChoice;

  /// Get selected answers count
  int get selectedAnswersCount => state.selectedAnswersCount;

  /// Get correct answers count
  int get correctAnswersCount => state.correctAnswersCount;

  /// Check if can submit answer
  bool get canSubmitAnswer => state.canSubmitAnswer;

  /// Check if has next question
  bool get hasNextQuestion => state.hasNextQuestion;

  /// Check if has previous question
  bool get hasPreviousQuestion => state.hasPreviousQuestion;

  /// Check if question is answered
  bool get isAnswered => state.isAnswered;

  /// Check if answer is correct
  bool get isCorrect => state.isCorrect;

  /// Check if explanation is shown
  bool get showExplanation => state.showExplanation;

  /// Get current question
  Question? get currentQuestion => state.currentQuestion;

  /// Get error message
  String? get errorMessage => state.errorMessage;

  /// Get loading state
  bool get isLoading => state.isLoading;
}
