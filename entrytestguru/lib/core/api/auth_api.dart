import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import 'api_client.dart';

final authApiServiceProvider = Provider<AuthApiService>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return AuthApiService(apiClient);
});

class AuthApiService {
  final ApiClient _apiClient;

  AuthApiService(this._apiClient);

  Future<AuthTokens> login(String email, String password) async {
    try {
      final response = await _apiClient.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final authTokens =
            AuthTokens.fromJson(response.data as Map<String, dynamic>)
                as AuthTokens;

        // Store tokens
        await _apiClient.setTokens(
          authTokens.accessToken,
          authTokens.refreshToken,
        );

        return authTokens;
      } else {
        throw Exception('Login failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Invalid credentials');
      }
      throw Exception('Login failed: ${e.message}');
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<User> register({
    required String email,
    required String password,
    required String examType,
    Map<String, dynamic>? profile,
  }) async {
    try {
      final deviceInfo = await _getDeviceInfo();

      final response = await _apiClient.post(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'exam_type': examType,
          'device_info': deviceInfo,
          'profile': profile ?? {},
        },
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Registration failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw Exception('User with this email already exists');
      } else if (e.response?.statusCode == 400) {
        throw Exception('Invalid registration data');
      }
      throw Exception('Registration failed: ${e.message}');
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<AuthTokens> googleSignIn(String idToken, {String? examType}) async {
    try {
      final deviceInfo = await _getDeviceInfo();

      final response = await _apiClient.post(
        '/auth/google',
        data: {
          'id_token': idToken,
          'device_info': deviceInfo,
          'exam_type': examType,
        },
      );

      if (response.statusCode == 200) {
        final authTokens = AuthTokens.fromJson(
          response.data as Map<String, dynamic>,
        );

        // Store tokens
        await _apiClient.setTokens(
          authTokens.accessToken,
          authTokens.refreshToken,
        );

        return authTokens;
      } else {
        throw Exception('Google sign-in failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Invalid Google token');
      }
      throw Exception('Google sign-in failed: ${e.message}');
    } catch (e) {
      throw Exception('Google sign-in failed: $e');
    }
  }

  Future<AuthTokens> anonymousLogin() async {
    try {
      final deviceInfo = await _getDeviceInfo();

      final response = await _apiClient.post(
        '/auth/anonymous',
        data: deviceInfo,
      );

      if (response.statusCode == 200) {
        final authTokens = AuthTokens.fromJson(
          response.data as Map<String, dynamic>,
        );

        // Store tokens
        await _apiClient.setTokens(
          authTokens.accessToken,
          authTokens.refreshToken,
        );

        return authTokens;
      } else {
        throw Exception('Anonymous login failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Anonymous login failed: ${e.message}');
    } catch (e) {
      throw Exception('Anonymous login failed: $e');
    }
  }

  Future<User> getCurrentUser() async {
    try {
      final response = await _apiClient.get('/auth/me');

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to get current user: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Authentication required');
      }
      throw Exception('Failed to get current user: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  Future<void> logout() async {
    try {
      // Clear local tokens
      await _apiClient.clearTokens();

      // Note: Backend doesn't have logout endpoint yet,
      // but tokens will expire naturally
    } catch (e) {
      // Even if API call fails, clear local tokens
      await _apiClient.clearTokens();
      throw Exception('Logout failed: $e');
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _apiClient.getToken();
    return token != null;
  }

  Future<Map<String, dynamic>> _getDeviceInfo() async {
    // This would typically use device_info_plus to get actual device info
    // For now, returning basic info
    return {
      'platform': 'flutter',
      'app_version': '1.0.0',
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}

// Use authApiServiceProvider instead of global instance
// Access via: ref.read(authApiServiceProvider)
// NOTE: This class is deprecated in favor of direct Firebase authentication
