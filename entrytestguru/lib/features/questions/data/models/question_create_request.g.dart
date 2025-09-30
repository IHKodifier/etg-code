// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionCreateRequestImpl _$$QuestionCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$QuestionCreateRequestImpl(
  questionText: json['questionText'] as String,
  options: (json['options'] as List<dynamic>)
      .map((e) => QuestionOption.fromJson(e as Map<String, dynamic>))
      .toList(),
  correctAnswer: (json['correctAnswer'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  examType: json['examType'] as String,
  subject: json['subject'] as String,
  topic: json['topic'] as String,
  difficulty: json['difficulty'] as String,
  ardeProbability: (json['ardeProbability'] as num?)?.toDouble() ?? 0.5,
  historicalFrequency: (json['historicalFrequency'] as num?)?.toInt() ?? 0,
  explanation: json['explanation'] as String?,
  videoExplanationUrl: json['videoExplanationUrl'] as String?,
  references:
      (json['references'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  ardeContext: json['ardeContext'] as String?,
);

Map<String, dynamic> _$$QuestionCreateRequestImplToJson(
  _$QuestionCreateRequestImpl instance,
) => <String, dynamic>{
  'questionText': instance.questionText,
  'options': instance.options,
  'correctAnswer': instance.correctAnswer,
  'examType': instance.examType,
  'subject': instance.subject,
  'topic': instance.topic,
  'difficulty': instance.difficulty,
  'ardeProbability': instance.ardeProbability,
  'historicalFrequency': instance.historicalFrequency,
  'explanation': instance.explanation,
  'videoExplanationUrl': instance.videoExplanationUrl,
  'references': instance.references,
  'ardeContext': instance.ardeContext,
};
