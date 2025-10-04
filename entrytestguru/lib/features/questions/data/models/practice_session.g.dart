// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PracticeSessionFilterImpl _$$PracticeSessionFilterImplFromJson(
  Map<String, dynamic> json,
) => _$PracticeSessionFilterImpl(
  examType: json['exam_type'] as String,
  subject: json['subject'] as String?,
  topic: json['topic'] as String?,
  difficulty: json['difficulty'] as String?,
  ardeProbability: json['arde_probability'] as String?,
  questionCount: (json['question_count'] as num?)?.toInt() ?? 10,
);

Map<String, dynamic> _$$PracticeSessionFilterImplToJson(
  _$PracticeSessionFilterImpl instance,
) => <String, dynamic>{
  'exam_type': instance.examType,
  'subject': instance.subject,
  'topic': instance.topic,
  'difficulty': instance.difficulty,
  'arde_probability': instance.ardeProbability,
  'question_count': instance.questionCount,
};

_$PracticeSessionSettingsImpl _$$PracticeSessionSettingsImplFromJson(
  Map<String, dynamic> json,
) => _$PracticeSessionSettingsImpl(
  showExplanations: json['show_explanations'] as bool? ?? true,
  randomizeOrder: json['randomize_order'] as bool? ?? true,
  allowSkipping: json['allow_skipping'] as bool? ?? true,
  timeLimitPerQuestion: (json['time_limit_per_question'] as num?)?.toInt(),
  maxAttemptsPerQuestion:
      (json['max_attempts_per_question'] as num?)?.toInt() ?? 3,
);

Map<String, dynamic> _$$PracticeSessionSettingsImplToJson(
  _$PracticeSessionSettingsImpl instance,
) => <String, dynamic>{
  'show_explanations': instance.showExplanations,
  'randomize_order': instance.randomizeOrder,
  'allow_skipping': instance.allowSkipping,
  'time_limit_per_question': instance.timeLimitPerQuestion,
  'max_attempts_per_question': instance.maxAttemptsPerQuestion,
};

