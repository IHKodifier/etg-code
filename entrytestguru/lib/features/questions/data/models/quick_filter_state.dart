import 'package:freezed_annotation/freezed_annotation.dart';
import 'question_enums.dart';

part 'quick_filter_state.freezed.dart';
part 'quick_filter_state.g.dart';

/// State for quick filtering of questions
/// Holds the current filter selections for the quick filter widget
@freezed
class QuickFilterState with _$QuickFilterState {
  const QuickFilterState._();

  const factory QuickFilterState({
    /// Search query for question ID
    String? searchQuery,

    /// Selected sort option
    @Default(QuickSortOption.newestFirst) QuickSortOption sortOption,

    /// Selected difficulty levels
    @Default(<DifficultyLevel>{}) Set<DifficultyLevel> selectedDifficulties,

    /// Selected question types
    @Default(<QuestionType>{}) Set<QuestionType> selectedQuestionTypes,

    /// Selected exam categories
    @Default(<String>{}) Set<String> selectedExamCategories,

    /// Selected subjects
    @Default(<String>{}) Set<String> selectedSubjects,
  }) = _QuickFilterState;

  /// Creates QuickFilterState from JSON
  factory QuickFilterState.fromJson(Map<String, dynamic> json) =>
      _$QuickFilterStateFromJson(json);

  /// Checks if any filters are active
  bool get hasActiveFilters {
    return (searchQuery?.isNotEmpty ?? false) ||
        sortOption != QuickSortOption.newestFirst ||
        selectedDifficulties.isNotEmpty ||
        selectedQuestionTypes.isNotEmpty ||
        selectedExamCategories.isNotEmpty ||
        selectedSubjects.isNotEmpty;
  }

  /// Creates a copy with cleared filters
  QuickFilterState clearAll() {
    return copyWith(
      searchQuery: null,
      sortOption: QuickSortOption.newestFirst,
      selectedDifficulties: const <DifficultyLevel>{},
      selectedQuestionTypes: const <QuestionType>{},
      selectedExamCategories: const <String>{},
      selectedSubjects: const <String>{},
    );
  }

  /// Creates a copy with updated search query
  QuickFilterState withSearchQuery(String? query) {
    return copyWith(searchQuery: query);
  }

  /// Creates a copy with updated sort option
  QuickFilterState withSortOption(QuickSortOption option) {
    return copyWith(sortOption: option);
  }

  /// Creates a copy with added difficulty
  QuickFilterState withDifficulty(DifficultyLevel difficulty) {
    return copyWith(
      selectedDifficulties: {...selectedDifficulties, difficulty},
    );
  }

  /// Creates a copy with removed difficulty
  QuickFilterState withoutDifficulty(DifficultyLevel difficulty) {
    return copyWith(
      selectedDifficulties: selectedDifficulties
          .where((d) => d != difficulty)
          .toSet(),
    );
  }

  /// Creates a copy with added question type
  QuickFilterState withQuestionType(QuestionType type) {
    return copyWith(selectedQuestionTypes: {...selectedQuestionTypes, type});
  }

  /// Creates a copy with removed question type
  QuickFilterState withoutQuestionType(QuestionType type) {
    return copyWith(
      selectedQuestionTypes: selectedQuestionTypes
          .where((t) => t != type)
          .toSet(),
    );
  }

  /// Creates a copy with added exam category
  QuickFilterState withExamCategory(String category) {
    return copyWith(
      selectedExamCategories: {...selectedExamCategories, category},
    );
  }

  /// Creates a copy with removed exam category
  QuickFilterState withoutExamCategory(String category) {
    return copyWith(
      selectedExamCategories: selectedExamCategories
          .where((c) => c != category)
          .toSet(),
    );
  }

  /// Creates a copy with added subject
  QuickFilterState withSubject(String subject) {
    return copyWith(selectedSubjects: {...selectedSubjects, subject});
  }

  /// Creates a copy with removed subject
  QuickFilterState withoutSubject(String subject) {
    return copyWith(
      selectedSubjects: selectedSubjects.where((s) => s != subject).toSet(),
    );
  }
}
