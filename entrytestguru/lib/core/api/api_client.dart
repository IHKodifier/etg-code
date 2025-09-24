import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import '../services/firebase_auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

final apiClientProvider = Provider<ApiClient>((ref) {
  final firebaseAuthService = ref.read(authServiceProvider);
  return ApiClient(firebaseAuthService);
});

class ApiClient {
  // Use different URLs for web vs mobile/desktop
  static String get baseUrl {
    // Web browsers can't connect to localhost, so use 127.0.0.1 for web
    // Backend runs on port 8080 to avoid conflict with Flutter web app on 8080
    if (kIsWeb) {
      return 'http://127.0.0.1:8080/api/v1';
    }
    return 'http://localhost:8080/api/v1';
  }

  static const _storage = FlutterSecureStorage();

  late final Dio _dio;
  final FirebaseAuthService _firebaseAuthService;

  ApiClient(this._firebaseAuthService) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    // Request interceptor to add backend JWT token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await getStoredToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // Try to refresh token
            final refreshed = await _refreshToken();
            if (refreshed) {
              // Retry the request
              final options = error.requestOptions;
              final token = await getStoredToken();
              if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
              }
              try {
                final response = await _dio.fetch(options);
                handler.resolve(response);
                return;
              } catch (e) {
                // If retry fails, continue with original error
              }
            }
            // Clear tokens and redirect to login
            await clearTokens();
          }
          handler.next(error);
        },
      ),
    );
  }

  // Backend JWT token management
  Future<String?> getToken() async {
    return await getStoredToken();
  }

  Future<String?> getStoredToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<String?> getStoredRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  Future<String?> getRefreshToken() async {
    return await getStoredRefreshToken();
  }

  Future<void> setTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
    await _storage.delete(key: 'user_data');
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await getStoredRefreshToken();
      if (refreshToken == null) return false;

      // Call backend refresh endpoint
      final response = await _dio.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
        options: Options(headers: {}), // Don't add auth header for refresh
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['access_token'];
        final newRefreshToken = response.data['refresh_token'];
        await setTokens(newAccessToken, newRefreshToken);
        return true;
      }

      return false;
    } catch (e) {
      print('Token refresh failed: $e');
      return false;
    }
  }

  // HTTP Methods
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}

// Use apiClientProvider instead of global instance
// Access via: ref.read(apiClientProvider)
