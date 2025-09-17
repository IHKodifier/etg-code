import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/question_api_service.dart';
import '../../data/models/question_option.dart';
import '../../data/models/question_enums.dart';
import '../states/add_question_state.dart';
import '../../../../core/services/firestore_service.dart';
import '../../../../core/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// StateNotifierProvider for managing add question state
final addQuestionNotifierProvider =
    StateNotifierProvider<AddQuestionNotifier, AddQuestionState>((ref) {
      final firestoreService = ref.watch(firestoreServiceProvider);
      final authService = ref.watch(authServiceProvider);
      return AddQuestionNotifier(firestoreService, authService);
    });

/// StateNotifier for managing add question operations
class AddQuestionNotifier extends StateNotifier<AddQuestionState> {
  final FirestoreService _firestoreService;
  final FirebaseAuthService _authService;

  AddQuestionNotifier(this._firestoreService, this._authService)
    : super(const AddQuestionState());

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

      // Get current user for createdBy field
      final currentUser = _authService.currentUser;
      if (currentUser == null) {
        throw Exception('User must be logged in to create questions');
      }

      // Create question data for Firestore
      final questionData = {
        'id': question.id,
        'questionId': question.questionId,
        'examCategory': question.examCategory,
        'subject': question.subject,
        'topic': question.topic,
        'subTopic': question.subTopic,
        'questionText': question.questionText,
        'questionImageUrl': question.questionImageUrl,
        'questionLatex': question.questionLatex,
        'options': question.options
            .map(
              (option) => {
                'id': option.id,
                'text': option.text,
                'imageUrl': option.imageUrl,
                'latex': option.latex,
              },
            )
            .toList(),
        'correctAnswer': question.correctAnswer,
        'questionType': question.questionType.name,
        'explanationText': question.explanationText,
        'explanationVideoUrl': question.explanationVideoUrl,
        'explanationSteps': question.explanationSteps,
        'references': question.references,
        'ardeProbability': question.ardeProbability.name,
        'ardeFrequency': question.ardeFrequency,
        'ardeAppearanceYears': question.ardeAppearanceYears,
        'ardeNotes': question.ardeNotes,
        'ardeContext': question.ardeContext,
        'difficulty': question.difficulty.name,
        'estimatedTimeSeconds': question.estimatedTimeSeconds,
        'globalStats': {
          'totalAttempts': question.globalStats.totalAttempts,
          'totalCorrect': question.globalStats.totalCorrect,
          'globalAccuracy': question.globalStats.globalAccuracy,
          'averageTimeSeconds': question.globalStats.averageTimeSeconds,
          'medianTimeSeconds': question.globalStats.medianTimeSeconds,
          'p95TimeSeconds': question.globalStats.p95TimeSeconds,
          'calculatedDifficulty': question.globalStats.calculatedDifficulty,
        },
        'tags': question.tags,
        'createdAt': question.createdAt.toIso8601String(),
        'updatedAt': question.updatedAt.toIso8601String(),
        'createdBy': currentUser.id,
        'isActive': question.isActive,
        'version': question.version,
        'status': question.status,
        'approvalStatus': question.approvalStatus,
        'submittedAt': question.submittedAt.toIso8601String(),
        'reviewerId': question.reviewerId,
        'reviewerName': question.reviewerName,
        'reviewComments': question.reviewComments,
        'reviewedAt': question.reviewedAt?.toIso8601String(),
        'approvedAt': question.approvedAt?.toIso8601String(),
      };

      // Save to Firestore
      await _firestoreService.addDocument('questions', questionData);

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
