// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_filter_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuickFilterStateImpl _$$QuickFilterStateImplFromJson(
  Map<String, dynamic> json,
) => _$QuickFilterStateImpl(
  searchQuery: json['searchQuery'] as String?,
  sortOption:
      $enumDecodeNullable(_$QuickSortOptionEnumMap, json['sortOption']) ??
      QuickSortOption.newestFirst,
  selectedDifficulties:
      (json['selectedDifficulties'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$DifficultyLevelEnumMap, e))
          .toSet() ??
      const <DifficultyLevel>{},
  selectedQuestionTypes:
      (json['selectedQuestionTypes'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$QuestionTypeEnumMap, e))
          .toSet() ??
      const <QuestionType>{},
  selectedExamCategories:
      (json['selectedExamCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toSet() ??
      const <String>{},
  selectedSubjects:
      (json['selectedSubjects'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toSet() ??
      const <String>{},
);

Map<String, dynamic> _$$QuickFilterStateImplToJson(
  _$QuickFilterStateImpl instance,
) => <String, dynamic>{
  'searchQuery': instance.searchQuery,
  'sortOption': _$QuickSortOptionEnumMap[instance.sortOption]!,
  'selectedDifficulties': instance.selectedDifficulties
      .map((e) => _$DifficultyLevelEnumMap[e]!)
      .toList(),
  'selectedQuestionTypes': instance.selectedQuestionTypes
      .map((e) => _$QuestionTypeEnumMap[e]!)
      .toList(),
  'selectedExamCategories': instance.selectedExamCategories.toList(),
  'selectedSubjects': instance.selectedSubjects.toList(),
};

const _$QuickSortOptionEnumMap = {
  QuickSortOption.newestFirst: 'newestFirst',
  QuickSortOption.oldestFirst: 'oldestFirst',
  QuickSortOption.questionIdAsc: 'questionIdAsc',
  QuickSortOption.questionIdDesc: 'questionIdDesc',
  QuickSortOption.difficultyAsc: 'difficultyAsc',
  QuickSortOption.difficultyDesc: 'difficultyDesc',
};

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.veryEasy: 'veryEasy',
  DifficultyLevel.easy: 'easy',
  DifficultyLevel.medium: 'medium',
  DifficultyLevel.hard: 'hard',
  DifficultyLevel.veryHard: 'veryHard',
};

const _$QuestionTypeEnumMap = {
  QuestionType.singleChoice: 'singleChoice',
  QuestionType.multipleChoice: 'multipleChoice',
  QuestionType.assertionReason: 'assertionReason',
  QuestionType.numerical: 'numerical',
};
