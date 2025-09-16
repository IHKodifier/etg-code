import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_performance_stats.freezed.dart';
part 'question_performance_stats.g.dart';

/// Performance statistics for a question across all users
/// Tracks global performance metrics and analytics
@freezed
class QuestionPerformanceStats with _$QuestionPerformanceStats {
  const QuestionPerformanceStats._();

  const factory QuestionPerformanceStats({
    /// Total number of attempts on this question
    @Default(0) int totalAttempts,

    /// Total number of correct attempts
    @Default(0) int totalCorrect,

    /// Global accuracy rate (0.0 to 1.0)
    @Default(0.0) double globalAccuracy,

    /// Average time spent on this question in seconds
    @Default(0.0) double averageTimeSeconds,

    /// Median time spent on this question in seconds
    @Default(0.0) double medianTimeSeconds,

    /// 95th percentile time spent on this question in seconds
    @Default(0.0) double p95TimeSeconds,

    /// Calculated difficulty score based on performance (0-1)
    @Default(0.0) double calculatedDifficulty,

    /// Performance statistics by user tier
    Map<String, TierPerformance>? tierPerformance,

    /// Common wrong answer patterns
    List<WrongAnswerPattern>? commonMistakes,

    /// Time distribution across different time buckets
    Map<String, double>? timeDistribution,
  }) = _QuestionPerformanceStats;

  /// Creates QuestionPerformanceStats from JSON
  factory QuestionPerformanceStats.fromJson(Map<String, dynamic> json) =>
      _$QuestionPerformanceStatsFromJson(json);

  /// Calculates the accuracy percentage (0-100)
  double get accuracyPercentage => globalAccuracy * 100;

  /// Returns the difficulty level based on calculated difficulty score
  String get difficultyLevel {
    if (calculatedDifficulty < 0.3) return 'Easy';
    if (calculatedDifficulty < 0.7) return 'Medium';
    return 'Hard';
  }

  /// Returns the success rate as a formatted string
  String get successRateText => '${accuracyPercentage.toStringAsFixed(1)}%';

  /// Checks if the question has sufficient data for reliable statistics
  bool get hasReliableStats => totalAttempts >= 10;

  /// Returns the most common wrong answer if available
  WrongAnswerPattern? get mostCommonMistake {
    if (commonMistakes == null || commonMistakes!.isEmpty) return null;
    return commonMistakes!.reduce(
      (a, b) => a.selectionCount > b.selectionCount ? a : b,
    );
  }

  /// Returns tier-specific performance for a given tier
  TierPerformance? getTierPerformance(String tier) {
    return tierPerformance?[tier];
  }

  /// Returns the average time formatted as a string
  String get averageTimeFormatted {
    if (averageTimeSeconds < 60) {
      return '${averageTimeSeconds.toStringAsFixed(1)}s';
    }
    final minutes = (averageTimeSeconds / 60).floor();
    final seconds = (averageTimeSeconds % 60).round();
    return '${minutes}m ${seconds}s';
  }
}

/// Performance statistics for a specific user tier
@freezed
class TierPerformance with _$TierPerformance {
  const TierPerformance._();

  const factory TierPerformance({
    /// User tier (anonymous, free, paid)
    required String tier,

    /// Number of attempts by users in this tier
    @Default(0) int attempts,

    /// Accuracy rate for this tier (0.0 to 1.0)
    @Default(0.0) double accuracy,

    /// Average time spent by users in this tier
    @Default(0.0) double avgTimeSeconds,
  }) = _TierPerformance;

  /// Creates TierPerformance from JSON
  factory TierPerformance.fromJson(Map<String, dynamic> json) =>
      _$TierPerformanceFromJson(json);

  /// Returns the accuracy percentage for this tier
  double get accuracyPercentage => accuracy * 100;

  /// Returns the average time formatted as a string
  String get averageTimeFormatted {
    if (avgTimeSeconds < 60) {
      return '${avgTimeSeconds.toStringAsFixed(1)}s';
    }
    final minutes = (avgTimeSeconds / 60).floor();
    final seconds = (avgTimeSeconds % 60).round();
    return '${minutes}m ${seconds}s';
  }

  /// Checks if this tier has sufficient data
  bool get hasData => attempts > 0;
}

/// Pattern of wrong answers for a question
@freezed
class WrongAnswerPattern with _$WrongAnswerPattern {
  const WrongAnswerPattern._();

  const factory WrongAnswerPattern({
    /// The option ID that was incorrectly selected
    required String optionId,

    /// Number of times this option was selected incorrectly
    @Default(0) int selectionCount,

    /// Percentage of wrong answers that chose this option
    @Default(0.0) double percentage,
  }) = _WrongAnswerPattern;

  /// Creates WrongAnswerPattern from JSON
  factory WrongAnswerPattern.fromJson(Map<String, dynamic> json) =>
      _$WrongAnswerPatternFromJson(json);

  /// Returns the percentage as a formatted string
  String get percentageText => '${percentage.toStringAsFixed(1)}%';

  /// Checks if this is a significant wrong answer pattern
  bool get isSignificant => percentage > 10.0;
}

/// Extension methods for working with performance statistics
extension QuestionPerformanceStatsListExtension
    on List<QuestionPerformanceStats> {
  /// Returns questions sorted by difficulty (hardest first)
  List<QuestionPerformanceStats> get sortedByDifficulty {
    return [
      ...this,
    ]..sort((a, b) => b.calculatedDifficulty.compareTo(a.calculatedDifficulty));
  }

  /// Returns questions sorted by accuracy (lowest first - needs improvement)
  List<QuestionPerformanceStats> get sortedByAccuracy {
    return [...this]
      ..sort((a, b) => a.globalAccuracy.compareTo(b.globalAccuracy));
  }

  /// Returns questions with reliable statistics only
  List<QuestionPerformanceStats> get reliableStats {
    return where((stats) => stats.hasReliableStats).toList();
  }

  /// Returns the average accuracy across all questions
  double get averageAccuracy {
    if (isEmpty) return 0.0;
    final totalAccuracy = fold<double>(
      0.0,
      (sum, stats) => sum + stats.globalAccuracy,
    );
    return totalAccuracy / length;
  }

  /// Returns the average difficulty across all questions
  double get averageDifficulty {
    if (isEmpty) return 0.0;
    final totalDifficulty = fold<double>(
      0.0,
      (sum, stats) => sum + stats.calculatedDifficulty,
    );
    return totalDifficulty / length;
  }
}
