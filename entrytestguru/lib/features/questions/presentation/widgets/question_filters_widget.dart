import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/question_enums.dart';
import '../../data/models/question_filter.dart';
import '../providers/present_question_provider.dart';

/// Widget for quick filtering of questions
class QuestionFiltersWidget extends ConsumerStatefulWidget {
  const QuestionFiltersWidget({super.key});

  @override
  ConsumerState<QuestionFiltersWidget> createState() =>
      _QuestionFiltersWidgetState();
}

class _QuestionFiltersWidgetState extends ConsumerState<QuestionFiltersWidget> {
  final TextEditingController _questionIdController = TextEditingController();
  QuickSortOption _selectedSortOption = QuickSortOption.newestFirst;
  final Set<DifficultyLevel> _selectedDifficulties = {};
  final Set<QuestionType> _selectedQuestionTypes = {};
  final Set<String> _selectedExamCategories = {};
  final Set<String> _selectedSubjects = {};

  @override
  void dispose() {
    _questionIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Sort Row
          Row(
            children: [
              // Question ID Search
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _questionIdController,
                  decoration: InputDecoration(
                    hintText: 'Search by Question ID',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  onSubmitted: (_) => _onFiltersChanged(),
                ),
              ),
              const SizedBox(width: 16),

              // Sort Dropdown
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<QuickSortOption>(
                  value: _selectedSortOption,
                  decoration: InputDecoration(
                    labelText: 'Sort by',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  items: QuickSortOption.values.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(_getSortOptionDisplayName(option)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedSortOption = value);
                      _onFiltersChanged();
                    }
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Filter Chips - Grouped by type
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Difficulty Filters
              if (DifficultyLevel.values.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Difficulty',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: DifficultyLevel.values
                      .map(
                        (difficulty) => FilterChip(
                          label: Text(_getDifficultyDisplayName(difficulty)),
                          selected: _selectedDifficulties.contains(difficulty),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedDifficulties.add(difficulty);
                              } else {
                                _selectedDifficulties.remove(difficulty);
                              }
                            });
                            _onFiltersChanged();
                          },
                        ),
                      )
                      .toList(),
                ),
              ],

              // Question Type Filters
              if (QuestionType.values.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Question Type',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: QuestionType.values
                      .map(
                        (type) => FilterChip(
                          label: Text(_getQuestionTypeDisplayName(type)),
                          selected: _selectedQuestionTypes.contains(type),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedQuestionTypes.add(type);
                              } else {
                                _selectedQuestionTypes.remove(type);
                              }
                            });
                            _onFiltersChanged();
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
            ],
          ),

          // Clear Filters Button
          if (_hasActiveFilters)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextButton.icon(
                onPressed: _clearAllFilters,
                icon: const Icon(Icons.clear_all),
                label: const Text('Clear All Filters'),
              ),
            ),
        ],
      ),
    );
  }

  bool get _hasActiveFilters {
    return _questionIdController.text.isNotEmpty ||
        _selectedSortOption != QuickSortOption.newestFirst ||
        _selectedDifficulties.isNotEmpty ||
        _selectedQuestionTypes.isNotEmpty ||
        _selectedExamCategories.isNotEmpty ||
        _selectedSubjects.isNotEmpty;
  }

  void _onFiltersChanged() {
    // Create filter based on current selections
    final filter = QuestionFilter(
      searchQuery: _questionIdController.text.isNotEmpty
          ? _questionIdController.text
          : null,
      difficulties: _selectedDifficulties.isNotEmpty
          ? _selectedDifficulties.toList()
          : null,
      questionTypes: _selectedQuestionTypes.isNotEmpty
          ? _selectedQuestionTypes.map((type) => type.name).toList()
          : null,
    );

    // Apply sorting
    QuestionSortBy sortBy;
    SortDirection sortDirection;

    switch (_selectedSortOption) {
      case QuickSortOption.newestFirst:
        sortBy = QuestionSortBy.createdDate;
        sortDirection = SortDirection.descending;
        break;
      case QuickSortOption.oldestFirst:
        sortBy = QuestionSortBy.createdDate;
        sortDirection = SortDirection.ascending;
        break;
      case QuickSortOption.difficultyAsc:
        sortBy = QuestionSortBy.difficulty;
        sortDirection = SortDirection.ascending;
        break;
      case QuickSortOption.difficultyDesc:
        sortBy = QuestionSortBy.difficulty;
        sortDirection = SortDirection.descending;
        break;
      default:
        sortBy = QuestionSortBy.createdDate;
        sortDirection = SortDirection.descending;
    }

    final sortedFilter = filter.copyWith(
      sortBy: sortBy,
      sortDirection: sortDirection,
    );

    // Apply the filter
    ref
        .read(presentQuestionNotifierProvider.notifier)
        .loadQuestions(sortedFilter);
  }

  void _clearAllFilters() {
    setState(() {
      _questionIdController.clear();
      _selectedSortOption = QuickSortOption.newestFirst;
      _selectedDifficulties.clear();
      _selectedQuestionTypes.clear();
      _selectedExamCategories.clear();
      _selectedSubjects.clear();
    });
    _onFiltersChanged();
  }

  String _getSortOptionDisplayName(QuickSortOption option) {
    switch (option) {
      case QuickSortOption.newestFirst:
        return 'Newest First';
      case QuickSortOption.oldestFirst:
        return 'Oldest First';
      case QuickSortOption.questionIdAsc:
        return 'Question ID (Low to High)';
      case QuickSortOption.questionIdDesc:
        return 'Question ID (High to Low)';
      case QuickSortOption.difficultyAsc:
        return 'Difficulty (Easy to Hard)';
      case QuickSortOption.difficultyDesc:
        return 'Difficulty (Hard to Easy)';
    }
  }

  String _getDifficultyDisplayName(DifficultyLevel difficulty) {
    switch (difficulty) {
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
  }

  String _getQuestionTypeDisplayName(QuestionType type) {
    switch (type) {
      case QuestionType.singleChoice:
        return 'Single Choice';
      case QuestionType.multipleChoice:
        return 'Multiple Choice';
      case QuestionType.assertionReason:
        return 'Assertion-Reason';
      case QuestionType.numerical:
        return 'Numerical';
    }
  }
}
