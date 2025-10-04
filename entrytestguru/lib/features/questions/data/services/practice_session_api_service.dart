import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:entrytestguru/core/api/api_client.dart';
import '../models/practice_session.dart';

/// API service for practice session backend communication
/// Handles practice session management operations
class PracticeSessionApiService {
  final ApiClient _apiClient;

  PracticeSessionApiService(this._apiClient);

  /// Base path for practice endpoints
  static const String _practicePath = '/practice';

  /// Provider for dependency injection
  static final provider = Provider<PracticeSessionApiService>((ref) {
    final apiClient = ref.watch(apiClientProvider);
    return PracticeSessionApiService(apiClient);
  });

  /// Create a new practice session
  Future<String> createSession({
    required PracticeSessionFilter filterCriteria,
    PracticeSessionSettings? settings,
  }) async {
    try {
      print('PracticeSessionApiService: Creating practice session...');
      final request = PracticeSessionCreateRequest(
        filterCriteria: filterCriteria,
        settings: settings,
      );

      print(
        'PracticeSessionApiService: Request data: ${jsonEncode(request.toJson())}',
      );

      final response = await _apiClient.post(
        '$_practicePath/session',
        data: jsonEncode(request.toJson()),
      );

      print(
        'PracticeSessionApiService: Response status: ${response.statusCode}',
      );
      print('PracticeSessionApiService: Response data: ${response.data}');

      if (response.statusCode == 200) {
        return response.data['id'] as String;
      } else {
        throw Exception(
          'Failed to create practice session: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('PracticeSessionApiService: DioException: ${e.message}');
      print('PracticeSessionApiService: DioException type: ${e.type}');
      if (e.response != null) {
        print('PracticeSessionApiService: Error response: ${e.response?.data}');
        print(
          'PracticeSessionApiService: Error status: ${e.response?.statusCode}',
        );
      }
      throw _handleDioError(e, 'creating practice session');
    }
  }

  /// Get practice session by ID
  Future<PracticeSessionResponse> getSession(String sessionId) async {
    try {
      final response = await _apiClient.get(
        '$_practicePath/session/$sessionId',
      );

      if (response.statusCode == 200) {
        return PracticeSessionResponse.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to get practice session: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'getting practice session');
    }
  }

  /// Get user's practice sessions
  Future<List<PracticeSessionSummary>> getUserSessions({
    String? status,
    int limit = 20,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (status != null) queryParams['status'] = status;
      queryParams['limit'] = limit;

      final response = await _apiClient.get(
        '$_practicePath',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data
            .map((json) => PracticeSessionSummary.fromJson(json))
            .toList();
      } else {
        throw Exception(
          'Failed to get practice sessions: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'getting practice sessions');
    }
  }

  /// Update session progress
  Future<void> updateSessionProgress({
    required String sessionId,
    required int questionIndex,
    required int timeSpent,
  }) async {
    try {
      final request = PracticeSessionProgressUpdate(
        questionIndex: questionIndex,
        timeSpent: timeSpent,
      );

      final response = await _apiClient.put(
        '$_practicePath/session/$sessionId/progress',
        data: jsonEncode(request.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to update session progress: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'updating session progress');
    }
  }

  /// Record an answer attempt
  Future<String> recordAttempt({
    required String sessionId,
    required String questionId,
    required List<String> selectedAnswers,
    required int timeSpent,
    int attemptNumber = 1,
    bool explanationShown = false,
    bool hintUsed = false,
    String? notes,
  }) async {
    try {
      final request = PracticeSessionAttemptRequest(
        questionId: questionId,
        selectedAnswers: selectedAnswers,
        timeSpent: timeSpent,
        attemptNumber: attemptNumber,
        explanationShown: explanationShown,
        hintUsed: hintUsed,
        notes: notes,
      );

      final response = await _apiClient.post(
        '$_practicePath/session/$sessionId/attempt',
        data: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return response.data['id'] as String;
      } else {
        throw Exception('Failed to record attempt: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'recording attempt');
    }
  }

  /// Complete a practice session
  Future<void> completeSession(String sessionId) async {
    try {
      final response = await _apiClient.post(
        '$_practicePath/session/$sessionId/complete',
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to complete session: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'completing session');
    }
  }

  /// Pause a practice session
  Future<void> pauseSession(String sessionId) async {
    try {
      final response = await _apiClient.post(
        '$_practicePath/session/$sessionId/pause',
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to pause session: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'pausing session');
    }
  }

  /// Resume a practice session
  Future<void> resumeSession(String sessionId) async {
    try {
      final response = await _apiClient.post(
        '$_practicePath/session/$sessionId/resume',
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to resume session: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'resuming session');
    }
  }

  /// Get session attempts
  Future<List<PracticeSessionAttempt>> getSessionAttempts(
    String sessionId,
  ) async {
    try {
      final response = await _apiClient.get(
        '$_practicePath/session/$sessionId/attempts',
      );

      if (response.statusCode == 200) {
        final data = response.data['attempts'] as List<dynamic>;
        return data
            .map((json) => PracticeSessionAttempt.fromJson(json))
            .toList();
      } else {
        throw Exception(
          'Failed to get session attempts: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'getting session attempts');
    }
  }

  /// Get session statistics
  Future<PracticeSessionStatistics> getSessionStatistics(
    String sessionId,
  ) async {
    try {
      final response = await _apiClient.get(
        '$_practicePath/session/$sessionId/statistics',
      );

      if (response.statusCode == 200) {
        return PracticeSessionStatistics.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to get session statistics: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'getting session statistics');
    }
  }

  /// Delete a practice session
  Future<void> deleteSession(String sessionId) async {
    try {
      final response = await _apiClient.delete(
        '$_practicePath/session/$sessionId',
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete session: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'deleting session');
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
