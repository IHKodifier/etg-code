import 'package:freezed_annotation/freezed_annotation.dart';

part 'practice_session.freezed.dart';
part 'practice_session.g.dart';

@freezed
class PracticeSessionFilter with _$PracticeSessionFilter {
  const factory PracticeSessionFilter({
    @JsonKey(name: 'exam_type') required String examType,
    String? subject,
    String? topic,
    String? difficulty,
    @JsonKey(name: 'arde_probability') String? ardeProbability,
    @JsonKey(name: 'question_count') @Default(10) int questionCount,
  }) = _PracticeSessionFilter;

  factory PracticeSessionFilter.fromJson(Map<String, dynamic> json) =>
      _$PracticeSessionFilterFromJson(json);
}

@freezed
class PracticeSessionSettings with _$PracticeSessionSettings {
  const factory PracticeSessionSettings({
    @JsonKey(name: 'show_explanations') @Default(true) bool showExplanations,
    @JsonKey(name: 'randomize_order') @Default(true) bool randomizeOrder,
    @JsonKey(name: 'allow_skipping') @Default(true) bool allowSkipping,
    @JsonKey(name: 'time_limit_per_question') int? timeLimitPerQuestion,
    @JsonKey(name: 'max_attempts_per_question')
    @Default(3)
    int maxAttemptsPerQuestion,
  }) = _PracticeSessionSettings;

  factory PracticeSessionSettings.fromJson(Map<String, dynamic> json) =>
      _$PracticeSessionSettingsFromJson(json);
}

@freezed
class PracticeSessionCreateRequest with _$PracticeSessionCreateRequest {
  const factory PracticeSessionCreateRequest({
    @JsonKey(name: 'filter_criteria')
    required PracticeSessionFilter filterCriteria,
    PracticeSessionSettings? settings,
  }) = _PracticeSessionCreateRequest;

  factory PracticeSessionCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$PracticeSessionCreateRequestFromJson(json);
}

@freezed
class PracticeSessionSummary with _$PracticeSessionSummary {
  const factory PracticeSessionSummary({
    required String id,
    @JsonKey(name: 'session_type') required String sessionType,
    @JsonKey(name: 'exam_type') required String examType,
    String? subject,
    @JsonKey(name: 'total_questions') required int totalQuestions,
    @JsonKey(name: 'answered_questions') required int answeredQuestions,
    @JsonKey(name: 'correct_answers') required int correctAnswers,
    @JsonKey(name: 'accuracy_percentage') required double accuracyPercentage,
    @JsonKey(name: 'total_time_spent') required int totalTimeSpent,
    @JsonKey(name: 'started_at') required DateTime startedAt,
    DateTime? completedAt,
    required String status,
  }) = _PracticeSessionSummary;

  factory PracticeSessionSummary.fromJson(Map<String, dynamic> json) =>
      _$PracticeSessionSummaryFromJson(json);
}

@freezed
class PracticeSessionResponse with _$PracticeSessionResponse {
  const factory PracticeSessionResponse({
    required String id,
    @JsonKey(name: 'session_type') required String sessionType,
    required PracticeSessionFilter filterCriteria,
    @JsonKey(name: 'current_question_index') required int currentQuestionIndex,
    required String status,
    @JsonKey(name: 'started_at') required DateTime startedAt,
    DateTime? completedAt,
    @JsonKey(name: 'total_questions') required int totalQuestions,
    @JsonKey(name: 'answered_questions') required int answeredQuestions,
    @JsonKey(name: 'correct_answers') required int correctAnswers,
    @JsonKey(name: 'total_time_spent') required int totalTimeSpent,
    required PracticeSessionSettings settings,
    @JsonKey(name: 'progress_percentage') required double progressPercentage,
    @JsonKey(name: 'accuracy_percentage') required double accuracyPercentage,
    @JsonKey(name: 'average_time_per_question')
    required double averageTimePerQuestion,
    @JsonKey(name: 'current_question_id') String? currentQuestionId,
    @JsonKey(name: 'has_next_question') required bool hasNextQuestion,
    @JsonKey(name: 'has_previous_question') required bool hasPreviousQuestion,
  }) = _PracticeSessionResponse;

