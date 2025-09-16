import 'package:freezed_annotation/freezed_annotation.dart';
import 'question_enums.dart';

part 'question_filter.freezed.dart';
part 'question_filter.g.dart';

/// Filter criteria for searching and filtering questions
/// Supports complex queries with multiple criteria
@freezed
class QuestionFilter with _$QuestionFilter {
  const QuestionFilter._();

  const factory QuestionFilter({
    // Basic Filters
    List<String>? examCategories,
    List<String>? subjects,
    List<String>? topics,
    List<DifficultyLevel>? difficulties,
    List<ArdeLevel>? ardeProbabilities,

    // Advanced Filters
    int? minArdeFrequency,
    DateTime? minCreatedDate,
    DateTime? maxCreatedDate,

    // Performance-based Filters
    bool? showWeakAreas,
    bool? showUnattempted,
    bool? showIncorrect,
    bool? showBookmarked,

    // Search
    String? searchQuery,
    List<String>? tags,

    // Sorting
    QuestionSortBy? sortBy,
    @Default(SortDirection.descending) SortDirection? sortDirection,

    // Pagination
    @Default(20) int? limit,
    String? lastDocumentId,
  }) = _QuestionFilter;

  /// Creates QuestionFilter from JSON
  factory QuestionFilter.fromJson(Map<String, dynamic> json) =>
      _$QuestionFilterFromJson(json);

  /// Creates a basic filter for a specific exam category
  factory QuestionFilter.byExamCategory(String examCategory) {
    return QuestionFilter(
      examCategories: [examCategory],
      sortBy: QuestionSortBy.ardeProbability,
      sortDirection: SortDirection.descending,
    );
  }

  /// Creates a filter for high-probability ARDE questions
  factory QuestionFilter.highArdeQuestions({
    String? examCategory,
    String? subject,
  }) {
    return QuestionFilter(
      examCategories: examCategory != null ? [examCategory] : null,
      subjects: subject != null ? [subject] : null,
      ardeProbabilities: [ArdeLevel.high],
      sortBy: QuestionSortBy.ardeProbability,
      sortDirection: SortDirection.descending,
    );
  }

  /// Creates a filter for weak areas (low accuracy)
  factory QuestionFilter.weakAreas({String? examCategory, String? subject}) {
    return QuestionFilter(
      examCategories: examCategory != null ? [examCategory] : null,
      subjects: subject != null ? [subject] : null,
      showWeakAreas: true,
      sortBy: QuestionSortBy.accuracy,
      sortDirection: SortDirection.ascending,
    );
  }

  /// Creates a filter for bookmarked questions
  factory QuestionFilter.bookmarked({String? examCategory, String? subject}) {
    return QuestionFilter(
      examCategories: examCategory != null ? [examCategory] : null,
      subjects: subject != null ? [subject] : null,
      showBookmarked: true,
      sortBy: QuestionSortBy.createdDate,
      sortDirection: SortDirection.descending,
    );
  }

  /// Creates a search filter
  factory QuestionFilter.search(
    String query, {
    String? examCategory,
    List<String>? subjects,
  }) {
    return QuestionFilter(
      examCategories: examCategory != null ? [examCategory] : null,
      subjects: subjects,
      searchQuery: query,
      sortBy: QuestionSortBy.relevance,
      sortDirection: SortDirection.descending,
    );
  }

  /// Checks if the filter has any active criteria
  bool get hasActiveFilters {
    return (examCategories?.isNotEmpty ?? false) ||
        (subjects?.isNotEmpty ?? false) ||
        (topics?.isNotEmpty ?? false) ||
        (difficulties?.isNotEmpty ?? false) ||
        (ardeProbabilities?.isNotEmpty ?? false) ||
        (minArdeFrequency != null) ||
        (minCreatedDate != null) ||
        (maxCreatedDate != null) ||
        (showWeakAreas ?? false) ||
        (showUnattempted ?? false) ||
        (showIncorrect ?? false) ||
        (showBookmarked ?? false) ||
        (searchQuery?.isNotEmpty ?? false) ||
        (tags?.isNotEmpty ?? false);
  }

