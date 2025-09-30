import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/question.dart';
import '../../data/models/question_attempt.dart';
import '../../data/models/question_filter.dart';
import '../../data/models/question_enums.dart';
import '../../data/models/question_option.dart';

part 'present_question_state.freezed.dart';

@freezed
class PresentQuestionState with _$PresentQuestionState {
  const factory PresentQuestionState({
    Question? currentQuestion,
    @Default([]) List<String> selectedAnswers,
    @Default(false) bool showExplanation,
    @Default(false) bool isAnswered,
    @Default(false) bool isCorrect,
    QuestionAttempt? lastAttempt,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? errorMessage,
    QuestionFilter? currentFilter,
    @Default(0) int currentQuestionIndex,
    @Default([]) List<Question> questionQueue,
    @Default(true) bool hasMore,
    @Default(0) int totalCount,
  }) = _PresentQuestionState;

  const PresentQuestionState._();

  bool get hasSelectedAnswers => selectedAnswers.isNotEmpty;

  bool get canSubmitAnswer => hasSelectedAnswers && !isAnswered;

  bool get isMultipleChoice =>
      currentQuestion?.questionType == QuestionType.mcqMultiSelect;

  bool get isSingleChoice =>
      currentQuestion?.questionType == QuestionType.mcqSingleSelect;

  List<String> get correctAnswers => currentQuestion?.correctAnswer ?? [];

  bool get hasNextQuestion => currentQuestionIndex < questionQueue.length - 1;

  bool get hasPreviousQuestion => currentQuestionIndex > 0;

  Question? get nextQuestion =>
      hasNextQuestion ? questionQueue[currentQuestionIndex + 1] : null;

  Question? get previousQuestion =>
      hasPreviousQuestion ? questionQueue[currentQuestionIndex - 1] : null;

  double get progress => questionQueue.isEmpty
      ? 0.0
      : (currentQuestionIndex + 1) / questionQueue.length;

  bool isAnswerCorrect(String answerId) {
    return correctAnswers.contains(answerId);
  }

  bool isAnswerSelected(String answerId) {
    return selectedAnswers.contains(answerId);
  }

  int get selectedAnswersCount => selectedAnswers.length;

  int get correctAnswersCount => correctAnswers.length;

  String get scoreText {
    if (!isAnswered) return '';
    final correctCount = selectedAnswers.where(isAnswerCorrect).length;
    final totalSelected = selectedAnswers.length;
    return '$correctCount/$totalSelected correct';
  }

  PresentQuestionState copyWithAnswerSubmitted() {
    final isCorrect =
        selectedAnswers.every(isAnswerCorrect) &&
        selectedAnswers.length == correctAnswers.length;

    return copyWith(
      isAnswered: true,
      isCorrect: isCorrect,
      showExplanation: true,
    );
  }

  PresentQuestionState copyWithNextQuestion() {
    if (!hasNextQuestion) return this;

    return copyWith(
      currentQuestionIndex: currentQuestionIndex + 1,
      currentQuestion: nextQuestion,
      selectedAnswers: [],
      showExplanation: false,
      isAnswered: false,
      isCorrect: false,
      lastAttempt: null,
    );
  }

  PresentQuestionState copyWithPreviousQuestion() {
    if (!hasPreviousQuestion) return this;

    return copyWith(
      currentQuestionIndex: currentQuestionIndex - 1,
      currentQuestion: previousQuestion,
      selectedAnswers: [],
      showExplanation: false,
      isAnswered: false,
      isCorrect: false,
      lastAttempt: null,
    );
  }

  PresentQuestionState copyWithAnswerSelected(String answerId) {
    if (isAnswered) return this;

    final newSelectedAnswers = List<String>.from(selectedAnswers);

    if (isSingleChoice) {
      // Single choice: replace selection
      newSelectedAnswers.clear();
      newSelectedAnswers.add(answerId);
    } else {
      // Multiple choice: toggle selection
      if (newSelectedAnswers.contains(answerId)) {
        newSelectedAnswers.remove(answerId);
      } else {
        newSelectedAnswers.add(answerId);
      }
    }

    return copyWith(selectedAnswers: newSelectedAnswers);
  }

  PresentQuestionState copyWithQuestionsLoaded(
    List<Question> questions, {
    bool hasMore = true,
    int totalCount = 0,
  }) {
    if (questions.isEmpty) {
      return copyWith(
        questionQueue: [],
        currentQuestion: null,
        currentQuestionIndex: 0,
        isLoading: false,
        isLoadingMore: false,
        hasMore: hasMore,
        totalCount: totalCount,
      );
    }

    // Shuffle options for each question to maintain vigilance
    final shuffledQuestions = questions.map((question) {
      final shuffledOptions = List<QuestionOption>.from(question.options)
        ..shuffle(); // Randomize option order
      return question.copyWith(options: shuffledOptions);
    }).toList();

    return copyWith(
      questionQueue: shuffledQuestions,
      currentQuestion: shuffledQuestions.first,
      currentQuestionIndex: 0,
      selectedAnswers: [],
      showExplanation: false,
      isAnswered: false,
      isCorrect: false,
      lastAttempt: null,
      isLoading: false,
      isLoadingMore: false,
      errorMessage: null,
      hasMore: hasMore,
      totalCount: totalCount,
    );
  }
}