  factory PracticeSessionResponse.fromJson(Map<String, dynamic> json) =>
      _$PracticeSessionResponseFromJson(json);
}

@freezed
class PracticeSessionAttempt with _$PracticeSessionAttempt {
  const factory PracticeSessionAttempt({
    required String id,
    @JsonKey(name: 'session_id') required String sessionId,
    @JsonKey(name: 'question_id') required String questionId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'selected_answers') required List<String> selectedAnswers,
    @JsonKey(name: 'correct_answers') required List<String> correctAnswers,
    @JsonKey(name: 'is_correct') required bool isCorrect,
    @JsonKey(name: 'time_spent') required int timeSpent,
    @JsonKey(name: 'attempt_number') @Default(1) int attemptNumber,
    required DateTime timestamp,
    @JsonKey(name: 'explanation_shown') @Default(false) bool explanationShown,
    @JsonKey(name: 'hint_used') @Default(false) bool hintUsed,
    String? notes,
  }) = _PracticeSessionAttempt;

  factory PracticeSessionAttempt.fromJson(Map<String, dynamic> json) =>
      _$PracticeSessionAttemptFromJson(json);
}

@freezed
class PracticeSessionStatistics with _$PracticeSessionStatistics {
  const factory PracticeSessionStatistics({
    @JsonKey(name: 'session_id') required String sessionId,
    @JsonKey(name: 'total_questions') required int totalQuestions,
    @JsonKey(name: 'answered_questions') required int answeredQuestions,
    @JsonKey(name: 'correct_answers') required int correctAnswers,
    @JsonKey(name: 'incorrect_answers') required int incorrectAnswers,
    @JsonKey(name: 'skipped_questions') required int skippedQuestions,
    @JsonKey(name: 'accuracy_percentage') required double accuracyPercentage,
    @JsonKey(name: 'total_time_spent') required int totalTimeSpent,
    @JsonKey(name: 'average_time_per_question')
    required double averageTimePerQuestion,
    @JsonKey(name: 'fastest_correct_time') int? fastestCorrectTime,
    @JsonKey(name: 'slowest_correct_time') int? slowestCorrectTime,
    @JsonKey(name: 'subject_breakdown')
    required Map<String, dynamic> subjectBreakdown,
    @JsonKey(name: 'difficulty_breakdown')
    required Map<String, dynamic> difficultyBreakdown,
    @JsonKey(name: 'time_distribution')
    required Map<String, dynamic> timeDistribution,
  }) = _PracticeSessionStatistics;

  factory PracticeSessionStatistics.fromJson(Map<String, dynamic> json) =>
      _$PracticeSessionStatisticsFromJson(json);
}

@freezed
class PracticeSessionAttemptRequest with _$PracticeSessionAttemptRequest {
  const factory PracticeSessionAttemptRequest({
    @JsonKey(name: 'question_id') required String questionId,
    @JsonKey(name: 'selected_answers') required List<String> selectedAnswers,
    @JsonKey(name: 'time_spent') required int timeSpent,
    @JsonKey(name: 'attempt_number') @Default(1) int attemptNumber,
    @JsonKey(name: 'explanation_shown') @Default(false) bool explanationShown,
    @JsonKey(name: 'hint_used') @Default(false) bool hintUsed,
    String? notes,
  }) = _PracticeSessionAttemptRequest;

  factory PracticeSessionAttemptRequest.fromJson(Map<String, dynamic> json) =>
      _$PracticeSessionAttemptRequestFromJson(json);
}

@freezed
class PracticeSessionProgressUpdate with _$PracticeSessionProgressUpdate {
  const factory PracticeSessionProgressUpdate({
    @JsonKey(name: 'question_index') required int questionIndex,
    @JsonKey(name: 'time_spent') required int timeSpent,
  }) = _PracticeSessionProgressUpdate;

  factory PracticeSessionProgressUpdate.fromJson(Map<String, dynamic> json) =>
      _$PracticeSessionProgressUpdateFromJson(json);
}