  /// Returns the number of active filter criteria
  int get activeFilterCount {
    int count = 0;
    if (examCategories?.isNotEmpty ?? false) count++;
    if (subjects?.isNotEmpty ?? false) count++;
    if (topics?.isNotEmpty ?? false) count++;
    if (difficulties?.isNotEmpty ?? false) count++;
    if (ardeProbabilities?.isNotEmpty ?? false) count++;
    if (minArdeFrequency != null) count++;
    if (minCreatedDate != null) count++;
    if (maxCreatedDate != null) count++;
    if (showWeakAreas ?? false) count++;
    if (showUnattempted ?? false) count++;
    if (showIncorrect ?? false) count++;
    if (showBookmarked ?? false) count++;
    if (searchQuery?.isNotEmpty ?? false) count++;
    if (tags?.isNotEmpty ?? false) count++;
    return count;
  }

  /// Checks if the filter includes search functionality
  bool get hasSearch => searchQuery?.isNotEmpty ?? false;

  /// Checks if the filter includes performance-based criteria
  bool get hasPerformanceFilters {
    return (showWeakAreas ?? false) ||
        (showUnattempted ?? false) ||
        (showIncorrect ?? false) ||
        (showBookmarked ?? false);
  }

  /// Checks if the filter includes ARDE-based criteria
  bool get hasArdeFilters {
    return (ardeProbabilities?.isNotEmpty ?? false) ||
        (minArdeFrequency != null);
  }

  /// Returns a human-readable description of the filter
  String get description {
    if (!hasActiveFilters) return 'All questions';

    final parts = <String>[];

    if (examCategories?.isNotEmpty ?? false) {
      parts.add('Exam: ${examCategories!.join(', ')}');
    }

    if (subjects?.isNotEmpty ?? false) {
      parts.add('Subject: ${subjects!.join(', ')}');
    }

    if (topics?.isNotEmpty ?? false) {
      parts.add('Topic: ${topics!.join(', ')}');
    }

    if (difficulties?.isNotEmpty ?? false) {
      final difficultyNames = difficulties!.map((d) {
        switch (d) {
          case DifficultyLevel.veryEasy:
            return 'Very Easy';
          case DifficultyLevel.easy:
            return 'Easy';
          case DifficultyLevel.medium:
            return 'Medium';
          case DifficultyLevel.hard:
            return 'Hard';
          case DifficultyLevel.veryHard:
            return 'Very Hard';
        }
      }).toList();
      parts.add('Difficulty: ${difficultyNames.join(', ')}');
    }

    if (ardeProbabilities?.isNotEmpty ?? false) {
      final ardeNames = ardeProbabilities!.map((a) {
        switch (a) {
          case ArdeLevel.high:
            return 'High';
          case ArdeLevel.medium:
            return 'Medium';
          case ArdeLevel.low:
            return 'Low';
        }
      }).toList();
      parts.add('ARDE: ${ardeNames.join(', ')}');
    }

    if (showBookmarked ?? false) {
      parts.add('Bookmarked');
    }

    if (showWeakAreas ?? false) {
      parts.add('Weak Areas');
    }

    if (searchQuery?.isNotEmpty ?? false) {
      parts.add('Search: "$searchQuery"');
    }

    return parts.isEmpty ? 'All questions' : parts.join(' • ');
  }

  /// Creates a copy with updated search query
  QuestionFilter withSearch(String query) {
    return copyWith(searchQuery: query);
  }

  /// Creates a copy with added exam category
  QuestionFilter withExamCategory(String examCategory) {
    final current = examCategories ?? [];
    if (current.contains(examCategory)) return this;
    return copyWith(examCategories: [...current, examCategory]);
  }

  /// Creates a copy with removed exam category
  QuestionFilter withoutExamCategory(String examCategory) {
    final current = examCategories ?? [];
    return copyWith(
      examCategories: current.where((e) => e != examCategory).toList(),
    );
  }

  /// Creates a copy with added subject
  QuestionFilter withSubject(String subject) {
    final current = subjects ?? [];
    if (current.contains(subject)) return this;
    return copyWith(subjects: [...current, subject]);
  }

  /// Creates a copy with removed subject
  QuestionFilter withoutSubject(String subject) {
    final current = subjects ?? [];
    return copyWith(subjects: current.where((s) => s != subject).toList());
  }

  /// Creates a copy with added difficulty
  QuestionFilter withDifficulty(DifficultyLevel difficulty) {
    final current = difficulties ?? [];
    if (current.contains(difficulty)) return this;
    return copyWith(difficulties: [...current, difficulty]);
  }

