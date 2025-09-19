import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:entrytestguru/features/questions/data/services/question_api_service.dart';
import 'package:entrytestguru/features/questions/data/models/question.dart';
import 'package:entrytestguru/features/questions/data/models/question_filter.dart';
import 'package:entrytestguru/features/questions/data/models/question_attempt.dart';
import 'package:entrytestguru/core/api/api_client.dart';

@GenerateMocks([ApiClient])
import 'question_api_service_test.mocks.dart';

void main() {
  late MockApiClient mockApiClient;
  late QuestionApiService apiService;

  setUp(() {
    mockApiClient = MockApiClient();
    apiService = QuestionApiService(mockApiClient);
  });

  group('QuestionApiService Tests', () {
    test('should create service with api client', () {
      expect(apiService, isNotNull);
    });

    group('getFilteredQuestions', () {
      test('should return questions on successful response', () async {
        final mockResponse = Response(
          data: {
            'questions': [
              {
                'id': 'Q1',
                'questionId': 'Q1',
                'examCategory': 'ECAT',
                'subject': 'Physics',
                'topic': 'Kinematics',
                'questionText': 'Test question',
                'options': [
                  {'id': 'A', 'text': 'Option A'},
                  {'id': 'B', 'text': 'Option B'},
                ],
                'correctAnswer': ['A'],
                'questionType': 'singleChoice',
                'explanationText': 'Test explanation',
                'ardeProbability': 'high',
                'difficulty': 'medium',
                'estimatedTimeSeconds': 60,
                'globalStats': {
                  'totalAttempts': 100,
                  'totalCorrect': 75,
                  'globalAccuracy': 0.75,
                  'averageTimeSeconds': 45.0,
                  'medianTimeSeconds': 42.0,
                  'p95TimeSeconds': 120.0,
                  'calculatedDifficulty': 0.6,
                },
                'tags': ['test'],
                'createdAt': '2024-01-01T00:00:00.000Z',
                'updatedAt': '2024-01-01T00:00:00.000Z',
                'createdBy': 'admin',
                'isActive': true,
                'version': 1,
                'status': 'approved',
              },
            ],
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: '/api/v1/questions'),
        );

        when(
          mockApiClient.get(
            '/api/v1/questions',
            queryParameters: anyNamed('queryParameters'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final filter = QuestionFilter(examCategories: ['ECAT']);
        final result = await apiService.getFilteredQuestions(filter);

        expect(result, isA<List<Question>>());
        expect(result.length, 1);
        expect(result.first.id, 'Q1');
        expect(result.first.examCategory, 'ECAT');
      });

      test('should throw exception on error response', () async {
        final mockResponse = Response(
          data: {'message': 'Server error'},
          statusCode: 500,
          requestOptions: RequestOptions(path: '/api/v1/questions'),
        );

        when(
          mockApiClient.get(
            '/api/v1/questions',
            queryParameters: anyNamed('queryParameters'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final filter = QuestionFilter();
        expect(
          () => apiService.getFilteredQuestions(filter),
          throwsA(isA<Exception>()),
        );
      });

      test('should handle DioException', () async {
        when(
          mockApiClient.get(
            '/api/v1/questions',
            queryParameters: anyNamed('queryParameters'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/api/v1/questions'),
            type: DioExceptionType.connectionTimeout,
          ),
        );

        final filter = QuestionFilter();
        expect(
          () => apiService.getFilteredQuestions(filter),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('getQuestion', () {
      test('should return question on successful response', () async {
        final mockResponse = Response(
          data: {
            'id': 'Q1',
            'questionId': 'Q1',
            'examCategory': 'ECAT',
            'subject': 'Physics',
            'topic': 'Kinematics',
            'questionText': 'Test question',
            'options': [
              {'id': 'A', 'text': 'Option A'},
            ],
            'correctAnswer': ['A'],
            'questionType': 'singleChoice',
            'explanationText': 'Test explanation',
            'ardeProbability': 'high',
            'difficulty': 'medium',
            'estimatedTimeSeconds': 60,
            'globalStats': {
              'totalAttempts': 100,
              'totalCorrect': 75,
              'globalAccuracy': 0.75,
              'averageTimeSeconds': 45.0,
              'medianTimeSeconds': 42.0,
              'p95TimeSeconds': 120.0,
              'calculatedDifficulty': 0.6,
            },
            'tags': ['test'],
            'createdAt': '2024-01-01T00:00:00.000Z',
            'updatedAt': '2024-01-01T00:00:00.000Z',
            'createdBy': 'admin',
            'isActive': true,
            'version': 1,
            'status': 'approved',
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: '/api/v1/questions/Q1'),
        );

        when(
          mockApiClient.get('/api/v1/questions/Q1'),
        ).thenAnswer((_) async => mockResponse);

        final result = await apiService.getQuestion('Q1');

        expect(result, isA<Question>());
        expect(result?.id, 'Q1');
      });

      test('should return null for 404 response', () async {
        final mockResponse = Response(
          data: {'message': 'Question not found'},
          statusCode: 404,
          requestOptions: RequestOptions(path: '/api/v1/questions/Q999'),
        );

        when(
          mockApiClient.get('/api/v1/questions/Q999'),
        ).thenAnswer((_) async => mockResponse);

        final result = await apiService.getQuestion('Q999');
        expect(result, null);
      });
    });

    group('searchQuestions', () {
      test('should return questions on successful search', () async {
        final mockResponse = Response(
          data: {
            'questions': [
              {
                'id': 'Q1',
                'questionId': 'Q1',
                'examCategory': 'ECAT',
                'subject': 'Physics',
                'topic': 'Kinematics',
                'questionText': 'What is velocity?',
                'options': [
                  {'id': 'A', 'text': 'Speed with direction'},
                ],
                'correctAnswer': ['A'],
                'questionType': 'singleChoice',
                'explanationText': 'Velocity includes direction',
                'ardeProbability': 'high',
                'difficulty': 'easy',
                'estimatedTimeSeconds': 30,
                'globalStats': {
                  'totalAttempts': 50,
                  'totalCorrect': 40,
                  'globalAccuracy': 0.8,
                  'averageTimeSeconds': 25.0,
                  'medianTimeSeconds': 22.0,
                  'p95TimeSeconds': 60.0,
                  'calculatedDifficulty': 0.3,
                },
                'tags': ['physics', 'velocity'],
                'createdAt': '2024-01-01T00:00:00.000Z',
                'updatedAt': '2024-01-01T00:00:00.000Z',
                'createdBy': 'admin',
                'isActive': true,
                'version': 1,
                'status': 'approved',
              },
            ],
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: '/api/v1/questions/search'),
        );

        when(
          mockApiClient.get(
            '/api/v1/questions/search',
            queryParameters: anyNamed('queryParameters'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final result = await apiService.searchQuestions(
          'velocity',
          examCategory: 'ECAT',
          limit: 10,
        );

        expect(result, isA<List<Question>>());
        expect(result.length, 1);
        expect(result.first.questionText, 'What is velocity?');
      });
    });

    group('recordAttempt', () {
      test('should record attempt successfully', () async {
        final mockResponse = Response(
          data: {'message': 'Attempt recorded'},
          statusCode: 200,
          requestOptions: RequestOptions(path: '/api/v1/questions/attempt'),
        );

        when(
          mockApiClient.post(
            '/api/v1/questions/attempt',
            data: anyNamed('data'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final attempt = QuestionAttempt(
          questionId: 'Q1',
          sessionId: 'S1',
          selectedAnswers: ['A'],
          isCorrect: true,
          timeSpent: const Duration(seconds: 30),
          timestamp: DateTime.now(),
        );

        expect(
          () async => await apiService.recordAttempt(attempt),
          returnsNormally,
        );
      });

      test('should handle recording error', () async {
        final mockResponse = Response(
          data: {'message': 'Failed to record attempt'},
          statusCode: 400,
          requestOptions: RequestOptions(path: '/api/v1/questions/attempt'),
        );

        when(
          mockApiClient.post(
            '/api/v1/questions/attempt',
            data: anyNamed('data'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final attempt = QuestionAttempt(
          questionId: 'Q1',
          sessionId: 'S1',
          selectedAnswers: ['A'],
          isCorrect: true,
          timeSpent: const Duration(seconds: 30),
          timestamp: DateTime.now(),
        );

        expect(
          () => apiService.recordAttempt(attempt),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('getQuestionAttempts', () {
      test('should return attempts on successful response', () async {
        final mockResponse = Response(
          data: {
            'attempts': [
              {
                'questionId': 'Q1',
                'sessionId': 'S1',
                'selectedAnswers': ['A'],
                'isCorrect': true,
                'attemptNumber': 1,
                'timeSpent': 30000000,
                'timestamp': '2024-01-01T12:00:00.000Z',
              },
            ],
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: '/api/v1/questions/Q1/attempts'),
        );

        when(
          mockApiClient.get(
            '/api/v1/questions/Q1/attempts',
            queryParameters: anyNamed('queryParameters'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final result = await apiService.getQuestionAttempts('Q1');

        expect(result, isA<List<QuestionAttempt>>());
        expect(result.length, 1);
        expect(result.first.questionId, 'Q1');
      });
    });

    group('toggleBookmark', () {
      test('should toggle bookmark successfully', () async {
        final mockResponse = Response(
          data: {'message': 'Bookmark toggled'},
          statusCode: 200,
          requestOptions: RequestOptions(path: '/api/v1/questions/bookmark'),
        );

        when(
          mockApiClient.post(
            '/api/v1/questions/bookmark',
            data: anyNamed('data'),
          ),
        ).thenAnswer((_) async => mockResponse);

        expect(
          () async => await apiService.toggleBookmark('Q1'),
          returnsNormally,
        );
      });
    });

    group('getBookmarkedQuestions', () {
      test('should return bookmarked questions', () async {
        final mockResponse = Response(
          data: {
            'questions': [
              {
                'id': 'Q1',
                'questionId': 'Q1',
                'examCategory': 'ECAT',
                'subject': 'Physics',
                'topic': 'Kinematics',
                'questionText': 'Bookmarked question',
                'options': [
                  {'id': 'A', 'text': 'Option A'},
                ],
                'correctAnswer': ['A'],
                'questionType': 'singleChoice',
                'explanationText': 'Test explanation',
                'ardeProbability': 'high',
                'difficulty': 'medium',
                'estimatedTimeSeconds': 60,
                'globalStats': {
                  'totalAttempts': 100,
                  'totalCorrect': 75,
                  'globalAccuracy': 0.75,
                  'averageTimeSeconds': 45.0,
                  'medianTimeSeconds': 42.0,
                  'p95TimeSeconds': 120.0,
                  'calculatedDifficulty': 0.6,
                },
                'tags': ['bookmarked'],
                'createdAt': '2024-01-01T00:00:00.000Z',
                'updatedAt': '2024-01-01T00:00:00.000Z',
                'createdBy': 'admin',
                'isActive': true,
                'version': 1,
                'status': 'approved',
              },
            ],
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: '/api/v1/questions/bookmarks'),
        );

        when(
          mockApiClient.get(
            '/api/v1/questions/bookmarks',
            queryParameters: anyNamed('queryParameters'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final result = await apiService.getBookmarkedQuestions();

        expect(result, isA<List<Question>>());
        expect(result.length, 1);
        expect(result.first.tags, contains('bookmarked'));
      });
    });

    group('getQuestionStats', () {
      test('should return question stats', () async {
        final mockResponse = Response(
          data: {
            'totalAttempts': 100,
            'totalCorrect': 75,
            'accuracy': 0.75,
            'averageTime': 45.0,
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: '/api/v1/questions/Q1/stats'),
        );

        when(
          mockApiClient.get('/api/v1/questions/Q1/stats'),
        ).thenAnswer((_) async => mockResponse);

        final result = await apiService.getQuestionStats('Q1');

        expect(result, isA<Map<String, dynamic>>());
        expect(result['totalAttempts'], 100);
        expect(result['accuracy'], 0.75);
      });
    });
  });
}
