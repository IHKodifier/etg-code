// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
  id: json['id'] as String,
  questionId: (json['questionId'] as num).toInt(),
  examCategory: json['examCategory'] as String,
  subject: json['subject'] as String,
  topic: json['topic'] as String,
  subTopic: json['subTopic'] as String?,
  questionText: json['questionText'] as String,
  questionImageUrls: (json['questionImageUrls'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  questionLatex: (json['questionLatex'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  options: (json['options'] as List<dynamic>)
      .map((e) => QuestionOption.fromJson(e as Map<String, dynamic>))
      .toList(),
  correctAnswer: (json['correctAnswer'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  questionType: $enumDecode(_$QuestionTypeEnumMap, json['questionType']),
  explanationText: json['explanationText'] as String,
  explanationVideoUrl: json['explanationVideoUrl'] as String?,
  explanationSteps: (json['explanationSteps'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  references: (json['references'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  ardeProbability: (json['ardeProbability'] as num).toDouble(),
  ardeFrequency: (json['ardeFrequency'] as num).toInt(),
  ardeAppearanceYears: (json['ardeAppearanceYears'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  ardeNotes: json['ardeNotes'] as String?,
  ardeContext: json['ardeContext'] as String?,
  difficulty: $enumDecode(_$DifficultyLevelEnumMap, json['difficulty']),
  estimatedTimeSeconds: (json['estimatedTimeSeconds'] as num).toInt(),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  relatedQuestions: (json['relatedQuestions'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  createdBy: json['createdBy'] as String,
  createdByName: json['createdByName'] as String?,
  isActive: json['isActive'] as bool?,
  version: (json['version'] as num?)?.toInt(),
  status: json['status'] as String?,
  approvalStatus: json['approval_status'] as String,
  reviewerId: json['reviewer_id'] as String?,
  reviewerName: json['reviewer_name'] as String?,
  reviewComments: json['review_comments'] as String?,
  submittedAt: DateTime.parse(json['submitted_at'] as String),
  reviewedAt: json['reviewed_at'] == null
      ? null
      : DateTime.parse(json['reviewed_at'] as String),
  approvedAt: json['approved_at'] == null
      ? null
      : DateTime.parse(json['approved_at'] as String),
  isBookmarked: json['isBookmarked'] as bool,
  userNotes: json['userNotes'] as String?,
  lastAttempt: json['lastAttempt'] == null
      ? null
      : QuestionAttempt.fromJson(json['lastAttempt'] as Map<String, dynamic>),
);

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
  'id': instance.id,
  'questionId': instance.questionId,
  'examCategory': instance.examCategory,
  'subject': instance.subject,
  'topic': instance.topic,
  'subTopic': instance.subTopic,
  'questionText': instance.questionText,
  'questionImageUrls': instance.questionImageUrls,
  'questionLatex': instance.questionLatex,
  'options': instance.options.map((e) => e.toJson()).toList(),
  'correctAnswer': instance.correctAnswer,
  'questionType': _$QuestionTypeEnumMap[instance.questionType]!,
  'explanationText': instance.explanationText,
  'explanationVideoUrl': instance.explanationVideoUrl,
  'explanationSteps': instance.explanationSteps,
  'references': instance.references,
  'ardeProbability': instance.ardeProbability,
  'ardeFrequency': instance.ardeFrequency,
  'ardeAppearanceYears': instance.ardeAppearanceYears,
  'ardeNotes': instance.ardeNotes,
  'ardeContext': instance.ardeContext,
  'difficulty': _$DifficultyLevelEnumMap[instance.difficulty]!,
  'estimatedTimeSeconds': instance.estimatedTimeSeconds,
  'tags': instance.tags,
  'relatedQuestions': instance.relatedQuestions,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'createdBy': instance.createdBy,
  'createdByName': instance.createdByName,
  'isActive': instance.isActive,
  'version': instance.version,
  'status': instance.status,
  'approval_status': instance.approvalStatus,
  'reviewer_id': instance.reviewerId,
  'reviewer_name': instance.reviewerName,
  'review_comments': instance.reviewComments,
  'submitted_at': instance.submittedAt.toIso8601String(),
  'reviewed_at': instance.reviewedAt?.toIso8601String(),
  'approved_at': instance.approvedAt?.toIso8601String(),
  'isBookmarked': instance.isBookmarked,
  'userNotes': instance.userNotes,
  'lastAttempt': instance.lastAttempt?.toJson(),
};

const _$QuestionTypeEnumMap = {
  QuestionType.singleChoice: 'singleChoice',
  QuestionType.multipleChoice: 'multipleChoice',
  QuestionType.assertionReason: 'assertionReason',
  QuestionType.numerical: 'numerical',
};

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.veryEasy: 'veryEasy',
  DifficultyLevel.easy: 'easy',
  DifficultyLevel.medium: 'medium',
  DifficultyLevel.hard: 'hard',
  DifficultyLevel.veryHard: 'veryHard',
};
