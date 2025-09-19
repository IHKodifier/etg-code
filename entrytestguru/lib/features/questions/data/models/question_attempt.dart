import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_attempt.freezed.dart';
part 'question_attempt.g.dart';

/// Represents a single attempt by a user on a question
/// Tracks timing, answers, and performance metrics
@freezed
class QuestionAttempt with _$QuestionAttempt {
  const QuestionAttempt._();

  const factory QuestionAttempt({
    /// Unique identifier for the question
    required String questionId,

    /// Session ID this attempt belongs to
    required String sessionId,

    /// List of selected answer IDs
    required List<String> selectedAnswers,

    /// Whether the attempt was correct
    required bool isCorrect,

    /// Attempt number for this question (1, 2, 3, etc.)
    @Default(1) int attemptNumber,

    /// Time spent on this attempt
    required Duration timeSpent,

    /// When the attempt was made
    required DateTime timestamp,

    // Optional tracking fields
    /// Whether hint was used
    bool? hintUsed,

    /// Whether explanation was viewed
    bool? explanationViewed,

    /// ID of AI interaction if any
    String? aiInteractionId,

    // Performance analysis
    /// User's percentile ranking for time spent
    double? timePercentile,

    /// Assessment of difficulty for this user
    String? difficultyAssessment,
  }) = _QuestionAttempt;

  /// Creates QuestionAttempt from JSON
  factory QuestionAttempt.fromJson(Map<String, dynamic> json) =>
      _$QuestionAttemptFromJson(json);

  /// Creates a new attempt for the same question
  QuestionAttempt nextAttempt({
    required List<String> selectedAnswers,
    required bool isCorrect,
    required Duration timeSpent,
  }) {
    return QuestionAttempt(
      questionId: questionId,
      sessionId: sessionId,
      selectedAnswers: selectedAnswers,
      isCorrect: isCorrect,
      attemptNumber: attemptNumber + 1,
      timeSpent: timeSpent,
      timestamp: DateTime.now(),
      hintUsed: hintUsed,
      explanationViewed: explanationViewed,
    );
  }

  /// Returns time spent in seconds
  double get timeSpentSeconds => timeSpent.inMilliseconds / 1000.0;

  /// Returns time spent formatted as a string
  String get timeSpentFormatted {
    final seconds = timeSpentSeconds;
    if (seconds < 60) {
      return '${seconds.toStringAsFixed(1)}s';
    }
    final minutes = (seconds / 60).floor();
    final remainingSeconds = (seconds % 60).round();
    return '${minutes}m ${remainingSeconds}s';
  }

  /// Checks if this was the first attempt
  bool get isFirstAttempt => attemptNumber == 1;

  /// Checks if this was a quick attempt (< 30 seconds)
  bool get isQuickAttempt => timeSpentSeconds < 30;

  /// Checks if this was a slow attempt (> 5 minutes)
  bool get isSlowAttempt => timeSpentSeconds > 300;

  /// Returns a performance rating based on time and correctness
  String get performanceRating {
    if (!isCorrect) return 'Incorrect';

    if (isQuickAttempt) return 'Fast & Correct';
    if (isSlowAttempt) return 'Slow but Correct';
    return 'Correct';
  }

  /// Checks if the attempt used any assistance
  bool get usedAssistance => (hintUsed == true) || (explanationViewed == true);

  /// Returns the primary selected answer (for single choice questions)
  String? get primaryAnswer {
    return selectedAnswers.isNotEmpty ? selectedAnswers.first : null;
  }

  /// Checks if multiple answers were selected
  bool get hasMultipleAnswers => selectedAnswers.length > 1;
}

/// Extension methods for working with lists of QuestionAttempt
extension QuestionAttemptListExtension on List<QuestionAttempt> {
  /// Returns attempts sorted by timestamp (newest first)
  List<QuestionAttempt> get sortedByTime {
    return [...this]..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  /// Returns attempts sorted by attempt number
  List<QuestionAttempt> get sortedByAttemptNumber {
    return [...this]
      ..sort((a, b) => a.attemptNumber.compareTo(b.attemptNumber));
  }

  /// Returns only correct attempts
  List<QuestionAttempt> get correctAttempts {
    return where((attempt) => attempt.isCorrect).toList();
  }

  /// Returns only incorrect attempts
  List<QuestionAttempt> get incorrectAttempts {
    return where((attempt) => !attempt.isCorrect).toList();
  }

  /// Returns the first correct attempt
  QuestionAttempt? get firstCorrectAttempt {
    return correctAttempts.sortedByAttemptNumber.firstOrNull;
  }

  /// Returns the last attempt
  QuestionAttempt? get lastAttempt {
    return sortedByTime.firstOrNull;
  }

  /// Returns the total time spent on all attempts
  Duration get totalTimeSpent {
    return fold(Duration.zero, (total, attempt) => total + attempt.timeSpent);
  }

  /// Returns the average time spent per attempt
  double get averageTimeSpentSeconds {
    if (isEmpty) return 0.0;
    return totalTimeSpent.inSeconds / length;
  }

  /// Returns the success rate (0.0 to 1.0)
  double get successRate {
    if (isEmpty) return 0.0;
    return correctAttempts.length / length;
  }

  /// Returns the success rate as a percentage
  String get successRatePercentage {
    return '${(successRate * 100).toStringAsFixed(1)}%';
  }

  /// Checks if the user eventually got it correct
  bool get eventuallyCorrect => correctAttempts.isNotEmpty;

  /// Returns the number of attempts needed to get it correct
  int get attemptsToCorrect {
    final firstCorrect = firstCorrectAttempt;
    return firstCorrect?.attemptNumber ?? 0;
  }

  /// Returns attempts that used hints
  List<QuestionAttempt> get attemptsWithHints {
    return where((attempt) => attempt.hintUsed == true).toList();
  }

  /// Returns attempts that viewed explanations
  List<QuestionAttempt> get attemptsWithExplanations {
    return where((attempt) => attempt.explanationViewed == true).toList();
  }

  /// Returns the most recent attempt for each attempt number
  List<QuestionAttempt> get latestAttempts {
    final grouped = <int, QuestionAttempt>{};
    for (final attempt in this) {
      final existing = grouped[attempt.attemptNumber];
      if (existing == null || attempt.timestamp.isAfter(existing.timestamp)) {
        grouped[attempt.attemptNumber] = attempt;
      }
    }
    return grouped.values.toList()
      ..sort((a, b) => a.attemptNumber.compareTo(b.attemptNumber));
  }
}
