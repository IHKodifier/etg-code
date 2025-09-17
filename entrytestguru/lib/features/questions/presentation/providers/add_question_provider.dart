import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/question_api_service.dart';
import '../../data/models/question_option.dart';
import '../../data/models/question_enums.dart';
import '../states/add_question_state.dart';

/// StateNotifierProvider for managing add question state
final addQuestionNotifierProvider =
    StateNotifierProvider<AddQuestionNotifier, AddQuestionState>((ref) {
      final apiService = ref.watch(QuestionApiService.provider);
      return AddQuestionNotifier(apiService);
    });

/// StateNotifier for managing add question operations
class AddQuestionNotifier extends StateNotifier<AddQuestionState> {
  final QuestionApiService _apiService;

  AddQuestionNotifier(this._apiService) : super(const AddQuestionState());

  /// Update question text
  void updateQuestionText(String text) {
    state = state.copyWith(questionText: text);
  }

  /// Add a new option
  void addOption() {
    final newOptions = List<QuestionOption>.from(state.options)
      ..add(
        QuestionOption(
          id: String.fromCharCode(65 + state.options.length), // A, B, C, D...
          text: '',
        ),
      );
    state = state.copyWith(options: newOptions);
  }

  /// Remove an option
  void removeOption(int index) {
    if (state.options.length <= 2) return; // Minimum 2 options

    final newOptions = List<QuestionOption>.from(state.options)
      ..removeAt(index);

    // Update correct answers to remove references to deleted option
    final newCorrectAnswers = state.correctAnswers
        .where((answerId) => newOptions.any((option) => option.id == answerId))
        .toList();

    state = state.copyWith(
      options: newOptions,
      correctAnswers: newCorrectAnswers,
    );
  }

  /// Update option text
  void updateOptionText(int index, String text) {
    final newOptions = List<QuestionOption>.from(state.options);
    newOptions[index] = newOptions[index].copyWith(text: text);
    state = state.copyWith(options: newOptions);
  }

  /// Toggle correct answer for single choice
  void toggleCorrectAnswer(String optionId) {
    if (state.questionType == QuestionType.singleChoice) {
      state = state.copyWith(correctAnswers: [optionId]);
    } else {
      // Multiple choice
      final newCorrectAnswers = List<String>.from(state.correctAnswers);
      if (newCorrectAnswers.contains(optionId)) {
        newCorrectAnswers.remove(optionId);
      } else {
        newCorrectAnswers.add(optionId);
      }
      state = state.copyWith(correctAnswers: newCorrectAnswers);
    }
  }

  /// Update question type
  void updateQuestionType(QuestionType type) {
    // Reset correct answers when switching types
    state = state.copyWith(
      questionType: type,
      correctAnswers: type == QuestionType.singleChoice
          ? []
          : state.correctAnswers,
    );
  }

  /// Update exam category
  void updateExamCategory(String category) {
    state = state.copyWith(examCategory: category);
  }

  /// Update subject
  void updateSubject(String subject) {
    state = state.copyWith(subject: subject);
  }

  /// Update topic
  void updateTopic(String topic) {
    state = state.copyWith(topic: topic);
  }

  /// Update sub-topic
  void updateSubTopic(String? subTopic) {
    state = state.copyWith(subTopic: subTopic);
  }

  /// Update difficulty
  void updateDifficulty(DifficultyLevel difficulty) {
    state = state.copyWith(difficulty: difficulty);
  }

  /// Update estimated time
  void updateEstimatedTime(int seconds) {
    state = state.copyWith(estimatedTimeSeconds: seconds);
  }

  /// Update explanation text
  void updateExplanationText(String text) {
    state = state.copyWith(explanationText: text);
  }

  /// Add a tag
  void addTag(String tag) {
    if (tag.isNotEmpty && !state.tags.contains(tag)) {
      final newTags = List<String>.from(state.tags)..add(tag);
      state = state.copyWith(tags: newTags);
    }
  }

  /// Remove a tag
  void removeTag(String tag) {
    final newTags = List<String>.from(state.tags)..remove(tag);
    state = state.copyWith(tags: newTags);
  }

  /// Reset the form
  void reset() {
    state = const AddQuestionState();
  }

  /// Submit the question
  Future<void> submitQuestion() async {
    if (!state.isValid) {
      state = state.copyWith(
        errorMessage:
            'Please fill in all required fields and ensure at least one correct answer is selected.',
      );
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final question = state.toQuestion();
      if (question == null) {
        throw Exception('Failed to create question object');
      }

      // TODO: Implement actual API call to save question
      // await _apiService.createQuestion(question);

      // For now, simulate API call
      await Future.delayed(const Duration(seconds: 1));

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to save question: ${e.toString()}',
      );
    }
  }
}
