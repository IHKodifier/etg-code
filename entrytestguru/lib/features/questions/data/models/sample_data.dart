import 'question.dart';
import 'question_enums.dart';
import 'question_option.dart';
import 'question_performance_stats.dart';
import 'question_attempt.dart';

/// Sample data for testing and development
/// Provides realistic examples of questions, attempts, and performance data
class SampleData {
  /// Creates a sample physics question about kinematics
  static Question createSamplePhysicsQuestion() {
    return Question(
      id: "ECAT_PHY_001",
      questionId: "ECAT_PHY_001",
      examCategory: "ECAT",
      subject: "Physics",
      topic: "Kinematics",
      subTopic: "Motion with Constant Acceleration",

      questionText:
          "A ball is thrown vertically upward with an initial velocity of 20 m/s. "
          "What will be its velocity at the highest point? "
          "(Take g = 10 m/s²)",

      options: [
        QuestionOption(id: "A", text: "20 m/s upward"),
        QuestionOption(id: "B", text: "20 m/s downward"),
        QuestionOption(id: "C", text: "0 m/s"),
        QuestionOption(id: "D", text: "10 m/s downward"),
      ],

      correctAnswer: ["C"],
      questionType: QuestionType.singleChoice,

      explanationText:
          "At the highest point, the velocity becomes zero because "
          "the object momentarily stops before starting to fall back down. "
          "The acceleration due to gravity acts downward throughout the motion.",

      explanationSteps: [
        "Step 1: Identify the type of motion - projectile motion",
        "Step 2: At maximum height, velocity = 0 m/s",
        "Step 3: Acceleration due to gravity = 10 m/s² (downward)",
        "Step 4: Final velocity = Initial velocity - g × time",
        "Step 5: At maximum height: 20 - g × t = 0, so t = 2s",
      ],

      ardeProbability: ArdeLevel.high,
      ardeFrequency: 3,
      ardeAppearanceYears: [2023, 2022, 2020],
      ardeNotes: "Frequently asked in kinematics section",
      ardeContext: "This is a fundamental concept in projectile motion",

      difficulty: DifficultyLevel.medium,
      estimatedTimeSeconds: 60,

      globalStats: QuestionPerformanceStats(
        totalAttempts: 1523,
        totalCorrect: 1023,
        globalAccuracy: 0.672,
        averageTimeSeconds: 45.3,
        medianTimeSeconds: 42.0,
        p95TimeSeconds: 120.0,
        calculatedDifficulty: 0.65,
        tierPerformance: {
          "anonymous": TierPerformance(
            tier: "anonymous",
            attempts: 456,
            accuracy: 0.58,
            avgTimeSeconds: 52.3,
          ),
          "free": TierPerformance(
            tier: "free",
            attempts: 723,
            accuracy: 0.68,
            avgTimeSeconds: 43.1,
          ),
          "paid": TierPerformance(
            tier: "paid",
            attempts: 344,
            accuracy: 0.78,
            avgTimeSeconds: 38.7,
          ),
        },
      ),

      tags: ["kinematics", "projectile motion", "maximum height", "velocity"],
      relatedQuestions: ["ECAT_PHY_002", "ECAT_PHY_003"],

      createdAt: DateTime(2024, 1, 15),
      updatedAt: DateTime(2024, 9, 16),
      createdBy: "admin",
      isActive: true,
      version: 1,
      status: "approved",
    );
  }

  /// Creates a sample chemistry question about organic reactions
  static Question createSampleChemistryQuestion() {
    return Question(
      id: "MCAT_CHEM_001",
      questionId: "MCAT_CHEM_001",
      examCategory: "MCAT",
      subject: "Chemistry",
      topic: "Organic Chemistry",
      subTopic: "Reaction Mechanisms",

      questionText:
          "Which of the following is the rate-determining step in the "
          "SN1 reaction mechanism?",

      options: [
        QuestionOption(id: "A", text: "Nucleophilic attack"),
        QuestionOption(id: "B", text: "Carbocation formation"),
        QuestionOption(id: "C", text: "Leaving group departure"),
        QuestionOption(id: "D", text: "Nucleophile bond formation"),
      ],

      correctAnswer: ["B"],
      questionType: QuestionType.singleChoice,

      explanationText:
          "In SN1 reactions, the rate-determining step is the "
          "formation of the carbocation intermediate. This step involves only "
          "the substrate and is unimolecular, hence the name SN1.",

      ardeProbability: ArdeLevel.medium,
      ardeFrequency: 2,
      ardeAppearanceYears: [2023, 2021],

      difficulty: DifficultyLevel.hard,
      estimatedTimeSeconds: 90,

      globalStats: QuestionPerformanceStats(
        totalAttempts: 987,
        totalCorrect: 654,
        globalAccuracy: 0.663,
        averageTimeSeconds: 67.8,
        medianTimeSeconds: 65.0,
        p95TimeSeconds: 150.0,
        calculatedDifficulty: 0.75,
      ),

      tags: ["sn1", "reaction mechanism", "carbocation", "organic chemistry"],
      relatedQuestions: ["MCAT_CHEM_002", "MCAT_CHEM_003"],

      createdAt: DateTime(2024, 2, 20),
      updatedAt: DateTime(2024, 9, 16),
      createdBy: "admin",
      isActive: true,
      version: 1,
      status: "approved",
    );
  }

