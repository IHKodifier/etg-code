import 'package:freezed_annotation/freezed_annotation.dart';
import 'question_enums.dart';
import 'question_option.dart';
import 'question_performance_stats.dart';
import 'question_attempt.dart';

part 'question.freezed.dart';
part 'question.g.dart';

/// Main Question model representing a complete question with all its data
/// Compatible with backend Python Question model for seamless API integration
@freezed
class Question with _$Question {
  const Question._();

  const factory Question({
    // Identity & Metadata
    required String id,
    required String questionId,
    required String examCategory,
    required String subject,
    required String topic,
    String? subTopic,

    // Content
    required String questionText,
    String? questionImageUrl,
    String? questionLatex,

    // Options & Answer
    required List<QuestionOption> options,
    required List<String> correctAnswer,
    @Default(QuestionType.singleChoice) QuestionType questionType,

    // Explanations & Resources
    required String explanationText,
    String? explanationVideoUrl,
    List<String>? explanationSteps,
    List<String>? references,

    // ARDE Intelligence (Core Differentiator)
    required ArdeLevel ardeProbability,
    @Default(0) int ardeFrequency,
    List<int>? ardeAppearanceYears,
    String? ardeNotes,
    String? ardeContext,

    // Difficulty & Performance
    required DifficultyLevel difficulty,
    @Default(60) int estimatedTimeSeconds,

    // Global Performance Analytics
    required QuestionPerformanceStats globalStats,

    // Search & Discovery
    @Default([]) List<String> tags,
    List<String>? relatedQuestions,

    // Administrative
    required DateTime createdAt,
    required DateTime updatedAt,
    required String createdBy,
    @Default(true) bool? isActive,
    @Default(1) int? version,
    String? status,

    // User-specific (populated at runtime)
    @Default(false) bool isBookmarked,
    String? userNotes,
    QuestionAttempt? lastAttempt,
  }) = _Question;

  /// Creates Question from JSON
  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  /// Returns the primary subject area
  String get primarySubject => subject;

  /// Returns the full topic path
  String get fullTopicPath {
    if (subTopic != null && subTopic!.isNotEmpty) {
      return '$topic > $subTopic';
    }
    return topic;
  }

