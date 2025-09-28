import '../data/models/question.dart';
import '../data/models/question_enums.dart';
import '../data/models/question_option.dart';

/// Utility class for mapping and normalizing question data from different sources
/// Ensures consistent schema between CSV uploads and manual question creation
class QuestionSchemaMapper {
  /// Generates a unique question ID using timestamp
  static int generateUniqueQuestionId() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// Converts CSV difficulty string to DifficultyLevel enum
  static DifficultyLevel mapCsvDifficulty(String csvDifficulty) {
    switch (csvDifficulty.toLowerCase()) {
      case 'easy':
        return DifficultyLevel.easy;
      case 'medium':
        return DifficultyLevel.medium;
      case 'hard':
        return DifficultyLevel.hard;
      case 'very easy':
        return DifficultyLevel.veryEasy;
      case 'very hard':
        return DifficultyLevel.veryHard;
      default:
        return DifficultyLevel.medium; // Default fallback
    }
  }

  /// Converts CSV question type string to QuestionType enum
  static QuestionType mapCsvQuestionType(String csvQuestionType) {
    final type = csvQuestionType.toLowerCase();
    if (type.contains('single') || type.contains('mcq')) {
      return QuestionType.singleChoice;
    } else if (type.contains('multiple')) {
      return QuestionType.multipleChoice;
    } else if (type.contains('assertion')) {
      return QuestionType.assertionReason;
    } else if (type.contains('numerical')) {
      return QuestionType.numerical;
    }
    return QuestionType.singleChoice; // Default fallback
  }

  /// Normalizes correct answers from CSV format to List<String>
  /// CSV uses comma-separated letters like "A,B,C"
  /// Output is List<String> like ["A", "B", "C"]
  static List<String> normalizeCorrectAnswers(String csvCorrectAnswer) {
    if (csvCorrectAnswer.trim().isEmpty) {
      return [];
    }

    return csvCorrectAnswer
        .split(',')
        .map((answer) => answer.trim().toUpperCase())
        .where((answer) => answer.isNotEmpty)
        .toList();
  }

  /// Converts CSV tags string to List<String>
  /// CSV uses comma-separated format like "tag1,tag2,tag3"
  static List<String> parseCsvTags(String? csvTags) {
    if (csvTags == null || csvTags.trim().isEmpty) {
      return [];
    }

    return csvTags
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();
  }

  /// Parses CSV image URLs string to List<String>
  /// CSV uses comma-separated URLs or single URL
  static List<String> parseCsvImageUrls(String? csvImageUrls) {
    if (csvImageUrls == null || csvImageUrls.trim().isEmpty) {
      return [];
    }

    return csvImageUrls
        .split(',')
        .map((url) => url.trim())
        .where((url) => url.isNotEmpty)
        .toList();
  }

  /// Safely parses numeric values from CSV strings
  static int safeParseInt(String? value, int defaultValue) {
    if (value == null || value.trim().isEmpty) {
      return defaultValue;
    }
    return int.tryParse(value.trim()) ?? defaultValue;
  }

  /// Safely parses double values from CSV strings
  static double safeParseDouble(String? value, double defaultValue) {
    if (value == null || value.trim().isEmpty) {
      return defaultValue;
    }
    return double.tryParse(value.trim()) ?? defaultValue;
  }

  /// Creates QuestionOption objects from CSV option data
  /// Handles up to 6 options (A-F) with optional images and LaTeX
  static List<QuestionOption> createOptionsFromCsv(
    Map<String, dynamic> csvRow,
  ) {
    final options = <QuestionOption>[];
    final optionLabels = ['a', 'b', 'c', 'd', 'e', 'f'];

    for (int i = 0; i < optionLabels.length; i++) {
      final label = optionLabels[i];
      final optionKey = 'option_$label';
      final imageKey = 'option_${label}_image';
      final latexKey = 'option_${label}_latex';

      final optionText = csvRow[optionKey]?.toString().trim();
      if (optionText != null && optionText.isNotEmpty) {
        options.add(
          QuestionOption(
            id: label.toUpperCase(),
            text: optionText,
            imageUrl: csvRow[imageKey]?.toString().trim(),
            latex: csvRow[latexKey]?.toString().trim(),
          ),
        );
      }
    }

    return options;
  }

