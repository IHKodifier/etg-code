import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/question_api_service.dart';
import '../../data/services/bulk_upload_api_service.dart';
import '../../data/models/question.dart';
import '../../data/models/question_option.dart';
import '../../data/models/question_enums.dart';
import '../../data/models/question_create_request.dart';
import '../states/add_question_state.dart';
import '../../../../core/services/firestore_service.dart';
import '../../utils/question_schema_mapper.dart';
import 'package:logging/logging.dart';

/// StateNotifierProvider for managing add question state
final addQuestionNotifierProvider =
    StateNotifierProvider<AddQuestionNotifier, AddQuestionState>((ref) {
      final questionApiService = ref.watch(QuestionApiService.provider);
      final bulkUploadApiService = ref.watch(BulkUploadApiService.provider);
      final firestoreService = ref.watch(firestoreServiceProvider);
      return AddQuestionNotifier(
        questionApiService,
        bulkUploadApiService,
        firestoreService,
      );
    });

/// StateNotifier for managing add question operations
class AddQuestionNotifier extends StateNotifier<AddQuestionState> {
  final QuestionApiService _questionApiService;
  final BulkUploadApiService _bulkUploadApiService;
  final FirestoreService _firestoreService;
  final Logger _logger = Logger('AddQuestionNotifier');

  AddQuestionNotifier(
    this._questionApiService,
    this._bulkUploadApiService,
    this._firestoreService,
  ) : super(const AddQuestionState()) {
    // Initialize with 2 default options
    addOption();
    addOption();
  }

  /// Update question text
  void updateQuestionText(String text) {
    state = state.copyWith(questionText: text);
  }