  /// Returns the question type as a readable string
  String get questionTypeDisplay {
    switch (questionType) {
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

  /// Returns the difficulty level as a readable string
  String get difficultyDisplay {
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

  /// Returns the ARDE probability as a readable string
  String get ardeProbabilityDisplay {
    switch (ardeProbability) {
      case ArdeLevel.high:
        return 'High Probability';
      case ArdeLevel.medium:
        return 'Medium Probability';
      case ArdeLevel.low:
        return 'Low Probability';
    }
  }

  /// Returns the ARDE probability as a percentage string
  String get ardeProbabilityPercentage {
    switch (ardeProbability) {
      case ArdeLevel.high:
        return '70%+';
      case ArdeLevel.medium:
        return '30-70%';
      case ArdeLevel.low:
        return '<30%';
    }
  }

  /// Checks if the question has visual content
  bool get hasVisualContent {
    return (questionImageUrl != null && questionImageUrl!.isNotEmpty) ||
        (questionLatex != null && questionLatex!.isNotEmpty) ||
        options.any((option) => option.hasVisualContent);
  }

  /// Checks if the question has multimedia content
  bool get hasMultimediaContent {
    return (explanationVideoUrl != null && explanationVideoUrl!.isNotEmpty) ||
        hasVisualContent;
  }

  /// Returns the estimated time formatted as a string
  String get estimatedTimeFormatted {
    if (estimatedTimeSeconds < 60) {
      return '${estimatedTimeSeconds}s';
    }
    final minutes = (estimatedTimeSeconds / 60).floor();
    final seconds = (estimatedTimeSeconds % 60);
    return '${minutes}m ${seconds}s';
  }

  /// Returns the correct options
  List<QuestionOption> get correctOptions {
    return options
        .where((option) => correctAnswer.contains(option.id))
        .toList();
  }

  /// Returns the incorrect options
  List<QuestionOption> get incorrectOptions {
    return options
        .where((option) => !correctAnswer.contains(option.id))
        .toList();
  }

  /// Checks if the question is single choice
  bool get isSingleChoice => questionType == QuestionType.singleChoice;

  /// Checks if the question is multiple choice
  bool get isMultipleChoice => questionType == QuestionType.multipleChoice;

  /// Returns the number of correct answers expected
  int get expectedCorrectAnswers => correctAnswer.length;

  /// Checks if the question structure is valid
  bool get isValid {
    return questionText.isNotEmpty &&
        options.length >= 2 &&
        correctAnswer.isNotEmpty &&
        correctAnswer.every(
          (answer) => options.any((option) => option.id == answer),
        );
  }

  /// Returns a search-friendly text combining question and options
  String get searchableText {
    final buffer = StringBuffer(questionText);
    for (final option in options) {
      buffer.write(' ${option.text}');
    }
    if (explanationText.isNotEmpty) {
      buffer.write(' ${explanationText}');
    }
    return buffer.toString().toLowerCase();
  }

  /// Returns tags as a comma-separated string
  String get tagsDisplay {
    return tags.join(', ');
  }

  /// Checks if the question matches the given search query
  bool matchesSearch(String query) {
    if (query.isEmpty) return true;
    final searchQuery = query.toLowerCase();
    return searchableText.contains(searchQuery) ||
        tags.any((tag) => tag.toLowerCase().contains(searchQuery)) ||
        subject.toLowerCase().contains(searchQuery) ||
        topic.toLowerCase().contains(searchQuery);
  }

  /// Returns the question's performance rating
  String get performanceRating {
    final accuracy = globalStats.globalAccuracy;
    if (accuracy >= 0.8) return 'Excellent';
    if (accuracy >= 0.6) return 'Good';
    if (accuracy >= 0.4) return 'Average';
    return 'Needs Review';
  }

  /// Checks if the question has been attempted by the user
  bool get hasBeenAttempted => lastAttempt != null;

  /// Returns the user's accuracy on this question
  double? get userAccuracy {
    if (lastAttempt == null) return null;
    return lastAttempt!.isCorrect ? 1.0 : 0.0;
  }

  /// Returns the user's last attempt time formatted
  String? get lastAttemptTimeFormatted {
    return lastAttempt?.timeSpentFormatted;
  }

  /// Creates a copy with updated user-specific data
  Question copyWithUserData({
    bool? isBookmarked,
    String? userNotes,
    QuestionAttempt? lastAttempt,
  }) {
    return copyWith(
      isBookmarked: isBookmarked ?? this.isBookmarked,
      userNotes: userNotes ?? this.userNotes,
      lastAttempt: lastAttempt ?? this.lastAttempt,
    );
  }
}

/// Extension methods for working with lists of Question
extension QuestionListExtension on List<Question> {
  /// Returns questions sorted by ARDE probability (high first)
  List<Question> get sortedByArdeProbability {
    return [...this]..sort((a, b) {
      final ardeOrder = {'high': 3, 'medium': 2, 'low': 1};
      final aOrder = ardeOrder[a.ardeProbability.name] ?? 0;
      final bOrder = ardeOrder[b.ardeProbability.name] ?? 0;
      return bOrder.compareTo(aOrder);
    });
  }

  /// Returns questions sorted by difficulty
  List<Question> get sortedByDifficulty {
    return [...this]
      ..sort((a, b) => a.difficulty.index.compareTo(b.difficulty.index));
  }

  /// Returns questions sorted by accuracy (lowest first - needs improvement)
  List<Question> get sortedByAccuracy {
    return [...this]..sort(
      (a, b) =>
          a.globalStats.globalAccuracy.compareTo(b.globalStats.globalAccuracy),
    );
  }

  /// Returns questions filtered by exam category
  List<Question> filterByExamCategory(String examCategory) {
    return where((question) => question.examCategory == examCategory).toList();
  }

  /// Returns questions filtered by subject
  List<Question> filterBySubject(String subject) {
    return where((question) => question.subject == subject).toList();
  }

  /// Returns questions filtered by ARDE probability
  List<Question> filterByArdeProbability(ArdeLevel ardeLevel) {
    return where((question) => question.ardeProbability == ardeLevel).toList();
  }

  /// Returns questions filtered by difficulty
  List<Question> filterByDifficulty(DifficultyLevel difficulty) {
    return where((question) => question.difficulty == difficulty).toList();
  }

  /// Returns bookmarked questions
  List<Question> get bookmarked {
    return where((question) => question.isBookmarked).toList();
  }

  /// Returns questions that match the search query
  List<Question> search(String query) {
    if (query.isEmpty) return this;
    return where((question) => question.matchesSearch(query)).toList();
  }

  /// Returns unique exam categories
  List<String> get uniqueExamCategories {
    return map((question) => question.examCategory).toSet().toList()..sort();
  }

  /// Returns unique subjects
  List<String> get uniqueSubjects {
    return map((question) => question.subject).toSet().toList()..sort();
  }

  /// Returns unique topics
  List<String> get uniqueTopics {
    return map((question) => question.topic).toSet().toList()..sort();
  }

  /// Returns the average accuracy across all questions
  double get averageAccuracy {
    if (isEmpty) return 0.0;
    final totalAccuracy = fold<double>(
      0.0,
      (sum, question) => sum + question.globalStats.globalAccuracy,
    );
    return totalAccuracy / length;
  }

  /// Returns the average difficulty across all questions
  double get averageDifficulty {
    if (isEmpty) return 0.0;
    final totalDifficulty = fold<double>(
      0.0,
      (sum, question) => sum + question.globalStats.calculatedDifficulty,
    );
    return totalDifficulty / length;
  }

  /// Groups questions by subject
  Map<String, List<Question>> get groupedBySubject {
    final grouped = <String, List<Question>>{};
    for (final question in this) {
      grouped.putIfAbsent(question.subject, () => []).add(question);
    }
    return grouped;
  }

  /// Groups questions by ARDE probability
  Map<ArdeLevel, List<Question>> get groupedByArdeProbability {
    final grouped = <ArdeLevel, List<Question>>{};
    for (final question in this) {
      grouped.putIfAbsent(question.ardeProbability, () => []).add(question);
    }
    return grouped;
  }
}