  /// Creates a copy with removed difficulty
  QuestionFilter withoutDifficulty(DifficultyLevel difficulty) {
    final current = difficulties ?? [];
    return copyWith(
      difficulties: current.where((d) => d != difficulty).toList(),
    );
  }

  /// Creates a copy with added ARDE probability
  QuestionFilter withArdeProbability(ArdeLevel ardeLevel) {
    final current = ardeProbabilities ?? [];
    if (current.contains(ardeLevel)) return this;
    return copyWith(ardeProbabilities: [...current, ardeLevel]);
  }

  /// Creates a copy with removed ARDE probability
  QuestionFilter withoutArdeProbability(ArdeLevel ardeLevel) {
    final current = ardeProbabilities ?? [];
    return copyWith(
      ardeProbabilities: current.where((a) => a != ardeLevel).toList(),
    );
  }

  /// Creates a copy with cleared all filters
  QuestionFilter clearAll() {
    return QuestionFilter(
      sortBy: sortBy,
      sortDirection: sortDirection,
      limit: limit,
    );
  }

  /// Creates a copy for the next page of results
  QuestionFilter nextPage(String lastDocId) {
    return copyWith(lastDocumentId: lastDocId);
  }

  /// Creates a copy with updated sorting
  QuestionFilter withSorting(QuestionSortBy sortBy, SortDirection direction) {
    return copyWith(sortBy: sortBy, sortDirection: direction);
  }
}

/// Extension methods for working with QuestionFilter
extension QuestionFilterExtension on QuestionFilter {
  /// Returns the sort field name for API calls
  String? get sortFieldName {
    if (sortBy == null) return null;

    switch (sortBy!) {
      case QuestionSortBy.relevance:
        return 'relevance';
      case QuestionSortBy.ardeProbability:
        return 'arde_probability';
      case QuestionSortBy.difficulty:
        return 'difficulty';
      case QuestionSortBy.accuracy:
        return 'accuracy';
      case QuestionSortBy.createdDate:
        return 'created_at';
      case QuestionSortBy.popularity:
        return 'popularity';
    }
  }

  /// Returns the sort direction as a string
  String get sortDirectionName {
    return sortDirection == SortDirection.ascending ? 'asc' : 'desc';
  }

  /// Converts the filter to a map for API calls
  Map<String, dynamic> toApiMap() {
    final map = <String, dynamic>{};

    if (examCategories?.isNotEmpty ?? false) {
      map['exam_categories'] = examCategories;
    }

    if (subjects?.isNotEmpty ?? false) {
      map['subjects'] = subjects;
    }

    if (topics?.isNotEmpty ?? false) {
      map['topics'] = topics;
    }

    if (difficulties?.isNotEmpty ?? false) {
      map['difficulties'] = difficulties?.map((d) => d.name).toList();
    }

    if (ardeProbabilities?.isNotEmpty ?? false) {
      map['arde_probabilities'] = ardeProbabilities
          ?.map((a) => a.name)
          .toList();
    }

    if (minArdeFrequency != null) {
      map['min_arde_frequency'] = minArdeFrequency;
    }

    if (minCreatedDate != null) {
      map['min_created_date'] = minCreatedDate!.toIso8601String();
    }

    if (maxCreatedDate != null) {
      map['max_created_date'] = maxCreatedDate!.toIso8601String();
    }

    if (showWeakAreas ?? false) {
      map['show_weak_areas'] = true;
    }

    if (showUnattempted ?? false) {
      map['show_unattempted'] = true;
    }

    if (showIncorrect ?? false) {
      map['show_incorrect'] = true;
    }

    if (showBookmarked ?? false) {
      map['show_bookmarked'] = true;
    }

    if (searchQuery?.isNotEmpty ?? false) {
      map['search_query'] = searchQuery;
    }

    if (tags?.isNotEmpty ?? false) {
      map['tags'] = tags;
    }

    if (sortFieldName != null) {
      map['sort_by'] = sortFieldName;
      map['sort_direction'] = sortDirectionName;
    }

    if (limit != null) {
      map['limit'] = limit;
    }

    if (lastDocumentId?.isNotEmpty ?? false) {
      map['last_document_id'] = lastDocumentId;
    }

    return map;
  }
}