  /// Update question image URL (legacy method for backward compatibility)
  void updateQuestionImageUrl(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      addQuestionImageUrl(imageUrl);
    }
  }

  /// Add a question LaTeX expression to the list
  void addQuestionLatex(String latex) {
    final currentLatex = List<String>.from(state.questionLatex ?? []);
    // Always add the LaTeX, even if empty, to trigger UI update
    currentLatex.add(latex);
    state = state.copyWith(questionLatex: currentLatex);
  }

  /// Remove a question LaTeX expression from the list
  void removeQuestionLatex(String latex) {
    final currentLatex = List<String>.from(state.questionLatex ?? []);
    currentLatex.remove(latex);
    state = state.copyWith(
      questionLatex: currentLatex.isEmpty ? null : currentLatex,
    );
  }

  /// Update a specific question LaTeX expression in the list
  void updateQuestionLatexAt(int index, String latex) {
    if (latex.isNotEmpty) {
      final currentLatex = List<String>.from(state.questionLatex ?? []);
      if (index >= 0 && index < currentLatex.length) {
        currentLatex[index] = latex;
        state = state.copyWith(questionLatex: currentLatex);
      }
    }
  }

  /// Add a question image URL to the list
  void addQuestionImageUrl(String imageUrl) {
    final currentUrls = List<String>.from(state.questionImageUrls ?? []);
    // Always add the URL, even if empty, to trigger UI update
    currentUrls.add(imageUrl);
    state = state.copyWith(questionImageUrls: currentUrls);
  }

  /// Remove a question image URL from the list
  void removeQuestionImageUrl(String imageUrl) {
    final currentUrls = List<String>.from(state.questionImageUrls ?? []);
    currentUrls.remove(imageUrl);
    state = state.copyWith(
      questionImageUrls: currentUrls.isEmpty ? null : currentUrls,
    );
  }

  /// Update a specific question image URL in the list
  void updateQuestionImageUrlAt(int index, String imageUrl) {
    if (imageUrl.isNotEmpty) {
      final currentUrls = List<String>.from(state.questionImageUrls ?? []);
      if (index >= 0 && index < currentUrls.length) {
        currentUrls[index] = imageUrl;
        state = state.copyWith(questionImageUrls: currentUrls);
      }
    }
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

  /// Update option image URL
  void updateOptionImageUrl(int index, String? imageUrl) {
    final newOptions = List<QuestionOption>.from(state.options);
    newOptions[index] = newOptions[index].copyWith(imageUrl: imageUrl);
    state = state.copyWith(options: newOptions);
  }

  /// Update option LaTeX content
  void updateOptionLatex(int index, String? latex) {
    final newOptions = List<QuestionOption>.from(state.options);
    newOptions[index] = newOptions[index].copyWith(latex: latex);
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

  /// Load a question for editing
  void loadQuestionForEditing(Question question) {
    state = AddQuestionState(
      questionText: question.questionText,
      questionImageUrls: question.questionImageUrls,
      questionLatex: question.questionLatex,
      options: question.options,
      correctAnswers: question.correctAnswer,
      questionType: question.questionType,
      examCategory: question.examCategory,
      subject: question.subject,
      topic: question.topic,
      subTopic: question.subTopic,
      difficulty: question.difficulty,
      estimatedTimeSeconds: question.estimatedTimeSeconds,
      explanationText: question.explanationText,
      tags: question.tags,
      isEditing: true,
      editingQuestionId: question.id,
      originalQuestionId: question.questionId, // Store the numeric questionId
    );
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
      // Create question from state
      final question = state.toQuestion();
      if (question == null) {
        throw Exception('Failed to create question object');
      }

      // For new questions, generate timestamp-based questionId
      int nextQuestionId;
      if (state.isEditing) {
        // Use the existing questionId for editing
        nextQuestionId = state.originalQuestionId!;
      } else {
        // Generate unique timestamp-based ID for new questions
        nextQuestionId = QuestionSchemaMapper.generateUniqueQuestionId();
      }

      // Update question with the correct questionId
      final questionWithId = question.copyWith(questionId: nextQuestionId);

      // Try to use the API service first
      final request = QuestionCreateRequest.fromQuestion(questionWithId);
      final createdQuestion = await _questionApiService.createQuestion(request);

      _logger.info(
        'Question ${state.isEditing ? 'updated' : 'created'} successfully via API: ${createdQuestion.id}',
      );

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        errorMessage: null,
      );
    } catch (e) {
      // If API fails, fall back to Firestore with manual questionId generation
      _logger.warning('API call failed, falling back to Firestore: $e');

      try {
        await _submitQuestionToFirestore();
      } catch (firestoreError) {
        _logger.severe('Both API and Firestore failed: $firestoreError');
        state = state.copyWith(
          isLoading: false,
          errorMessage:
              'Unable to save question. Please check your connection and try again.',
        );
      }
    }
  }

  /// Fallback method to submit question directly to Firestore
  Future<void> _submitQuestionToFirestore() async {
    try {
      // Create question from state
      final question = state.toQuestion();
      if (question == null) {
        throw Exception('Failed to create question object');
      }

      // For new questions, generate timestamp-based questionId
      int nextQuestionId;
      if (state.isEditing) {
        // Use the existing questionId for editing
        nextQuestionId = state.originalQuestionId!;
      } else {
        // Generate unique timestamp-based ID for new questions
        nextQuestionId = QuestionSchemaMapper.generateUniqueQuestionId();
      }

      // Update question with the correct questionId
      final questionWithId = question.copyWith(questionId: nextQuestionId);

      // Use the model's toJson() method for consistent serialization
      final questionData = questionWithId.toJson();

      // Add/update Firestore-specific fields that aren't in the model
      questionData.addAll({
        'updatedAt': DateTime.now().toIso8601String(),
        'createdBy': state.isEditing
            ? question.createdBy
            : 'current_user', // TODO: Get from auth
        'isActive': true, // Ensure questions are active by default
      });

      // For editing, update the version
      if (state.isEditing) {
        questionData['version'] = (questionData['version'] ?? 1) + 1;
      }

      // Save or update to Firestore
      if (state.isEditing) {
        await _firestoreService.updateDocument(
          'questions',
          state.editingQuestionId!,
          questionData,
        );
      } else {
        await _firestoreService.addDocument('questions', questionData);
      }

      _logger.info(
        'Question ${state.isEditing ? 'updated' : 'created'} successfully via Firestore fallback',
      );

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        errorMessage: null,
      );
    } catch (e) {
      _logger.severe('Failed to save question to Firestore', e);
      rethrow;
    }
  }
}
