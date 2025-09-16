import 'package:flutter_test/flutter_test.dart';
import 'package:entrytestguru/features/questions/data/models/question_filter.dart';
import 'package:entrytestguru/features/questions/data/models/question_enums.dart';

void main() {
  group('QuestionFilter Model Tests', () {
    late QuestionFilter sampleFilter;

    setUp(() {
      sampleFilter = QuestionFilter(
        examCategories: ['ECAT', 'MCAT'],
        subjects: ['Physics', 'Chemistry'],
        topics: ['Kinematics', 'Organic Chemistry'],
        difficulties: [DifficultyLevel.medium, DifficultyLevel.hard],
        ardeProbabilities: [ArdeLevel.high, ArdeLevel.medium],
        minArdeFrequency: 3,
        minCreatedDate: DateTime(2024, 1, 1),
        maxCreatedDate: DateTime(2024, 12, 31),
        showWeakAreas: true,
        showUnattempted: false,
        showIncorrect: true,
        showBookmarked: true,
        searchQuery: 'kinematics',
        tags: ['physics', 'motion'],
        sortBy: QuestionSortBy.ardeProbability,
        sortDirection: SortDirection.descending,
        limit: 50,
        lastDocumentId: 'doc_123',
      );
    });

    test('should create QuestionFilter with valid data', () {
      expect(sampleFilter.examCategories, ['ECAT', 'MCAT']);
      expect(sampleFilter.subjects, ['Physics', 'Chemistry']);
      expect(sampleFilter.difficulties, [
        DifficultyLevel.medium,
        DifficultyLevel.hard,
      ]);
      expect(sampleFilter.ardeProbabilities, [
        ArdeLevel.high,
        ArdeLevel.medium,
      ]);
      expect(sampleFilter.searchQuery, 'kinematics');
      expect(sampleFilter.sortBy, QuestionSortBy.ardeProbability);
      expect(sampleFilter.sortDirection, SortDirection.descending);
    });

    test('should check if filter has active criteria', () {
      expect(sampleFilter.hasActiveFilters, true);

      final emptyFilter = QuestionFilter();
      expect(emptyFilter.hasActiveFilters, false);
    });

    test('should return active filter count', () {
      expect(sampleFilter.activeFilterCount, 8); // All the filters we set
    });

    test('should check if filter has search', () {
      expect(sampleFilter.hasSearch, true);

      final noSearchFilter = sampleFilter.copyWith(searchQuery: null);
      expect(noSearchFilter.hasSearch, false);
    });

    test('should check if filter has performance filters', () {
      expect(sampleFilter.hasPerformanceFilters, true);

      final noPerformanceFilter = sampleFilter.copyWith(
        showWeakAreas: false,
        showUnattempted: false,
        showIncorrect: false,
        showBookmarked: false,
      );
      expect(noPerformanceFilter.hasPerformanceFilters, false);
    });

    test('should check if filter has ARDE filters', () {
      expect(sampleFilter.hasArdeFilters, true);

      final noArdeFilter = sampleFilter.copyWith(
        ardeProbabilities: null,
        minArdeFrequency: null,
      );
      expect(noArdeFilter.hasArdeFilters, false);
    });

    test('should return description', () {
      final description = sampleFilter.description;
      expect(description, contains('Exam: ECAT, MCAT'));
      expect(description, contains('Subject: Physics, Chemistry'));
      expect(description, contains('Search: "kinematics"'));
    });

    test('should create filter by exam category', () {
      final filter = QuestionFilter.byExamCategory('ECAT');
      expect(filter.examCategories, ['ECAT']);
      expect(filter.sortBy, QuestionSortBy.ardeProbability);
      expect(filter.sortDirection, SortDirection.descending);
    });

    test('should create high ARDE questions filter', () {
      final filter = QuestionFilter.highArdeQuestions(
        examCategory: 'ECAT',
        subject: 'Physics',
      );
      expect(filter.examCategories, ['ECAT']);
      expect(filter.subjects, ['Physics']);
      expect(filter.ardeProbabilities, [ArdeLevel.high]);
      expect(filter.sortBy, QuestionSortBy.ardeProbability);
    });

    test('should create weak areas filter', () {
      final filter = QuestionFilter.weakAreas(
        examCategory: 'ECAT',
        subject: 'Physics',
      );
      expect(filter.examCategories, ['ECAT']);
      expect(filter.subjects, ['Physics']);
      expect(filter.showWeakAreas, true);
      expect(filter.sortBy, QuestionSortBy.accuracy);
      expect(filter.sortDirection, SortDirection.ascending);
    });

    test('should create bookmarked filter', () {
      final filter = QuestionFilter.bookmarked(
        examCategory: 'ECAT',
        subject: 'Physics',
      );
      expect(filter.examCategories, ['ECAT']);
      expect(filter.subjects, ['Physics']);
      expect(filter.showBookmarked, true);
      expect(filter.sortBy, QuestionSortBy.createdDate);
      expect(filter.sortDirection, SortDirection.descending);
    });

    test('should create search filter', () {
      final filter = QuestionFilter.search(
        'kinematics',
        examCategory: 'ECAT',
        subjects: ['Physics'],
      );
      expect(filter.searchQuery, 'kinematics');
      expect(filter.examCategories, ['ECAT']);
      expect(filter.subjects, ['Physics']);
      expect(filter.sortBy, QuestionSortBy.relevance);
    });

    test('should add exam category', () {
      final updatedFilter = sampleFilter.withExamCategory('NET');
      expect(updatedFilter.examCategories, contains('NET'));
    });

    test('should not add duplicate exam category', () {
      final updatedFilter = sampleFilter.withExamCategory('ECAT');
      expect(updatedFilter.examCategories?.length, 2); // Should remain 2
    });

    test('should remove exam category', () {
      final updatedFilter = sampleFilter.withoutExamCategory('ECAT');
      expect(updatedFilter.examCategories, ['MCAT']);
    });

    test('should add subject', () {
      final updatedFilter = sampleFilter.withSubject('Mathematics');
      expect(updatedFilter.subjects, contains('Mathematics'));
    });

    test('should remove subject', () {
      final updatedFilter = sampleFilter.withoutSubject('Physics');
      expect(updatedFilter.subjects, ['Chemistry']);
    });

    test('should add difficulty', () {
      final updatedFilter = sampleFilter.withDifficulty(DifficultyLevel.easy);
      expect(updatedFilter.difficulties, contains(DifficultyLevel.easy));
    });

    test('should remove difficulty', () {
      final updatedFilter = sampleFilter.withoutDifficulty(
        DifficultyLevel.medium,
      );
      expect(updatedFilter.difficulties, [DifficultyLevel.hard]);
    });

    test('should add ARDE probability', () {
      final updatedFilter = sampleFilter.withArdeProbability(ArdeLevel.low);
      expect(updatedFilter.ardeProbabilities, contains(ArdeLevel.low));
    });

    test('should remove ARDE probability', () {
      final updatedFilter = sampleFilter.withoutArdeProbability(ArdeLevel.high);
      expect(updatedFilter.ardeProbabilities, [ArdeLevel.medium]);
    });

    test('should clear all filters', () {
      final clearedFilter = sampleFilter.clearAll();
      expect(clearedFilter.hasActiveFilters, false);
      expect(clearedFilter.sortBy, sampleFilter.sortBy);
      expect(clearedFilter.sortDirection, sampleFilter.sortDirection);
    });

    test('should create next page filter', () {
      final nextPageFilter = sampleFilter.nextPage('new_doc_456');
      expect(nextPageFilter.lastDocumentId, 'new_doc_456');
    });

    test('should update sorting', () {
      final sortedFilter = sampleFilter.withSorting(
        QuestionSortBy.difficulty,
        SortDirection.ascending,
      );
      expect(sortedFilter.sortBy, QuestionSortBy.difficulty);
      expect(sortedFilter.sortDirection, SortDirection.ascending);
    });

    test('should serialize to JSON', () {
      final json = sampleFilter.toJson();
      expect(json['exam_categories'], ['ECAT', 'MCAT']);
      expect(json['subjects'], ['Physics', 'Chemistry']);
      expect(json['search_query'], 'kinematics');
      expect(json['sort_by'], 'arde_probability');
      expect(json['sort_direction'], 'desc');
      expect(json['limit'], 50);
    });

    test('should deserialize from JSON', () {
      final json = sampleFilter.toJson();
      final deserializedFilter = QuestionFilter.fromJson(json);

      expect(deserializedFilter.examCategories, sampleFilter.examCategories);
      expect(deserializedFilter.subjects, sampleFilter.subjects);
      expect(deserializedFilter.searchQuery, sampleFilter.searchQuery);
      expect(deserializedFilter.sortBy, sampleFilter.sortBy);
    });

    test('should handle null values in JSON', () {
      final minimalJson = {'sortDirection': 'ascending', 'limit': 20};
      final filter = QuestionFilter.fromJson(minimalJson);

      expect(filter.examCategories, null);
      expect(filter.subjects, null);
      expect(filter.searchQuery, null);
      expect(filter.sortDirection, SortDirection.ascending);
      expect(filter.limit, 20);
    });
  });

  group('QuestionFilterExtension Tests', () {
    late QuestionFilter filter;

    setUp(() {
      filter = QuestionFilter(
        sortBy: QuestionSortBy.ardeProbability,
        sortDirection: SortDirection.descending,
      );
    });

    test('should return sort field name', () {
      expect(filter.sortFieldName, 'arde_probability');

      final noSortFilter = QuestionFilter();
      expect(noSortFilter.sortFieldName, null);
    });

    test('should return sort direction name', () {
      expect(filter.sortDirectionName, 'desc');

      final ascendingFilter = filter.copyWith(
        sortDirection: SortDirection.ascending,
      );
      expect(ascendingFilter.sortDirectionName, 'asc');
    });

    test('should convert filter to API map', () {
      final apiMap = filter.toApiMap();
      expect(apiMap['sort_by'], 'arde_probability');
      expect(apiMap['sort_direction'], 'desc');
    });

    test('should handle complex filter in API map', () {
      final complexFilter = QuestionFilter(
        examCategories: ['ECAT'],
        subjects: ['Physics'],
        difficulties: [DifficultyLevel.medium],
        ardeProbabilities: [ArdeLevel.high],
        searchQuery: 'test query',
        showBookmarked: true,
        sortBy: QuestionSortBy.difficulty,
        sortDirection: SortDirection.ascending,
        limit: 25,
      );

      final apiMap = complexFilter.toApiMap();
      expect(apiMap['exam_categories'], ['ECAT']);
      expect(apiMap['subjects'], ['Physics']);
      expect(apiMap['difficulties'], ['medium']);
      expect(apiMap['arde_probabilities'], ['high']);
      expect(apiMap['search_query'], 'test query');
      expect(apiMap['show_bookmarked'], true);
      expect(apiMap['sort_by'], 'difficulty');
      expect(apiMap['sort_direction'], 'asc');
      expect(apiMap['limit'], 25);
    });
  });
}
