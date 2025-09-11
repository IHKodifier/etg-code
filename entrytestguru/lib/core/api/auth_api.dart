import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../models/device.dart';
import '../services/device_fingerprint_service.dart';
import 'api_client.dart';

final authApiServiceProvider = Provider<AuthApiService>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return AuthApiService(apiClient);
});

class AuthApiService {
  final ApiClient _apiClient;
  final DeviceFingerprintService _deviceFingerprintService =
      DeviceFingerprintService();

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

  /// Check device limit for current user
  Future<DeviceLimitResponse> checkDeviceLimit() async {
    try {
      final response = await _apiClient.get('/auth/device-limit');

      if (response.statusCode == 200) {
        return DeviceLimitResponse.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to check device limit: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Authentication required');
      }
      throw Exception('Failed to check device limit: ${e.message}');
    } catch (e) {
      throw Exception('Failed to check device limit: $e');
    }
  }

  /// Register device for current user
  Future<DeviceLimitResponse> registerDevice({
    required String deviceFingerprint,
    String? deviceName,
  }) async {
    try {
      final deviceInfo = await _getDeviceInfo();

      final response = await _apiClient.post(
        '/auth/register-device',
        data: {
          'device_fingerprint': deviceFingerprint,
          'device_name': deviceName,
          'device_info': deviceInfo,
        },
      );

      if (response.statusCode == 200) {
        return DeviceLimitResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to register device: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Authentication required');
      } else if (e.response?.statusCode == 429) {
        throw Exception('Device limit exceeded');
      }
      throw Exception('Failed to register device: ${e.message}');
    } catch (e) {
      throw Exception('Failed to register device: $e');
    }
  }

  /// Remove device from current user
  Future<DeviceLimitResponse> removeDevice(String deviceId) async {
    try {
      final response = await _apiClient.delete('/auth/devices/$deviceId');

      if (response.statusCode == 200) {
        return DeviceLimitResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to remove device: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Authentication required');
      } else if (e.response?.statusCode == 404) {
        throw Exception('Device not found');
      }
      throw Exception('Failed to remove device: ${e.message}');
    } catch (e) {
      throw Exception('Failed to remove device: $e');
    }
  }

  /// Update device name
  Future<DeviceInfo> updateDeviceName({
    required String deviceId,
    required String deviceName,
  }) async {
    try {
      final response = await _apiClient.put(
        '/auth/devices/$deviceId',
        data: {'device_name': deviceName},
      );

      if (response.statusCode == 200) {
        return DeviceInfo.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to update device name: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Authentication required');
      } else if (e.response?.statusCode == 404) {
        throw Exception('Device not found');
      }
      throw Exception('Failed to update device name: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update device name: $e');
    }
  }

  /// Get all devices for current user
  Future<List<DeviceInfo>> getUserDevices() async {
    try {
      final response = await _apiClient.get('/auth/devices');

      if (response.statusCode == 200) {
        final List<dynamic> devicesJson = response.data;
        return devicesJson.map((json) => DeviceInfo.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to get user devices: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Authentication required');
      }
      throw Exception('Failed to get user devices: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get user devices: $e');
    }
  }

  Future<Map<String, dynamic>> _getDeviceInfo() async {
    try {
      final deviceInfo = await _deviceFingerprintService.getDeviceInfo();
      final fingerprint = await _deviceFingerprintService
          .generateDeviceFingerprint();

      return {
        ...deviceInfo,
        'fingerprint': fingerprint,
        'app_version': '1.0.0',
      };
    } catch (e) {
      print('Error getting device info: $e');
      // Fallback to basic info
      return {
        'platform': 'flutter',
        'app_version': '1.0.0',
        'timestamp': DateTime.now().toIso8601String(),
        'fingerprint': 'fallback_fingerprint',
      };
    }
  }
}

// Use authApiServiceProvider instead of global instance
// Access via: ref.read(authApiServiceProvider)
// NOTE: This class is deprecated in favor of direct Firebase authentication
