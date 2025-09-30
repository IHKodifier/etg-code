// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionFilterImpl _$$QuestionFilterImplFromJson(Map<String, dynamic> json) =>
    _$QuestionFilterImpl(
      examCategories: (json['examCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      subjects: (json['subjects'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      topics: (json['topics'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      difficulties: (json['difficulties'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$DifficultyLevelEnumMap, e))
          .toList(),
      questionTypes: (json['questionTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ardeProbabilities: (json['ardeProbabilities'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ArdeLevelEnumMap, e))
          .toList(),
      minArdeFrequency: (json['minArdeFrequency'] as num?)?.toInt(),
      minCreatedDate: json['minCreatedDate'] == null
          ? null
          : DateTime.parse(json['minCreatedDate'] as String),
      maxCreatedDate: json['maxCreatedDate'] == null
          ? null
          : DateTime.parse(json['maxCreatedDate'] as String),
      showWeakAreas: json['showWeakAreas'] as bool?,
      showUnattempted: json['showUnattempted'] as bool?,
      showIncorrect: json['showIncorrect'] as bool?,
      showBookmarked: json['showBookmarked'] as bool?,
      searchQuery: json['searchQuery'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      sortBy: $enumDecodeNullable(_$QuestionSortByEnumMap, json['sortBy']),
      sortDirection:
          $enumDecodeNullable(_$SortDirectionEnumMap, json['sortDirection']) ??
          SortDirection.descending,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
      lastDocumentId: json['lastDocumentId'] as String?,
    );

Map<String, dynamic> _$$QuestionFilterImplToJson(
  _$QuestionFilterImpl instance,
) => <String, dynamic>{
  'examCategories': instance.examCategories,
  'subjects': instance.subjects,
  'topics': instance.topics,
  'difficulties': instance.difficulties
      ?.map((e) => _$DifficultyLevelEnumMap[e]!)
      .toList(),
  'questionTypes': instance.questionTypes,
  'ardeProbabilities': instance.ardeProbabilities
      ?.map((e) => _$ArdeLevelEnumMap[e]!)
      .toList(),
  'minArdeFrequency': instance.minArdeFrequency,
  'minCreatedDate': instance.minCreatedDate?.toIso8601String(),
  'maxCreatedDate': instance.maxCreatedDate?.toIso8601String(),
  'showWeakAreas': instance.showWeakAreas,
  'showUnattempted': instance.showUnattempted,
  'showIncorrect': instance.showIncorrect,
  'showBookmarked': instance.showBookmarked,
  'searchQuery': instance.searchQuery,
  'tags': instance.tags,
  'sortBy': _$QuestionSortByEnumMap[instance.sortBy],
  'sortDirection': _$SortDirectionEnumMap[instance.sortDirection],
  'limit': instance.limit,
  'lastDocumentId': instance.lastDocumentId,
};

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.veryEasy: 'veryEasy',
  DifficultyLevel.easy: 'easy',
  DifficultyLevel.medium: 'medium',
  DifficultyLevel.hard: 'hard',
  DifficultyLevel.veryHard: 'veryHard',
};

const _$ArdeLevelEnumMap = {
  ArdeLevel.high: 'high',
  ArdeLevel.medium: 'medium',
  ArdeLevel.low: 'low',
};

const _$QuestionSortByEnumMap = {
  QuestionSortBy.relevance: 'relevance',
  QuestionSortBy.ardeProbability: 'ardeProbability',
  QuestionSortBy.difficulty: 'difficulty',
  QuestionSortBy.accuracy: 'accuracy',
  QuestionSortBy.createdDate: 'createdDate',
  QuestionSortBy.popularity: 'popularity',
};

const _$SortDirectionEnumMap = {
  SortDirection.ascending: 'ascending',
  SortDirection.descending: 'descending',
};
