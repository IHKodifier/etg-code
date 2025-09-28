import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/question.dart';
import '../../data/models/question_enums.dart';
import '../../data/models/question_option.dart';
import '../../data/models/question_performance_stats.dart';
import '../../utils/question_schema_mapper.dart';

part 'add_question_state.freezed.dart';

@freezed
class AddQuestionState with _$AddQuestionState {
  const factory AddQuestionState({
    @Default('') String questionText,
    List<String>? questionImageUrls, // Multiple image URLs
    List<String>? questionLatex, // Multiple LaTeX expressions
    @Default([]) List<QuestionOption> options,
    @Default([]) List<String> correctAnswers,
    @Default(QuestionType.singleChoice) QuestionType questionType,
    @Default('') String examCategory,
    @Default('') String subject,
    @Default('') String topic,
    String? subTopic,
    @Default(DifficultyLevel.medium) DifficultyLevel difficulty,
    @Default(60) int estimatedTimeSeconds,
    String? explanationText,
    @Default([]) List<String> tags,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool isSuccess,
    @Default(false) bool isEditing,
    String? editingQuestionId,
    int?
    originalQuestionId, // Store the original numeric questionId when editing
  }) = _AddQuestionState;

  const AddQuestionState._();

  bool get isValid {
    return questionText.isNotEmpty &&
        options.length >= 2 &&
        correctAnswers.isNotEmpty &&
        examCategory.isNotEmpty &&
        subject.isNotEmpty &&
        topic.isNotEmpty;
  }

  bool get hasValidOptions {
    return options.every((option) => option.text.isNotEmpty) &&
        options.length >= 2 &&
        options.length <= 6;
  }

  bool get hasValidCorrectAnswers {
    if (correctAnswers.isEmpty) return false;

    if (questionType == QuestionType.singleChoice) {
      return correctAnswers.length == 1;
    } else if (questionType == QuestionType.multipleChoice) {
      return correctAnswers.length >= 1 &&
          correctAnswers.length < options.length;
    }

    return false;
  }

  Question? toQuestion() {
    if (!isValid || !hasValidOptions || !hasValidCorrectAnswers) {
      return null;
    }

    // Use schema mapper for consistent ID generation
    final questionId = isEditing && originalQuestionId != null
        ? originalQuestionId!
        : QuestionSchemaMapper.generateUniqueQuestionId();

    return Question(
      id: 'temp_${questionId}',
      questionId: questionId,
      examCategory: examCategory,
      subject: subject,
      topic: topic,
      subTopic: subTopic,
      questionText: questionText,
      questionImageUrls: questionImageUrls, // Multiple image URLs
      questionLatex: questionLatex, // Multiple LaTeX expressions
      options: options,
      correctAnswer: correctAnswers,
      questionType: questionType,
      explanationText: explanationText ?? '',
      ardeProbability: 0.5, // Default for new questions
      difficulty: difficulty,
      estimatedTimeSeconds: estimatedTimeSeconds,
      tags: tags,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      createdBy: 'current_user', // TODO: Get from auth
      isActive: true,
      version: 1,
      status: 'draft',

      // Approval workflow fields
      approvalStatus: 'pending',
      submittedAt: DateTime.now(),
    );
  }
}
