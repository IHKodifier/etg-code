import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:entrytestguru/core/api/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/question.dart';
import '../models/question_filter.dart';
import '../models/question_attempt.dart';

/// API service for question-related backend communication
/// Handles HTTP requests to the FastAPI backend endpoints
class QuestionApiService {
  final ApiClient _apiClient;

  QuestionApiService(this._apiClient);

  /// Base path for question endpoints
  static const String _questionsPath = '/api/v1/questions';

  /// Provider for dependency injection
  static final provider = Provider<QuestionApiService>((ref) {
    final apiClient = ref.watch(apiClientProvider);
    return QuestionApiService(apiClient);
  });

  /// Fetches questions based on filter criteria with pagination
  /// Converts QuestionFilter to API parameters
  Future<List<Question>> getFilteredQuestions(
    QuestionFilter filter, {
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final queryParams = filter.toApiMap();
      queryParams['limit'] = limit;
      queryParams['offset'] = offset;

      final response = await _apiClient.get(
        _questionsPath,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['questions'] ?? [];
        return data.map((json) => Question.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch questions: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'fetching filtered questions');
    }
  }

  /// Fetches a single question by ID
  Future<Question?> getQuestion(String questionId) async {
    try {
      final response = await _apiClient.get('$_questionsPath/$questionId');

      if (response.statusCode == 200) {
        return Question.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return null; // Question not found
      } else {
        throw Exception('Failed to fetch question: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
      throw _handleDioError(e, 'fetching question $questionId');
    }
  }

  /// Searches for questions using text query
  Future<List<Question>> searchQuestions(
    String query, {
    String? examCategory,
    int limit = 20,
  }) async {
    try {
      final queryParams = {
        'q': query,
        'limit': limit,
        if (examCategory != null) 'exam_category': examCategory,
      };

      final response = await _apiClient.get(
        '$_questionsPath/search',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['questions'] ?? [];
        return data.map((json) => Question.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search questions: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'searching questions');
    }
  }

  /// Fetches questions optimized for practice
  Future<List<Question>> getQuestionsForPractice({
    required String examCategory,
    String? subject,
    String? topic,
    int limit = 20,
  }) async {
    try {
      final queryParams = {
        'exam_category': examCategory,
        'limit': limit,
        if (subject != null) 'subject': subject,
        if (topic != null) 'topic': topic,
      };

      final response = await _apiClient.get(
        '$_questionsPath/practice',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['questions'] ?? [];
        return data.map((json) => Question.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to fetch practice questions: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'fetching practice questions');
    }
  }

  /// Fetches questions for simulated exam
  Future<List<Question>> getQuestionsForExam({
    required String examCategory,
    int questionCount = 100,
    bool prioritizeHighArde = true,
  }) async {
    try {
      final queryParams = {
        'exam_category': examCategory,
        'count': questionCount,
        'prioritize_high_arde': prioritizeHighArde,
      };

      final response = await _apiClient.get(
        '$_questionsPath/exam',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['questions'] ?? [];
        return data.map((json) => Question.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to fetch exam questions: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'fetching exam questions');
    }
  }

  /// Records a question attempt
  Future<void> recordAttempt(QuestionAttempt attempt) async {
    try {
      final response = await _apiClient.post(
        '$_questionsPath/attempt',
        data: jsonEncode(attempt.toJson()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to record attempt: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'recording attempt');
    }
  }

  /// Fetches attempt history for a question
  Future<List<QuestionAttempt>> getQuestionAttempts(
    String questionId, {
    String? userId,
  }) async {
    try {
      final queryParams = {if (userId != null) 'user_id': userId};

      final response = await _apiClient.get(
        '$_questionsPath/$questionId/attempts',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['attempts'] ?? [];
        return data.map((json) => QuestionAttempt.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch attempts: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'fetching question attempts');
    }
  }

  /// Fetches attempts for a session
  Future<List<QuestionAttempt>> getSessionAttempts(String sessionId) async {
    try {
      final response = await _apiClient.get(
        '/api/v1/sessions/$sessionId/attempts',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['attempts'] ?? [];
        return data.map((json) => QuestionAttempt.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to fetch session attempts: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'fetching session attempts');
    }
  }

  /// Toggles bookmark status for a question
  Future<void> toggleBookmark(String questionId, {String? userId}) async {
    try {
      final data = {
        'question_id': questionId,
        if (userId != null) 'user_id': userId,
      };

      final response = await _apiClient.post(
        '$_questionsPath/bookmark',
        data: jsonEncode(data),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to toggle bookmark: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'toggling bookmark');
    }
  }

  /// Fetches bookmarked questions
  Future<List<Question>> getBookmarkedQuestions({String? userId}) async {
    try {
      final queryParams = {if (userId != null) 'user_id': userId};

      final response = await _apiClient.get(
        '$_questionsPath/bookmarks',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['questions'] ?? [];
        return data.map((json) => Question.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch bookmarks: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'fetching bookmarks');
    }
  }

  /// Adds a note to a question
  Future<void> addQuestionNote(
    String questionId,
    String note, {
    String? userId,
  }) async {
    try {
      final data = {
        'question_id': questionId,
        'note': note,
        if (userId != null) 'user_id': userId,
      };

      final response = await _apiClient.post(
        '$_questionsPath/note',
        data: jsonEncode(data),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to add note: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'adding note');
    }
  }

  /// Fetches questions for weak areas
  Future<List<Question>> getWeakAreaQuestions({
    String? examCategory,
    int limit = 20,
  }) async {
    try {
      final queryParams = {
        'limit': limit,
        if (examCategory != null) 'exam_category': examCategory,
      };

      final response = await _apiClient.get(
        '$_questionsPath/weak-areas',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['questions'] ?? [];
        return data.map((json) => Question.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch weak areas: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'fetching weak areas');
    }
  }

  /// Fetches unattempted questions
  Future<List<Question>> getUnattemptedQuestions({
    String? examCategory,
    String? subject,
    int limit = 20,
  }) async {
    try {
      final queryParams = {
        'limit': limit,
        if (examCategory != null) 'exam_category': examCategory,
        if (subject != null) 'subject': subject,
      };

      final response = await _apiClient.get(
        '$_questionsPath/unattempted',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['questions'] ?? [];
        return data.map((json) => Question.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to fetch unattempted questions: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'fetching unattempted questions');
    }
  }

  /// Fetches high ARDE probability questions
  Future<List<Question>> getHighArdeQuestions({
    String? examCategory,
    int limit = 20,
  }) async {
    try {
      final queryParams = {
        'limit': limit,
        if (examCategory != null) 'exam_category': examCategory,
      };

      final response = await _apiClient.get(
        '$_questionsPath/high-arde',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['questions'] ?? [];
        return data.map((json) => Question.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to fetch high ARDE questions: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'fetching high ARDE questions');
    }
  }

  /// Gets question statistics
  Future<Map<String, dynamic>> getQuestionStats(String questionId) async {
    try {
      final response = await _apiClient.get(
        '$_questionsPath/$questionId/stats',
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch stats: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'fetching question stats');
    }
  }

  // Subscription Management Methods

  /// Upgrades anonymous user to registered account
  Future<Map<String, dynamic>> upgradeAnonymousToRegistered({
    required String email,
    required String password,
    required String examType,
  }) async {
    try {
      final data = {
        'email': email,
        'password': password,
        'exam_type': examType,
      };

      final response = await _apiClient.post(
        '$_questionsPath/subscription/upgrade-anonymous',
        data: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to upgrade account: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'upgrading anonymous account');
    }
  }

  /// Upgrades user to pro tier
  Future<Map<String, dynamic>> upgradeToProTier(String paymentToken) async {
    try {
      final data = {'payment_token': paymentToken};

      final response = await _apiClient.post(
        '$_questionsPath/subscription/upgrade-to-pro',
        data: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to upgrade to pro: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'upgrading to pro tier');
    }
  }

  /// Gets current user's subscription status
  Future<Map<String, dynamic>> getSubscriptionStatus() async {
    try {
      final response = await _apiClient.get(
        '$_questionsPath/subscription/status',
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
          'Failed to get subscription status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'getting subscription status');
    }
  }

  /// Gets current user's usage limits
  Future<Map<String, dynamic>> getUsageLimits() async {
    try {
      final response = await _apiClient.get(
        '$_questionsPath/subscription/limits',
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get usage limits: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'getting usage limits');
    }
  }

  /// Handles Dio errors and converts them to user-friendly exceptions
  Exception _handleDioError(DioException error, String operation) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception(
          'Connection timeout while $operation. Please check your internet connection.',
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] ?? 'Unknown error';

        switch (statusCode) {
          case 400:
            return Exception('Invalid request while $operation: $message');
          case 401:
            return Exception('Authentication required. Please log in again.');
          case 403:
            return Exception('Access denied while $operation.');
          case 404:
            return Exception('Resource not found while $operation.');
          case 429:
            return Exception('Too many requests. Please wait and try again.');
          case 500:
            return Exception(
              'Server error while $operation. Please try again later.',
            );
          default:
            return Exception('Request failed while $operation: $message');
        }

      case DioExceptionType.cancel:
        return Exception('Request was cancelled while $operation.');

      default:
        return Exception(
          'Network error while $operation. Please check your connection.',
        );
    }
  }
}
