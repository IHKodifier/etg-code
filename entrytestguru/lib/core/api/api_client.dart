import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/firebase_auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

final apiClientProvider = Provider<ApiClient>((ref) {
  final firebaseAuthService = ref.read(firebaseAuthServiceProvider);
  return ApiClient(firebaseAuthService);
});

class ApiClient {
  static const String baseUrl = 'http://localhost:8000/api/v1';
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
    // Request interceptor to add Firebase ID token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _firebaseAuthService.getIdToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // Try to refresh Firebase ID token
            final refreshed = await _refreshFirebaseToken();
            if (refreshed) {
              // Retry the request
              final options = error.requestOptions;
              final token = await _firebaseAuthService.getIdToken();
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

  // Firebase token management
  Future<String?> getToken() async {
    return await _firebaseAuthService.getIdToken();
  }

  Future<String?> getRefreshToken() async {
    // Firebase handles refresh tokens automatically
    return 'firebase_refresh_token';
  }

  Future<void> setTokens(String accessToken, String refreshToken) async {
    // Firebase handles token management automatically
    // We don't need to store tokens manually
    print('Firebase handles token management automatically');
  }

  Future<void> clearTokens() async {
    // Sign out from Firebase to clear tokens
    await _firebaseAuthService.signOut();
    await _storage.delete(key: 'user_data');
  }

  Future<bool> _refreshFirebaseToken() async {
    try {
      // Firebase automatically refreshes tokens
      // Just check if we can get a current token
      final token = await _firebaseAuthService.getIdToken();
      return token != null;
    } catch (e) {
      print('Firebase token refresh failed: $e');
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
