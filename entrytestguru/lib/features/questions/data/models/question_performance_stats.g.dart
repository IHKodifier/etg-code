// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_performance_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionPerformanceStatsImpl _$$QuestionPerformanceStatsImplFromJson(
  Map<String, dynamic> json,
) => _$QuestionPerformanceStatsImpl(
  totalAttempts: (json['totalAttempts'] as num?)?.toInt() ?? 0,
  totalCorrect: (json['totalCorrect'] as num?)?.toInt() ?? 0,
  globalAccuracy: (json['globalAccuracy'] as num?)?.toDouble() ?? 0.0,
  averageTimeSeconds: (json['averageTimeSeconds'] as num?)?.toDouble() ?? 0.0,
  medianTimeSeconds: (json['medianTimeSeconds'] as num?)?.toDouble() ?? 0.0,
  p95TimeSeconds: (json['p95TimeSeconds'] as num?)?.toDouble() ?? 0.0,
  calculatedDifficulty:
      (json['calculatedDifficulty'] as num?)?.toDouble() ?? 0.0,
  tierPerformance: (json['tierPerformance'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, TierPerformance.fromJson(e as Map<String, dynamic>)),
  ),
  commonMistakes: (json['commonMistakes'] as List<dynamic>?)
      ?.map((e) => WrongAnswerPattern.fromJson(e as Map<String, dynamic>))
      .toList(),
  timeDistribution: (json['timeDistribution'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
);

Map<String, dynamic> _$$QuestionPerformanceStatsImplToJson(
  _$QuestionPerformanceStatsImpl instance,
) => <String, dynamic>{
  'totalAttempts': instance.totalAttempts,
  'totalCorrect': instance.totalCorrect,
  'globalAccuracy': instance.globalAccuracy,
  'averageTimeSeconds': instance.averageTimeSeconds,
  'medianTimeSeconds': instance.medianTimeSeconds,
  'p95TimeSeconds': instance.p95TimeSeconds,
  'calculatedDifficulty': instance.calculatedDifficulty,
  'tierPerformance': instance.tierPerformance,
  'commonMistakes': instance.commonMistakes,
  'timeDistribution': instance.timeDistribution,
};

_$TierPerformanceImpl _$$TierPerformanceImplFromJson(
  Map<String, dynamic> json,
) => _$TierPerformanceImpl(
  tier: json['tier'] as String,
  attempts: (json['attempts'] as num?)?.toInt() ?? 0,
  accuracy: (json['accuracy'] as num?)?.toDouble() ?? 0.0,
  avgTimeSeconds: (json['avgTimeSeconds'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$TierPerformanceImplToJson(
  _$TierPerformanceImpl instance,
) => <String, dynamic>{
  'tier': instance.tier,
  'attempts': instance.attempts,
  'accuracy': instance.accuracy,
  'avgTimeSeconds': instance.avgTimeSeconds,
};

_$WrongAnswerPatternImpl _$$WrongAnswerPatternImplFromJson(
  Map<String, dynamic> json,
) => _$WrongAnswerPatternImpl(
  optionId: json['optionId'] as String,
  selectionCount: (json['selectionCount'] as num?)?.toInt() ?? 0,
  percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$WrongAnswerPatternImplToJson(
  _$WrongAnswerPatternImpl instance,
) => <String, dynamic>{
  'optionId': instance.optionId,
  'selectionCount': instance.selectionCount,
  'percentage': instance.percentage,
};
