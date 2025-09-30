import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/api_client.dart';

/// API service for user-related backend communication
/// Handles user management operations like subscriptions and upgrades
class UserApiService {
  final ApiClient _apiClient;

  UserApiService(this._apiClient);

  /// Base path for user endpoints
  static const String _usersPath = '/users';

  /// Provider for dependency injection
  static final provider = Provider<UserApiService>((ref) {
    final apiClient = ref.watch(apiClientProvider);
    return UserApiService(apiClient);
  });

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
        '$_usersPath/subscription/upgrade-anonymous',
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
        '$_usersPath/subscription/upgrade-to-pro',
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
      final response = await _apiClient.get('$_usersPath/subscription/status');

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
      final response = await _apiClient.get('$_usersPath/subscription/limits');

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
