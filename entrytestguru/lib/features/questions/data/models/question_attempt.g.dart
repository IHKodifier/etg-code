// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_attempt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionAttemptImpl _$$QuestionAttemptImplFromJson(
  Map<String, dynamic> json,
) => _$QuestionAttemptImpl(
  questionId: json['questionId'] as String,
  sessionId: json['sessionId'] as String,
  selectedAnswers: (json['selectedAnswers'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  isCorrect: json['isCorrect'] as bool,
  attemptNumber: (json['attemptNumber'] as num?)?.toInt() ?? 1,
  timeSpent: Duration(microseconds: (json['timeSpent'] as num).toInt()),
  timestamp: DateTime.parse(json['timestamp'] as String),
  hintUsed: json['hintUsed'] as bool?,
  explanationViewed: json['explanationViewed'] as bool?,
  aiInteractionId: json['aiInteractionId'] as String?,
  timePercentile: (json['timePercentile'] as num?)?.toDouble(),
  difficultyAssessment: json['difficultyAssessment'] as String?,
);

Map<String, dynamic> _$$QuestionAttemptImplToJson(
  _$QuestionAttemptImpl instance,
) => <String, dynamic>{
  'questionId': instance.questionId,
  'sessionId': instance.sessionId,
  'selectedAnswers': instance.selectedAnswers,
  'isCorrect': instance.isCorrect,
  'attemptNumber': instance.attemptNumber,
  'timeSpent': instance.timeSpent.inMicroseconds,
  'timestamp': instance.timestamp.toIso8601String(),
  'hintUsed': instance.hintUsed,
  'explanationViewed': instance.explanationViewed,
  'aiInteractionId': instance.aiInteractionId,
  'timePercentile': instance.timePercentile,
  'difficultyAssessment': instance.difficultyAssessment,
};
