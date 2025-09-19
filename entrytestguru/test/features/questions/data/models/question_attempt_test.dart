import 'package:flutter_test/flutter_test.dart';
import 'package:entrytestguru/features/questions/data/models/question_attempt.dart';

void main() {
  group('QuestionAttempt Model Tests', () {
    late QuestionAttempt sampleAttempt;
    late DateTime testTimestamp;

    setUp(() {
      testTimestamp = DateTime(2024, 1, 1, 12, 0, 0);
      sampleAttempt = QuestionAttempt(
        questionId: 'TEST_001',
        sessionId: 'SESSION_123',
        selectedAnswers: ['A', 'C'],
        isCorrect: true,
        attemptNumber: 2,
        timeSpent: const Duration(seconds: 45),
        timestamp: testTimestamp,
        hintUsed: true,
        explanationViewed: false,
        aiInteractionId: 'AI_456',
        timePercentile: 75.5,
        difficultyAssessment: 'Medium',
      );
    });

    test('should create QuestionAttempt with valid data', () {
      expect(sampleAttempt.questionId, 'TEST_001');
      expect(sampleAttempt.sessionId, 'SESSION_123');
      expect(sampleAttempt.selectedAnswers, ['A', 'C']);
      expect(sampleAttempt.isCorrect, true);
      expect(sampleAttempt.attemptNumber, 2);
      expect(sampleAttempt.timeSpent, const Duration(seconds: 45));
      expect(sampleAttempt.timestamp, testTimestamp);
      expect(sampleAttempt.hintUsed, true);
      expect(sampleAttempt.explanationViewed, false);
      expect(sampleAttempt.aiInteractionId, 'AI_456');
    });

    test('should return time spent in seconds', () {
      expect(sampleAttempt.timeSpentSeconds, 45.0);
    });

    test('should return formatted time spent', () {
      expect(sampleAttempt.timeSpentFormatted, '45s');

      final longAttempt = sampleAttempt.copyWith(
        timeSpent: const Duration(minutes: 2, seconds: 30),
      );
      expect(longAttempt.timeSpentFormatted, '2m 30s');
    });

    test('should check if it was first attempt', () {
      expect(sampleAttempt.isFirstAttempt, false);

      final firstAttempt = sampleAttempt.copyWith(attemptNumber: 1);
      expect(firstAttempt.isFirstAttempt, true);
    });

    test('should check if it was a quick attempt', () {
      expect(sampleAttempt.isQuickAttempt, false);

      final quickAttempt = sampleAttempt.copyWith(
        timeSpent: const Duration(seconds: 20),
      );
      expect(quickAttempt.isQuickAttempt, true);
    });

    test('should check if it was a slow attempt', () {
      expect(sampleAttempt.isSlowAttempt, false);

      final slowAttempt = sampleAttempt.copyWith(
        timeSpent: const Duration(minutes: 6),
      );
      expect(slowAttempt.isSlowAttempt, true);
    });

    test('should return performance rating', () {
      expect(sampleAttempt.performanceRating, 'Fast & Correct');

      final incorrectAttempt = sampleAttempt.copyWith(isCorrect: false);
      expect(incorrectAttempt.performanceRating, 'Incorrect');

      final slowCorrectAttempt = sampleAttempt.copyWith(
        timeSpent: const Duration(minutes: 3),
        isCorrect: true,
      );
      expect(slowCorrectAttempt.performanceRating, 'Slow but Correct');
    });

    test('should check if assistance was used', () {
      expect(sampleAttempt.usedAssistance, true);

      final noAssistanceAttempt = sampleAttempt.copyWith(
        hintUsed: false,
        explanationViewed: false,
      );
      expect(noAssistanceAttempt.usedAssistance, false);
    });

    test('should return primary answer for single choice', () {
      expect(sampleAttempt.primaryAnswer, 'A');

      final singleAnswerAttempt = sampleAttempt.copyWith(
        selectedAnswers: ['B'],
      );
      expect(singleAnswerAttempt.primaryAnswer, 'B');
    });

    test('should check if multiple answers were selected', () {
      expect(sampleAttempt.hasMultipleAnswers, true);

      final singleAnswerAttempt = sampleAttempt.copyWith(
        selectedAnswers: ['B'],
      );
      expect(singleAnswerAttempt.hasMultipleAnswers, false);
    });

    test('should create next attempt', () {
      final nextAttempt = sampleAttempt.nextAttempt(
        selectedAnswers: ['B'],
        isCorrect: false,
        timeSpent: const Duration(seconds: 60),
      );

      expect(nextAttempt.questionId, sampleAttempt.questionId);
      expect(nextAttempt.sessionId, sampleAttempt.sessionId);
      expect(nextAttempt.selectedAnswers, ['B']);
      expect(nextAttempt.isCorrect, false);
      expect(nextAttempt.attemptNumber, 3);
      expect(nextAttempt.timeSpent, const Duration(seconds: 60));
      expect(nextAttempt.timestamp.isAfter(sampleAttempt.timestamp), true);
    });

    test('should serialize to JSON', () {
      final json = sampleAttempt.toJson();
      expect(json['questionId'], 'TEST_001');
      expect(json['sessionId'], 'SESSION_123');
      expect(json['selectedAnswers'], ['A', 'C']);
      expect(json['isCorrect'], true);
      expect(json['attemptNumber'], 2);
      expect(json['timeSpent'], 45000000); // Duration in microseconds
      expect(json['timestamp'], testTimestamp.toIso8601String());
      expect(json['hintUsed'], true);
      expect(json['explanationViewed'], false);
    });

    test('should deserialize from JSON', () {
      final json = sampleAttempt.toJson();
      final deserializedAttempt = QuestionAttempt.fromJson(json);

      expect(deserializedAttempt.questionId, sampleAttempt.questionId);
      expect(deserializedAttempt.sessionId, sampleAttempt.sessionId);
      expect(
        deserializedAttempt.selectedAnswers,
        sampleAttempt.selectedAnswers,
      );
      expect(deserializedAttempt.isCorrect, sampleAttempt.isCorrect);
      expect(deserializedAttempt.attemptNumber, sampleAttempt.attemptNumber);
      expect(deserializedAttempt.timeSpent, sampleAttempt.timeSpent);
      expect(deserializedAttempt.hintUsed, sampleAttempt.hintUsed);
    });

    test('should handle null optional fields in JSON', () {
      final minimalJson = {
        'questionId': 'TEST_002',
        'sessionId': 'SESSION_456',
        'selectedAnswers': ['A'],
        'isCorrect': false,
        'timeSpent': 30000000, // 30 seconds in microseconds
        'timestamp': DateTime.now().toIso8601String(),
        'attemptNumber': 1,
      };

      final attempt = QuestionAttempt.fromJson(minimalJson);
      expect(attempt.questionId, 'TEST_002');
      expect(attempt.hintUsed, null);
      expect(attempt.explanationViewed, null);
      expect(attempt.aiInteractionId, null);
    });
  });

  group('QuestionAttemptListExtension Tests', () {
    late List<QuestionAttempt> attempts;

    setUp(() {
      attempts = [
        QuestionAttempt(
          questionId: 'Q1',
          sessionId: 'S1',
          selectedAnswers: ['A'],
          isCorrect: true,
          attemptNumber: 1,
          timeSpent: const Duration(seconds: 30),
          timestamp: DateTime(2024, 1, 1, 10, 0),
        ),
        QuestionAttempt(
          questionId: 'Q1',
          sessionId: 'S1',
          selectedAnswers: ['B'],
          isCorrect: false,
          attemptNumber: 2,
          timeSpent: const Duration(seconds: 45),
          timestamp: DateTime(2024, 1, 1, 10, 5),
        ),
        QuestionAttempt(
          questionId: 'Q2',
          sessionId: 'S1',
          selectedAnswers: ['C'],
          isCorrect: true,
          attemptNumber: 1,
          timeSpent: const Duration(seconds: 60),
          timestamp: DateTime(2024, 1, 1, 10, 10),
        ),
      ];
    });

    test('should sort attempts by time (newest first)', () {
      final sorted = attempts.sortedByTime;
      expect(sorted.first.timestamp, DateTime(2024, 1, 1, 10, 10));
      expect(sorted.last.timestamp, DateTime(2024, 1, 1, 10, 0));
    });

    test('should sort attempts by attempt number', () {
      final sorted = attempts.sortedByAttemptNumber;
      expect(sorted.first.attemptNumber, 1);
      expect(sorted.last.attemptNumber, 2);
    });

    test('should return correct attempts', () {
      final correctAttempts = attempts.correctAttempts;
      expect(correctAttempts.length, 2);
      expect(correctAttempts.every((a) => a.isCorrect), true);
    });

    test('should return incorrect attempts', () {
      final incorrectAttempts = attempts.incorrectAttempts;
      expect(incorrectAttempts.length, 1);
      expect(incorrectAttempts.every((a) => !a.isCorrect), true);
    });

    test('should return first correct attempt', () {
      final firstCorrect = attempts.firstCorrectAttempt;
      expect(firstCorrect?.questionId, 'Q1');
      expect(firstCorrect?.attemptNumber, 1);
    });

    test('should return last attempt', () {
      final lastAttempt = attempts.lastAttempt;
      expect(lastAttempt?.timestamp, DateTime(2024, 1, 1, 10, 10));
    });

    test('should return total time spent', () {
      final totalTime = attempts.totalTimeSpent;
      expect(totalTime, const Duration(seconds: 135)); // 30 + 45 + 60
    });

    test('should return average time spent in seconds', () {
      expect(attempts.averageTimeSpentSeconds, 45.0); // 135 / 3
    });

    test('should return success rate', () {
      expect(attempts.successRate, 2 / 3); // 2 correct out of 3 attempts
    });

    test('should return success rate as percentage', () {
      expect(attempts.successRatePercentage, '66.7%');
    });

    test('should check if eventually correct', () {
      expect(attempts.eventuallyCorrect, true);

      final allIncorrect = attempts
          .map((a) => a.copyWith(isCorrect: false))
          .toList();
      expect(allIncorrect.eventuallyCorrect, false);
    });

    test('should return attempts to correct', () {
      expect(
        attempts.attemptsToCorrect,
        1,
      ); // Got it correct on first attempt for Q1
    });

    test('should return attempts with hints', () {
      final attemptsWithHints = attempts.attemptsWithHints;
      expect(attemptsWithHints.length, 0); // None have hintUsed: true

      final attemptWithHint = attempts.first.copyWith(hintUsed: true);
      final attemptsList = [attemptWithHint];
      expect(attemptsList.attemptsWithHints.length, 1);
    });

    test('should return attempts with explanations', () {
      final attemptsWithExplanations = attempts.attemptsWithExplanations;
      expect(
        attemptsWithExplanations.length,
        0,
      ); // None have explanationViewed: true
    });

    test('should return latest attempts for each attempt number', () {
      final moreAttempts = [
        ...attempts,
        QuestionAttempt(
          questionId: 'Q1',
          sessionId: 'S2', // Different session
          selectedAnswers: ['A'],
          isCorrect: true,
          attemptNumber: 1,
          timeSpent: const Duration(seconds: 25),
          timestamp: DateTime(2024, 1, 1, 11, 0),
        ),
      ];

      final latestAttempts = moreAttempts.latestAttempts;
      expect(latestAttempts.length, 2); // Two different attempt numbers
      expect(latestAttempts.first.attemptNumber, 1);
      expect(latestAttempts.last.attemptNumber, 2);
    });
  });
}