  /// Creates a sample mathematics question about calculus
  static Question createSampleMathQuestion() {
    return Question(
      id: "ECAT_MATH_001",
      questionId: "ECAT_MATH_001",
      examCategory: "ECAT",
      subject: "Mathematics",
      topic: "Calculus",
      subTopic: "Limits and Continuity",

      questionText: "Evaluate: \\(\\lim_{x \\to 0} \\frac{\\sin x}{x}\\)",

      options: [
        QuestionOption(id: "A", text: "0"),
        QuestionOption(id: "B", text: "1"),
        QuestionOption(id: "C", text: "∞"),
        QuestionOption(id: "D", text: "Does not exist"),
      ],

      correctAnswer: ["B"],
      questionType: QuestionType.singleChoice,

      explanationText:
          "This is a standard limit that appears frequently in calculus. "
          "The limit of sin(x)/x as x approaches 0 is 1. This can be proven using "
          "the squeeze theorem or L'Hôpital's rule.",

      ardeProbability: ArdeLevel.high,
      ardeFrequency: 4,
      ardeAppearanceYears: [2023, 2022, 2021, 2020],

      difficulty: DifficultyLevel.medium,
      estimatedTimeSeconds: 45,

      globalStats: QuestionPerformanceStats(
        totalAttempts: 2134,
        totalCorrect: 1789,
        globalAccuracy: 0.838,
        averageTimeSeconds: 38.2,
        medianTimeSeconds: 35.0,
        p95TimeSeconds: 90.0,
        calculatedDifficulty: 0.45,
      ),

      tags: ["limits", "trigonometric limits", "calculus", "squeeze theorem"],
      relatedQuestions: ["ECAT_MATH_002", "ECAT_MATH_003"],

      createdAt: DateTime(2024, 1, 10),
      updatedAt: DateTime(2024, 9, 16),
      createdBy: "admin",
      isActive: true,
      version: 1,
      status: "approved",
    );
  }

  /// Creates a sample question attempt
  static QuestionAttempt createSampleAttempt({
    required String questionId,
    required bool isCorrect,
    int attemptNumber = 1,
    Duration? timeSpent,
  }) {
    return QuestionAttempt(
      questionId: questionId,
      sessionId: "session_${DateTime.now().millisecondsSinceEpoch}",
      selectedAnswers: isCorrect ? ["C"] : ["A"],
      isCorrect: isCorrect,
      attemptNumber: attemptNumber,
      timeSpent: timeSpent ?? Duration(seconds: 45),
      timestamp: DateTime.now(),
      hintUsed: attemptNumber > 1,
      explanationViewed: !isCorrect,
    );
  }

  /// Creates a list of sample questions for testing
  static List<Question> createSampleQuestions() {
    return [
      createSamplePhysicsQuestion(),
      createSampleChemistryQuestion(),
      createSampleMathQuestion(),
    ];
  }

  /// Creates sample questions for a specific exam category
  static List<Question> createQuestionsForExam(String examCategory) {
    return createSampleQuestions()
        .where((question) => question.examCategory == examCategory)
        .toList();
  }

  /// Creates sample questions for a specific subject
  static List<Question> createQuestionsForSubject(String subject) {
    return createSampleQuestions()
        .where((question) => question.subject == subject)
        .toList();
  }

  /// Creates sample questions with high ARDE probability
  static List<Question> createHighArdeQuestions() {
    return createSampleQuestions()
        .where((question) => question.ardeProbability == ArdeLevel.high)
        .toList();
  }

  /// Creates sample questions sorted by difficulty
  static List<Question> createQuestionsByDifficulty(
    DifficultyLevel difficulty,
  ) {
    return createSampleQuestions()
        .where((question) => question.difficulty == difficulty)
        .toList();
  }

  /// Creates a complete sample dataset for testing
  static Map<String, dynamic> createCompleteSampleDataset() {
    final questions = createSampleQuestions();
    final attempts = questions
        .map(
          (question) =>
              createSampleAttempt(questionId: question.id, isCorrect: true),
        )
        .toList();

    return {
      'questions': questions,
      'attempts': attempts,
      'totalQuestions': questions.length,
      'totalAttempts': attempts.length,
      'categories': questions.map((q) => q.examCategory).toSet().toList(),
      'subjects': questions.map((q) => q.subject).toSet().toList(),
      'topics': questions.map((q) => q.topic).toSet().toList(),
    };
  }
}