  /// Validates that CSV data has minimum required fields for question creation
  static List<String> validateCsvQuestionData(Map<String, dynamic> csvRow) {
    final errors = <String>[];

    // Required fields
    if (csvRow['question_text']?.toString().trim().isEmpty ?? true) {
      errors.add('Question text is required');
    }

    if (csvRow['examCategory']?.toString().trim().isEmpty ?? true) {
      errors.add('Exam category is required');
    }

    if (csvRow['subject']?.toString().trim().isEmpty ?? true) {
      errors.add('Subject is required');
    }

    if (csvRow['topic']?.toString().trim().isEmpty ?? true) {
      errors.add('Topic is required');
    }

    // Check if at least 2 options are provided
    final options = createOptionsFromCsv(csvRow);
    if (options.length < 2) {
      errors.add('At least 2 options are required');
    }

    // Check if correct answer is provided and valid
    final correctAnswer = csvRow['correct_answer']?.toString().trim();
    if (correctAnswer == null || correctAnswer.isEmpty) {
      errors.add('Correct answer is required');
    } else {
      final normalizedAnswers = normalizeCorrectAnswers(correctAnswer);
      if (normalizedAnswers.isEmpty) {
        errors.add('At least one correct answer must be specified');
      }

      // Validate that correct answers correspond to existing options
      final optionIds = options.map((opt) => opt.id).toSet();
      final invalidAnswers = normalizedAnswers
          .where((answer) => !optionIds.contains(answer))
          .toList();
      if (invalidAnswers.isNotEmpty) {
        errors.add(
          'Correct answers contain invalid option IDs: ${invalidAnswers.join(", ")}',
        );
      }
    }

    return errors;
  }

  /// Creates a complete Question object from validated CSV data
  /// This ensures CSV and manual creation produce identical Question objects
  static Question createQuestionFromCsvData(
    Map<String, dynamic> csvRow, {
    required String createdBy,
    int? overrideQuestionId,
  }) {
    final questionId =
        overrideQuestionId ??
        (csvRow['questionId'] != null
            ? safeParseInt(
                csvRow['questionId'].toString(),
                generateUniqueQuestionId(),
              )
            : generateUniqueQuestionId());

    final options = createOptionsFromCsv(csvRow);
    final correctAnswers = normalizeCorrectAnswers(
      csvRow['correct_answer'].toString(),
    );

    return Question(
      id: 'csv_$questionId',
      questionId: questionId,
      examCategory: csvRow['examCategory'].toString().trim(),
      subject: csvRow['subject'].toString().trim(),
      topic: csvRow['topic'].toString().trim(),
      subTopic: csvRow['subTopic']?.toString().trim(),
      questionText: csvRow['question_text'].toString().trim(),
      questionImageUrls: parseCsvImageUrls(
        csvRow['questionImageUrls']?.toString(),
      ),
      questionLatex: parseCsvImageUrls(
        csvRow['questionLatex']?.toString(),
      ), // Reuse for LaTeX
      options: options,
      correctAnswer: correctAnswers,
      questionType: mapCsvQuestionType(csvRow['questionType'].toString()),
      explanationText:
          csvRow['explanationText']?.toString().trim() ??
          'Explanation not provided',
      explanationVideoUrl: csvRow['explanationVideoUrl']?.toString().trim(),
      ardeProbability: safeParseDouble(
        csvRow['ardeProbability']?.toString(),
        0.5,
      ),
      difficulty: mapCsvDifficulty(csvRow['difficulty'].toString()),
      estimatedTimeSeconds: safeParseInt(
        csvRow['estimatedTimeSeconds']?.toString(),
        60,
      ),
      tags: parseCsvTags(csvRow['tags']?.toString()),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      createdBy: createdBy,
      isActive: true,
      version: 1,
      status: 'draft',
      approvalStatus: 'pending',
      submittedAt: DateTime.now(),
    );
  }
}
