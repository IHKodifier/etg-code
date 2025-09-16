// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionImpl _$$QuestionImplFromJson(
  Map<String, dynamic> json,
) => _$QuestionImpl(
  id: json['id'] as String,
  questionId: json['questionId'] as String,
  examCategory: json['examCategory'] as String,
  subject: json['subject'] as String,
  topic: json['topic'] as String,
  subTopic: json['subTopic'] as String?,
  questionText: json['questionText'] as String,
  questionImageUrl: json['questionImageUrl'] as String?,
  questionLatex: json['questionLatex'] as String?,
  options: (json['options'] as List<dynamic>)
      .map((e) => QuestionOption.fromJson(e as Map<String, dynamic>))
      .toList(),
  correctAnswer: (json['correctAnswer'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  questionType:
      $enumDecodeNullable(_$QuestionTypeEnumMap, json['questionType']) ??
      QuestionType.singleChoice,
  explanationText: json['explanationText'] as String,
  explanationVideoUrl: json['explanationVideoUrl'] as String?,
  explanationSteps: (json['explanationSteps'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  references: (json['references'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  ardeProbability: $enumDecode(_$ArdeLevelEnumMap, json['ardeProbability']),
  ardeFrequency: (json['ardeFrequency'] as num?)?.toInt() ?? 0,
  ardeAppearanceYears: (json['ardeAppearanceYears'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  ardeNotes: json['ardeNotes'] as String?,
  ardeContext: json['ardeContext'] as String?,
  difficulty: $enumDecode(_$DifficultyLevelEnumMap, json['difficulty']),
  estimatedTimeSeconds: (json['estimatedTimeSeconds'] as num?)?.toInt() ?? 60,
  globalStats: QuestionPerformanceStats.fromJson(
    json['globalStats'] as Map<String, dynamic>,
  ),
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  relatedQuestions: (json['relatedQuestions'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  createdBy: json['createdBy'] as String,
  isActive: json['isActive'] as bool? ?? true,
  version: (json['version'] as num?)?.toInt() ?? 1,
  status: json['status'] as String?,
  isBookmarked: json['isBookmarked'] as bool? ?? false,
  userNotes: json['userNotes'] as String?,
  lastAttempt: json['lastAttempt'] == null
      ? null
      : QuestionAttempt.fromJson(json['lastAttempt'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$QuestionImplToJson(_$QuestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionId': instance.questionId,
      'examCategory': instance.examCategory,
      'subject': instance.subject,
      'topic': instance.topic,
      'subTopic': instance.subTopic,
      'questionText': instance.questionText,
      'questionImageUrl': instance.questionImageUrl,
      'questionLatex': instance.questionLatex,
      'options': instance.options,
      'correctAnswer': instance.correctAnswer,
      'questionType': _$QuestionTypeEnumMap[instance.questionType]!,
      'explanationText': instance.explanationText,
      'explanationVideoUrl': instance.explanationVideoUrl,
      'explanationSteps': instance.explanationSteps,
      'references': instance.references,
      'ardeProbability': _$ArdeLevelEnumMap[instance.ardeProbability]!,
      'ardeFrequency': instance.ardeFrequency,
      'ardeAppearanceYears': instance.ardeAppearanceYears,
      'ardeNotes': instance.ardeNotes,
      'ardeContext': instance.ardeContext,
      'difficulty': _$DifficultyLevelEnumMap[instance.difficulty]!,
      'estimatedTimeSeconds': instance.estimatedTimeSeconds,
      'globalStats': instance.globalStats,
      'tags': instance.tags,
      'relatedQuestions': instance.relatedQuestions,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'createdBy': instance.createdBy,
      'isActive': instance.isActive,
      'version': instance.version,
      'status': instance.status,
      'isBookmarked': instance.isBookmarked,
      'userNotes': instance.userNotes,
      'lastAttempt': instance.lastAttempt,
    };

const _$QuestionTypeEnumMap = {
  QuestionType.singleChoice: 'singleChoice',
  QuestionType.multipleChoice: 'multipleChoice',
  QuestionType.assertionReason: 'assertionReason',
  QuestionType.numerical: 'numerical',
};

const _$ArdeLevelEnumMap = {
  ArdeLevel.high: 'high',
  ArdeLevel.medium: 'medium',
  ArdeLevel.low: 'low',
};

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.veryEasy: 'veryEasy',
  DifficultyLevel.easy: 'easy',
  DifficultyLevel.medium: 'medium',
  DifficultyLevel.hard: 'hard',
  DifficultyLevel.veryHard: 'veryHard',
};
