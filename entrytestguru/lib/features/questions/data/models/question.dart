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
@JsonSerializable()
class Question with _$Question {
  const Question._();

  const factory Question({
    // Identity & Metadata
    required String id,
    required int questionId, // Changed from String to int
    required String examCategory,
    required String subject,
    required String topic,
    String? subTopic,

    // Content
    required String questionText,
    List<String>? questionImageUrls, // Multiple image URLs
    List<String>? questionLatex, // Multiple LaTeX expressions
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
    required double ardeProbability, // Changed from ArdeLevel enum to double
    @Default(0) int ardeFrequency,
    List<int>? ardeAppearanceYears,
    String? ardeNotes,
    String? ardeContext,

    // Difficulty & Performance
    required DifficultyLevel difficulty,
    @Default(60) int estimatedTimeSeconds,

    // Performance stats removed - now calculated from question_attempts collection

    // Search & Discovery
    @Default([]) List<String> tags,
    List<String>? relatedQuestions,

    // Administrative
    required DateTime createdAt,
    required DateTime updatedAt,
    required String createdBy,
    String? createdByName,
    @Default(true) bool? isActive,
    @Default(1) int? version,
    String? status,

    // Approval workflow fields
    @JsonKey(name: 'approval_status') @Default('pending') String approvalStatus,
    @JsonKey(name: 'reviewer_id') String? reviewerId,
    @JsonKey(name: 'reviewer_name') String? reviewerName,
    @JsonKey(name: 'review_comments') String? reviewComments,
    @JsonKey(name: 'submitted_at') required DateTime submittedAt,
    @JsonKey(name: 'reviewed_at') DateTime? reviewedAt,
    @JsonKey(name: 'approved_at') DateTime? approvedAt,

    // User-specific (populated at runtime)
    @Default(false) bool isBookmarked,
    String? userNotes,
    QuestionAttempt? lastAttempt,
  }) = _Question;

  /// Creates Question from JSON
  factory Question.fromJson(Map<String, dynamic> json) {
    // Handle backward compatibility for correctAnswer field
    if (json['correctAnswer'] is String) {
      // Convert string to list for backward compatibility
      json = Map<String, dynamic>.from(json);
      json['correctAnswer'] = [json['correctAnswer'] as String];
    }

    // Handle questionId field - convert string to int if necessary
    json = Map<String, dynamic>.from(json);
    if (json['questionId'] is String) {
      final questionIdStr = json['questionId'] as String;
      // Try to parse as int, fallback to hash code for string IDs
      final parsedId = int.tryParse(questionIdStr);
      if (parsedId != null) {
        json['questionId'] = parsedId;
      } else {
        // For string IDs like "unknown_123", use hash code as fallback
        json['questionId'] = questionIdStr.hashCode.abs();
      }
    }

    // Handle null values for boolean fields that have defaults
    if (json['isBookmarked'] == null) {
      json['isBookmarked'] = false;
    }

    return _$QuestionFromJson(json);
  }

  /// Converts Question to JSON
  Map<String, dynamic> toJson() => _$QuestionToJson(this);

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
    if (ardeProbability >= 0.7) {
      return 'High Probability';
    } else if (ardeProbability >= 0.3) {
      return 'Medium Probability';
    } else {
      return 'Low Probability';
    }
  }

  /// Returns the ARDE probability as a percentage string
  String get ardeProbabilityPercentage {
    if (ardeProbability >= 0.7) {
      return '70%+';
    } else if (ardeProbability >= 0.3) {
      return '30-70%';
    } else {
      return '<30%';
    }
  }

  /// Checks if the question has visual content
  bool get hasVisualContent {
    return (questionImageUrls != null && questionImageUrls!.isNotEmpty) ||
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

  /// Returns the question's performance rating (placeholder - will be calculated from attempts)
  String get performanceRating {
    // TODO: Calculate from question_attempts collection
    // For now, return a default rating
    return 'Not Available';
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

  /// Returns the ARDE level based on probability
  ArdeLevel get ardeLevel {
    if (ardeProbability >= 0.7) return ArdeLevel.high;
    if (ardeProbability >= 0.3) return ArdeLevel.medium;
    return ArdeLevel.low;
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
      // Sort by decimal value (higher values first)
      return b.ardeProbability.compareTo(a.ardeProbability);
    });
  }

  /// Returns questions sorted by difficulty
  List<Question> get sortedByDifficulty {
    return [...this]
      ..sort((a, b) => a.difficulty.index.compareTo(b.difficulty.index));
  }

  /// Returns questions sorted by accuracy (lowest first - needs improvement)
  /// TODO: Implement when performance stats are calculated from attempts
  List<Question> get sortedByAccuracy {
    // For now, return unsorted list
    return [...this];
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
  /// TODO: Implement when performance stats are calculated from attempts
  double get averageAccuracy {
    // For now, return 0.0
    return 0.0;
  }

  /// Returns the average difficulty across all questions
  /// TODO: Implement when performance stats are calculated from attempts
  double get averageDifficulty {
    // For now, return 0.0
    return 0.0;
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
  Map<String, List<Question>> get groupedByArdeProbability {
    final grouped = <String, List<Question>>{};
    for (final question in this) {
      final category =
          question.ardeProbabilityDisplay; // Use the display string
      grouped.putIfAbsent(category, () => []).add(question);
    }
    return grouped;
  }
}
