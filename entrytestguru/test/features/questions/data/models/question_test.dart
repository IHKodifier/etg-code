import 'package:flutter_test/flutter_test.dart';
import 'package:entrytestguru/features/questions/data/models/question.dart';
import 'package:entrytestguru/features/questions/data/models/question_enums.dart';
import 'package:entrytestguru/features/questions/data/models/question_option.dart';
import 'package:entrytestguru/features/questions/data/models/question_performance_stats.dart';

void main() {
  group('Question Model Tests', () {
    late Question sampleQuestion;
    late List<QuestionOption> sampleOptions;
    late QuestionPerformanceStats sampleStats;

    setUp(() {
      sampleOptions = [
        const QuestionOption(id: 'A', text: 'Option A'),
        const QuestionOption(id: 'B', text: 'Option B'),
        const QuestionOption(id: 'C', text: 'Option C'),
        const QuestionOption(id: 'D', text: 'Option D'),
      ];

      sampleStats = const QuestionPerformanceStats(
        totalAttempts: 100,
        totalCorrect: 75,
        globalAccuracy: 0.75,
        averageTimeSeconds: 45.0,
        medianTimeSeconds: 42.0,
        p95TimeSeconds: 120.0,
        calculatedDifficulty: 0.6,
      );

      sampleQuestion = Question(
        id: 'TEST_001',
        questionId: 1,
        examCategory: 'ECAT',
        subject: 'Physics',
        topic: 'Kinematics',
        subTopic: 'Motion with Constant Acceleration',
        questionText: 'What is the acceleration due to gravity on Earth?',
        options: sampleOptions,
        correctAnswer: ['C'],
        questionType: QuestionType.mcqSingleSelect,
        explanationText:
            'The acceleration due to gravity on Earth is approximately 9.8 m/s².',
        ardeProbability: 0.8,
        ardeFrequency: 5,
        difficulty: DifficultyLevel.medium,
        estimatedTimeSeconds: 60,
        tags: ['physics', 'gravity', 'kinematics'],
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
        createdBy: 'admin',
        isActive: true,
        version: 1,
        status: 'approved',

        // Approval workflow fields
        approvalStatus: 'approved',
        submittedAt: DateTime(2024, 1, 1),
      );
    });

    test('should create Question with valid data', () {
      expect(sampleQuestion.id, 'TEST_001');
      expect(sampleQuestion.examCategory, 'ECAT');
      expect(sampleQuestion.subject, 'Physics');
      expect(
        sampleQuestion.questionText,
        'What is the acceleration due to gravity on Earth?',
      );
      expect(sampleQuestion.correctAnswer, ['C']);
      expect(sampleQuestion.questionType, QuestionType.mcqSingleSelect);
      expect(sampleQuestion.ardeProbability, 0.8);
      expect(sampleQuestion.difficulty, DifficultyLevel.medium);
    });

    test('should validate question structure', () {
      expect(sampleQuestion.isValid, true);
    });

    test('should return correct options', () {
      final correctOptions = sampleQuestion.correctOptions;
      expect(correctOptions.length, 1);
      expect(correctOptions.first.id, 'C');
    });

    test('should return incorrect options', () {
      final incorrectOptions = sampleQuestion.incorrectOptions;
      expect(incorrectOptions.length, 3);
      expect(incorrectOptions.map((o) => o.id), containsAll(['A', 'B', 'D']));
    });

    test('should identify single choice questions', () {
      expect(sampleQuestion.isSingleChoice, true);
      expect(sampleQuestion.isMultipleChoice, false);
    });

    test('should return expected correct answers count', () {
      expect(sampleQuestion.expectedCorrectAnswers, 1);
    });

    test('should return full topic path', () {
      expect(
        sampleQuestion.fullTopicPath,
        'Kinematics > Motion with Constant Acceleration',
      );
    });

    test('should return primary subject', () {
      expect(sampleQuestion.primarySubject, 'Physics');
    });

    test('should return question type display string', () {
      expect(sampleQuestion.questionTypeDisplay, 'MCQ Single Select');
    });

    test('should return difficulty display string', () {
      expect(sampleQuestion.difficultyDisplay, 'Medium');
    });

    test('should return ARDE probability display string', () {
      expect(sampleQuestion.ardeProbabilityDisplay, 'High Probability');
    });

    test('should return ARDE probability percentage', () {
      expect(sampleQuestion.ardeProbabilityPercentage, '70%+');
    });

    test('should return estimated time formatted', () {
      expect(sampleQuestion.estimatedTimeFormatted, '1m 0s');
    });

    test('should return searchable text', () {
      final searchableText = sampleQuestion.searchableText.toLowerCase();
      expect(searchableText, contains('acceleration'));
      expect(searchableText, contains('gravity'));
      expect(searchableText, contains('earth'));
    });

    test('should match search query', () {
      expect(sampleQuestion.matchesSearch('gravity'), true);
      expect(sampleQuestion.matchesSearch('physics'), true);
      expect(sampleQuestion.matchesSearch('nonexistent'), false);
    });

    test('should return tags display', () {
      expect(sampleQuestion.tagsDisplay, 'physics, gravity, kinematics');
    });

    test('should check if question has visual content', () {
      expect(sampleQuestion.hasVisualContent, false);

      final questionWithImage = sampleQuestion.copyWith(
        questionImageUrls: ['image.jpg'],
      );
      expect(questionWithImage.hasVisualContent, true);
    });

    test('should check if question has multimedia content', () {
      expect(sampleQuestion.hasMultimediaContent, false);

      final questionWithVideo = sampleQuestion.copyWith(
        explanationVideoUrl: 'video.mp4',
      );
      expect(questionWithVideo.hasMultimediaContent, true);
    });

    test('should return performance rating', () {
      expect(sampleQuestion.performanceRating, 'Not Available');
    });

    test('should handle invalid question structure', () {
      final invalidQuestion = Question(
        id: 'INVALID',
        questionId: 999,
        examCategory: 'TEST',
        subject: 'Test',
        topic: 'Test',
        questionText: '', // Empty question text
        options: [], // No options
        correctAnswer: [], // No correct answers
        questionType: QuestionType.mcqSingleSelect,
        explanationText: 'Test explanation',
        ardeProbability: 0.5,
        difficulty: DifficultyLevel.easy,
        estimatedTimeSeconds: 30,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        createdBy: 'test',
        isActive: true,
        version: 1,

        // Approval workflow fields
        approvalStatus: 'pending',
        submittedAt: DateTime.now(),
      );

      expect(invalidQuestion.isValid, false);
    });

    test('should create copy with user data', () {
      final updatedQuestion = sampleQuestion.copyWithUserData(
        isBookmarked: true,
        userNotes: 'Important question',
      );

      expect(updatedQuestion.isBookmarked, true);
      expect(updatedQuestion.userNotes, 'Important question');
    });

    test('should serialize to JSON', () {
      final json = sampleQuestion.toJson();
      expect(json['id'], 'TEST_001');
      expect(json['examCategory'], 'ECAT');
      expect(json['subject'], 'Physics');
      expect(json['correctAnswer'], ['C']);
    });

    test('should deserialize from JSON', () {
      // Create proper JSON structure for deserialization
      final json = {
        'id': 'TEST_001',
        'questionId': 1,
        'examCategory': 'ECAT',
        'subject': 'Physics',
        'topic': 'Kinematics',
        'subTopic': 'Motion with Constant Acceleration',
        'questionText': 'What is the acceleration due to gravity on Earth?',
        'options': [
          {'id': 'A', 'text': 'Option A'},
          {'id': 'B', 'text': 'Option B'},
          {'id': 'C', 'text': 'Option C'},
          {'id': 'D', 'text': 'Option D'},
        ],
        'correctAnswer': ['C'],
        'questionType': 'mcqSingleSelect',
        'explanationText':
            'The acceleration due to gravity on Earth is approximately 9.8 m/s².',
        'ardeProbability': 0.8,
        'ardeFrequency': 5,
        'difficulty': 'medium',
        'estimatedTimeSeconds': 60,
        'tags': ['physics', 'gravity', 'kinematics'],
        'createdAt': '2024-01-01T00:00:00.000Z',
        'updatedAt': '2024-01-01T00:00:00.000Z',
        'createdBy': 'admin',
        'isActive': true,
        'version': 1,
        'status': 'approved',

        // User-specific fields
        'isBookmarked': false,
        'userNotes': null,

        // Approval workflow fields
        'approval_status': 'approved',
        'reviewer_id': 'admin',
        'reviewer_name': 'Administrator',
        'review_comments': 'Approved for use in practice sessions',
        'submitted_at': '2024-01-01T00:00:00.000Z',
        'reviewed_at': '2024-01-02T00:00:00.000Z',
        'approved_at': '2024-01-02T00:00:00.000Z',
      };

      final deserializedQuestion = Question.fromJson(json);

      expect(deserializedQuestion.id, sampleQuestion.id);
      expect(deserializedQuestion.examCategory, sampleQuestion.examCategory);
      expect(deserializedQuestion.correctAnswer, sampleQuestion.correctAnswer);
      expect(deserializedQuestion.options.length, 4);
      expect(deserializedQuestion.options.first.id, 'A');
    });
  });
}
