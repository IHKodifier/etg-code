import 'package:freezed_annotation/freezed_annotation.dart';
import 'question_option.dart';
import 'question.dart';

part 'question_create_request.freezed.dart';
part 'question_create_request.g.dart';

/// Request model for creating a new question
/// Matches the backend QuestionCreateRequest model
@freezed
class QuestionCreateRequest with _$QuestionCreateRequest {
  const QuestionCreateRequest._();

  const factory QuestionCreateRequest({
    required String questionText,
    required List<QuestionOption> options,
    required List<String> correctAnswer,
    required String examType,
    required String subject,
    required String topic,
    required String difficulty,
    @Default(0.5) double ardeProbability,
    @Default(0) int historicalFrequency,
    String? explanation,
    String? videoExplanationUrl,
    @Default([]) List<String> references,
    String? ardeContext,
  }) = _QuestionCreateRequest;

  /// Creates QuestionCreateRequest from JSON
  factory QuestionCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$QuestionCreateRequestFromJson(json);

  /// Creates QuestionCreateRequest from a Question model
  /// Now uses CSV format as standard
  factory QuestionCreateRequest.fromQuestion(Question question) {
    return QuestionCreateRequest(
      questionText: question.questionText,
      options: question.options,
      correctAnswer: question.correctAnswer,
      examType: question.examCategory, // Keep as-is (already matches CSV)
      subject: question.subject, // Keep as-is (already matches CSV)
      topic: question.topic, // Keep as-is (already matches CSV)
      difficulty:
          question.difficulty.name, // Use CSV format: "Easy", "Medium", "Hard"
      ardeProbability:
          question.ardeProbability, // Keep as decimal (matches CSV)
      explanation: question.explanationText,
      videoExplanationUrl: question.explanationVideoUrl,
      references: question.references ?? [],
      ardeContext: question.ardeContext,
    );
  }
}
