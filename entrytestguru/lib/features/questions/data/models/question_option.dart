import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_option.freezed.dart';
part 'question_option.g.dart';

/// Represents a single option in a multiple choice question
/// Compatible with backend QuestionOption Pydantic model
@freezed
class QuestionOption with _$QuestionOption {
  const QuestionOption._();

  const factory QuestionOption({
    /// Unique identifier for the option (A, B, C, D, etc.)
    required String id,

    /// The text content of the option
    required String text,

    /// Optional image URL for visual options
    String? imageUrl,

    /// Optional LaTeX/MathJax content for mathematical expressions
    String? latex,

    /// Whether this option is correct (only populated for explanations)
    /// This field is typically null during question display and populated during review
    bool? isCorrect,
  }) = _QuestionOption;

  /// Creates a QuestionOption from JSON
  /// Used for API responses from the backend
  factory QuestionOption.fromJson(Map<String, dynamic> json) =>
      _$QuestionOptionFromJson(json);

  /// Returns the display text for this option
  /// Handles both regular text and LaTeX content
  String get displayText {
    if (latex != null && latex!.isNotEmpty) {
      return latex!;
    }
    return text;
  }

  /// Checks if this option has visual content (image or LaTeX)
  bool get hasVisualContent {
    return (imageUrl != null && imageUrl!.isNotEmpty) ||
        (latex != null && latex!.isNotEmpty);
  }

  /// Returns a formatted option label (e.g., "A.", "B.", etc.)
  String get formattedLabel {
    return '$id.';
  }

  /// Returns the full formatted option text with label
  String get fullOptionText {
    return '$formattedLabel $displayText';
  }
}

/// Extension methods for working with lists of QuestionOption
extension QuestionOptionListExtension on List<QuestionOption> {
  /// Finds an option by its ID
  QuestionOption? findById(String id) {
    return firstWhere(
      (option) => option.id == id,
      orElse: () => throw ArgumentError('Option with id $id not found'),
    );
  }

  /// Returns all correct options
  List<QuestionOption> get correctOptions {
    return where((option) => option.isCorrect == true).toList();
  }

  /// Returns all incorrect options
  List<QuestionOption> get incorrectOptions {
    return where((option) => option.isCorrect == false).toList();
  }

  /// Checks if the list has exactly one correct answer
  bool get hasSingleCorrectAnswer {
    return correctOptions.length == 1;
  }

  /// Checks if the list has multiple correct answers
  bool get hasMultipleCorrectAnswers {
    return correctOptions.length > 1;
  }

  /// Validates that the options meet basic requirements
  bool get isValid {
    if (isEmpty) return false;
    if (length < 2) return false;
    if (length > 6) return false;

    final correctCount = correctOptions.length;
    return correctCount >= 1; // At least one correct answer
  }

  /// Returns option IDs as a list
  List<String> get optionIds {
    return map((option) => option.id).toList();
  }

  /// Returns option texts as a list
  List<String> get optionTexts {
    return map((option) => option.displayText).toList();
  }
}
