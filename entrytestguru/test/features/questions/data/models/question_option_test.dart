import 'package:flutter_test/flutter_test.dart';
import 'package:entrytestguru/features/questions/data/models/question_option.dart';

void main() {
  group('QuestionOption Model Tests', () {
    late QuestionOption sampleOption;

    setUp(() {
      sampleOption = const QuestionOption(
        id: 'A',
        text: 'This is option A',
        imageUrl: 'https://example.com/image.jpg',
        latex: r'\frac{1}{2}mv^2',
        isCorrect: true,
      );
    });

    test('should create QuestionOption with valid data', () {
      expect(sampleOption.id, 'A');
      expect(sampleOption.text, 'This is option A');
      expect(sampleOption.imageUrl, 'https://example.com/image.jpg');
      expect(sampleOption.latex, r'\frac{1}{2}mv^2');
      expect(sampleOption.isCorrect, true);
    });

    test('should return display text with LaTeX when available', () {
      expect(sampleOption.displayText, r'\frac{1}{2}mv^2');
    });

    test('should return display text as regular text when no LaTeX', () {
      final textOption = const QuestionOption(
        id: 'B',
        text: 'Regular text option',
      );
      expect(textOption.displayText, 'Regular text option');
    });

    test('should check if option has visual content', () {
      expect(sampleOption.hasVisualContent, true);

      final textOnlyOption = const QuestionOption(id: 'C', text: 'Text only');
      expect(textOnlyOption.hasVisualContent, false);
    });

    test('should return formatted label', () {
      expect(sampleOption.formattedLabel, 'A.');
    });

    test('should return full option text with label', () {
      expect(sampleOption.fullOptionText, 'A. \\frac{1}{2}mv^2');
    });

    test('should serialize to JSON', () {
      final json = sampleOption.toJson();
      expect(json['id'], 'A');
      expect(json['text'], 'This is option A');
      expect(json['imageUrl'], 'https://example.com/image.jpg');
      expect(json['latex'], r'\frac{1}{2}mv^2');
      expect(json['isCorrect'], true);
    });

    test('should deserialize from JSON', () {
      final json = sampleOption.toJson();
      final deserializedOption = QuestionOption.fromJson(json);

      expect(deserializedOption.id, sampleOption.id);
      expect(deserializedOption.text, sampleOption.text);
      expect(deserializedOption.imageUrl, sampleOption.imageUrl);
      expect(deserializedOption.latex, sampleOption.latex);
      expect(deserializedOption.isCorrect, sampleOption.isCorrect);
    });

    test('should handle null values in JSON', () {
      final json = {
        'id': 'B',
        'text': 'Option B',
        // imageUrl, latex, and isCorrect are null
      };
      final option = QuestionOption.fromJson(json);

      expect(option.id, 'B');
      expect(option.text, 'Option B');
      expect(option.imageUrl, null);
      expect(option.latex, null);
      expect(option.isCorrect, null);
    });
  });

  group('QuestionOptionListExtension Tests', () {
    late List<QuestionOption> options;

    setUp(() {
      options = [
        const QuestionOption(id: 'A', text: 'Option A', isCorrect: false),
        const QuestionOption(id: 'B', text: 'Option B', isCorrect: true),
        const QuestionOption(id: 'C', text: 'Option C', isCorrect: false),
        const QuestionOption(id: 'D', text: 'Option D', isCorrect: true),
      ];
    });

    test('should find option by ID', () {
      final option = options.findById('B');
      expect(option?.id, 'B');
      expect(option?.text, 'Option B');
    });

    test('should throw when option ID not found', () {
      expect(() => options.findById('Z'), throwsA(isA<ArgumentError>()));
    });

    test('should return correct options', () {
      final correctOptions = options.correctOptions;
      expect(correctOptions.length, 2);
      expect(correctOptions.map((o) => o.id), containsAll(['B', 'D']));
    });

    test('should return incorrect options', () {
      final incorrectOptions = options.incorrectOptions;
      expect(incorrectOptions.length, 2);
      expect(incorrectOptions.map((o) => o.id), containsAll(['A', 'C']));
    });

    test('should check if list has single correct answer', () {
      final singleChoiceOptions = [
        const QuestionOption(id: 'A', text: 'Option A', isCorrect: false),
        const QuestionOption(id: 'B', text: 'Option B', isCorrect: true),
        const QuestionOption(id: 'C', text: 'Option C', isCorrect: false),
      ];
      expect(singleChoiceOptions.hasSingleCorrectAnswer, true);
      expect(singleChoiceOptions.hasMultipleCorrectAnswers, false);
    });

    test('should check if list has multiple correct answers', () {
      expect(options.hasSingleCorrectAnswer, false);
      expect(options.hasMultipleCorrectAnswers, true);
    });

    test('should validate option list', () {
      expect(options.isValid, true);

      final invalidOptions = [
        const QuestionOption(id: 'A', text: 'Option A'), // Only one option
      ];
      expect(invalidOptions.isValid, false);

      final emptyOptions = <QuestionOption>[];
      expect(emptyOptions.isValid, false);

      final tooManyOptions = List.generate(
        10,
        (index) => QuestionOption(id: index.toString(), text: 'Option $index'),
      );
      expect(tooManyOptions.isValid, false); // More than 6 options
    });

    test('should return option IDs', () {
      expect(options.optionIds, ['A', 'B', 'C', 'D']);
    });

    test('should return option texts', () {
      expect(options.optionTexts, [
        'Option A',
        'Option B',
        'Option C',
        'Option D',
      ]);
    });

    test('should handle options with null isCorrect values', () {
      final mixedOptions = [
        const QuestionOption(id: 'A', text: 'Option A', isCorrect: null),
        const QuestionOption(id: 'B', text: 'Option B', isCorrect: true),
        const QuestionOption(id: 'C', text: 'Option C', isCorrect: false),
      ];

      final correctOptions = mixedOptions.correctOptions;
      expect(correctOptions.length, 1);
      expect(correctOptions.first.id, 'B');

      final incorrectOptions = mixedOptions.incorrectOptions;
      expect(incorrectOptions.length, 1);
      expect(incorrectOptions.first.id, 'C');
    });
  });
}