_$PracticeSessionCreateRequestImpl _$$PracticeSessionCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$PracticeSessionCreateRequestImpl(
  filterCriteria: PracticeSessionFilter.fromJson(
    json['filter_criteria'] as Map<String, dynamic>,
  ),
  settings: json['settings'] == null
      ? null
      : PracticeSessionSettings.fromJson(
          json['settings'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$PracticeSessionCreateRequestImplToJson(
  _$PracticeSessionCreateRequestImpl instance,
) => <String, dynamic>{
  'filter_criteria': instance.filterCriteria,
  'settings': instance.settings,
};

_$PracticeSessionSummaryImpl _$$PracticeSessionSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$PracticeSessionSummaryImpl(
  id: json['id'] as String,
  sessionType: json['session_type'] as String,
  examType: json['exam_type'] as String,
  subject: json['subject'] as String?,
  totalQuestions: (json['total_questions'] as num).toInt(),
  answeredQuestions: (json['answered_questions'] as num).toInt(),
  correctAnswers: (json['correct_answers'] as num).toInt(),
  accuracyPercentage: (json['accuracy_percentage'] as num).toDouble(),
  totalTimeSpent: (json['total_time_spent'] as num).toInt(),
  startedAt: DateTime.parse(json['started_at'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  status: json['status'] as String,
);

Map<String, dynamic> _$$PracticeSessionSummaryImplToJson(
  _$PracticeSessionSummaryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'session_type': instance.sessionType,
  'exam_type': instance.examType,
  'subject': instance.subject,
  'total_questions': instance.totalQuestions,
  'answered_questions': instance.answeredQuestions,
  'correct_answers': instance.correctAnswers,
  'accuracy_percentage': instance.accuracyPercentage,
  'total_time_spent': instance.totalTimeSpent,
  'started_at': instance.startedAt.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
  'status': instance.status,
};

_$PracticeSessionResponseImpl _$$PracticeSessionResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PracticeSessionResponseImpl(
  id: json['id'] as String,
  sessionType: json['session_type'] as String,
  filterCriteria: PracticeSessionFilter.fromJson(
    json['filterCriteria'] as Map<String, dynamic>,
  ),
  currentQuestionIndex: (json['current_question_index'] as num).toInt(),
  status: json['status'] as String,
  startedAt: DateTime.parse(json['started_at'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  totalQuestions: (json['total_questions'] as num).toInt(),
  answeredQuestions: (json['answered_questions'] as num).toInt(),
  correctAnswers: (json['correct_answers'] as num).toInt(),
  totalTimeSpent: (json['total_time_spent'] as num).toInt(),
  settings: PracticeSessionSettings.fromJson(
    json['settings'] as Map<String, dynamic>,
  ),
  progressPercentage: (json['progress_percentage'] as num).toDouble(),
  accuracyPercentage: (json['accuracy_percentage'] as num).toDouble(),
  averageTimePerQuestion: (json['average_time_per_question'] as num).toDouble(),
  currentQuestionId: json['current_question_id'] as String?,
  hasNextQuestion: json['has_next_question'] as bool,
  hasPreviousQuestion: json['has_previous_question'] as bool,
);

Map<String, dynamic> _$$PracticeSessionResponseImplToJson(
  _$PracticeSessionResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'session_type': instance.sessionType,
  'filterCriteria': instance.filterCriteria,
  'current_question_index': instance.currentQuestionIndex,
  'status': instance.status,
  'started_at': instance.startedAt.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
  'total_questions': instance.totalQuestions,
  'answered_questions': instance.answeredQuestions,
  'correct_answers': instance.correctAnswers,
  'total_time_spent': instance.totalTimeSpent,
  'settings': instance.settings,
  'progress_percentage': instance.progressPercentage,
  'accuracy_percentage': instance.accuracyPercentage,
  'average_time_per_question': instance.averageTimePerQuestion,
  'current_question_id': instance.currentQuestionId,
  'has_next_question': instance.hasNextQuestion,
  'has_previous_question': instance.hasPreviousQuestion,
};

_$PracticeSessionAttemptImpl _$$PracticeSessionAttemptImplFromJson(
  Map<String, dynamic> json,
) => _$PracticeSessionAttemptImpl(
  id: json['id'] as String,
  sessionId: json['session_id'] as String,
  questionId: json['question_id'] as String,
  userId: json['user_id'] as String,
  selectedAnswers: (json['selected_answers'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  correctAnswers: (json['correct_answers'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  isCorrect: json['is_correct'] as bool,
  timeSpent: (json['time_spent'] as num).toInt(),
  attemptNumber: (json['attempt_number'] as num?)?.toInt() ?? 1,
  timestamp: DateTime.parse(json['timestamp'] as String),
  explanationShown: json['explanation_shown'] as bool? ?? false,
  hintUsed: json['hint_used'] as bool? ?? false,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$$PracticeSessionAttemptImplToJson(
  _$PracticeSessionAttemptImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'session_id': instance.sessionId,
  'question_id': instance.questionId,
  'user_id': instance.userId,
  'selected_answers': instance.selectedAnswers,
  'correct_answers': instance.correctAnswers,
  'is_correct': instance.isCorrect,
  'time_spent': instance.timeSpent,
  'attempt_number': instance.attemptNumber,
  'timestamp': instance.timestamp.toIso8601String(),
  'explanation_shown': instance.explanationShown,
  'hint_used': instance.hintUsed,
  'notes': instance.notes,
};

_$PracticeSessionStatisticsImpl _$$PracticeSessionStatisticsImplFromJson(
  Map<String, dynamic> json,
) => _$PracticeSessionStatisticsImpl(
  sessionId: json['session_id'] as String,
  totalQuestions: (json['total_questions'] as num).toInt(),
  answeredQuestions: (json['answered_questions'] as num).toInt(),
  correctAnswers: (json['correct_answers'] as num).toInt(),
  incorrectAnswers: (json['incorrect_answers'] as num).toInt(),
  skippedQuestions: (json['skipped_questions'] as num).toInt(),
  accuracyPercentage: (json['accuracy_percentage'] as num).toDouble(),
  totalTimeSpent: (json['total_time_spent'] as num).toInt(),
  averageTimePerQuestion: (json['average_time_per_question'] as num).toDouble(),
  fastestCorrectTime: (json['fastest_correct_time'] as num?)?.toInt(),
  slowestCorrectTime: (json['slowest_correct_time'] as num?)?.toInt(),
  subjectBreakdown: json['subject_breakdown'] as Map<String, dynamic>,
  difficultyBreakdown: json['difficulty_breakdown'] as Map<String, dynamic>,
  timeDistribution: json['time_distribution'] as Map<String, dynamic>,
);

Map<String, dynamic> _$$PracticeSessionStatisticsImplToJson(
  _$PracticeSessionStatisticsImpl instance,
) => <String, dynamic>{
  'session_id': instance.sessionId,
  'total_questions': instance.totalQuestions,
  'answered_questions': instance.answeredQuestions,
  'correct_answers': instance.correctAnswers,
  'incorrect_answers': instance.incorrectAnswers,
  'skipped_questions': instance.skippedQuestions,
  'accuracy_percentage': instance.accuracyPercentage,
  'total_time_spent': instance.totalTimeSpent,
  'average_time_per_question': instance.averageTimePerQuestion,
  'fastest_correct_time': instance.fastestCorrectTime,
  'slowest_correct_time': instance.slowestCorrectTime,
  'subject_breakdown': instance.subjectBreakdown,
  'difficulty_breakdown': instance.difficultyBreakdown,
  'time_distribution': instance.timeDistribution,
};

_$PracticeSessionAttemptRequestImpl
_$$PracticeSessionAttemptRequestImplFromJson(Map<String, dynamic> json) =>
    _$PracticeSessionAttemptRequestImpl(
      questionId: json['question_id'] as String,
      selectedAnswers: (json['selected_answers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      timeSpent: (json['time_spent'] as num).toInt(),
      attemptNumber: (json['attempt_number'] as num?)?.toInt() ?? 1,
      explanationShown: json['explanation_shown'] as bool? ?? false,
      hintUsed: json['hint_used'] as bool? ?? false,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$PracticeSessionAttemptRequestImplToJson(
  _$PracticeSessionAttemptRequestImpl instance,
) => <String, dynamic>{
  'question_id': instance.questionId,
  'selected_answers': instance.selectedAnswers,
  'time_spent': instance.timeSpent,
  'attempt_number': instance.attemptNumber,
  'explanation_shown': instance.explanationShown,
  'hint_used': instance.hintUsed,
  'notes': instance.notes,
};

_$PracticeSessionProgressUpdateImpl
_$$PracticeSessionProgressUpdateImplFromJson(Map<String, dynamic> json) =>
    _$PracticeSessionProgressUpdateImpl(
      questionIndex: (json['question_index'] as num).toInt(),
      timeSpent: (json['time_spent'] as num).toInt(),
    );

Map<String, dynamic> _$$PracticeSessionProgressUpdateImplToJson(
  _$PracticeSessionProgressUpdateImpl instance,
) => <String, dynamic>{
  'question_index': instance.questionIndex,
  'time_spent': instance.timeSpent,
};
