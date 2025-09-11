import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:crypto/crypto.dart';
import 'dart:convert';

class DeviceFingerprintService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  /// Generate a unique device fingerprint for device management
  Future<String> generateDeviceFingerprint() async {
    try {
      final deviceInfo = await _getDeviceInfo();
      final fingerprintData = _createFingerprintData(deviceInfo);

      // Create SHA-256 hash of the fingerprint data
      final fingerprintString = jsonEncode(fingerprintData);
      final bytes = utf8.encode(fingerprintString);
      final digest = sha256.convert(bytes);

      return digest.toString();
    } catch (e) {
      print('Error generating device fingerprint: $e');
      // Fallback to a basic fingerprint
      return _generateFallbackFingerprint();
    }
  }

  /// Get detailed device information
  Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      return await _getDeviceInfo();
    } catch (e) {
      print('Error getting device info: $e');
      return _getFallbackDeviceInfo();
    }
  }

  Future<Map<String, dynamic>> _getDeviceInfo() async {
    if (kIsWeb) {
      final webInfo = await _deviceInfo.webBrowserInfo;
      return {
        'platform': 'web',
        'browserName': webInfo.browserName?.name ?? 'unknown',
        'userAgent': webInfo.userAgent ?? 'unknown',
        'vendor': webInfo.vendor ?? 'unknown',
        'platform': webInfo.platform ?? 'unknown',
        'language': webInfo.language ?? 'unknown',
        'cookieEnabled': false, // Not available in current API
        'hardwareConcurrency': webInfo.hardwareConcurrency ?? 0,
        'maxTouchPoints': webInfo.maxTouchPoints ?? 0,
        'deviceMemory': webInfo.deviceMemory ?? 0,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } else if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return {
        'platform': 'android',
        'id': androidInfo.id,
        'androidId': androidInfo.id, // Using id as unique identifier
        'brand': androidInfo.brand,
        'device': androidInfo.device,
        'model': androidInfo.model,
        'product': androidInfo.product,
        'hardware': androidInfo.hardware,
        'fingerprint': androidInfo.fingerprint,
        'manufacturer': androidInfo.manufacturer,
        'serialNumber': androidInfo.serialNumber,
        'isPhysicalDevice': androidInfo.isPhysicalDevice,
        'sdkInt': androidInfo.version.sdkInt,
        'release': androidInfo.version.release,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      return {
        'platform': 'ios',
        'identifierForVendor': iosInfo.identifierForVendor,
        'name': iosInfo.name,
        'systemName': iosInfo.systemName,
        'systemVersion': iosInfo.systemVersion,
        'model': iosInfo.model,
        'localizedModel': iosInfo.localizedModel,
        'isPhysicalDevice': iosInfo.isPhysicalDevice,
        'utsname': {
          'sysname': iosInfo.utsname.sysname,
          'nodename': iosInfo.utsname.nodename,
          'release': iosInfo.utsname.release,
          'version': iosInfo.utsname.version,
          'machine': iosInfo.utsname.machine,
        },
        'timestamp': DateTime.now().toIso8601String(),
      };
    } else {
      // Fallback for other platforms
      return _getFallbackDeviceInfo();
    }
  }

  Map<String, dynamic> _createFingerprintData(Map<String, dynamic> deviceInfo) {
    // Create a consistent fingerprint by selecting stable device identifiers
    final fingerprint = <String, dynamic>{};

    if (kIsWeb) {
      fingerprint.addAll({
        'platform': deviceInfo['platform'],
        'browserName': deviceInfo['browserName'],
        'vendor': deviceInfo['vendor'],
        'platform_string': deviceInfo['platform'],
        'language': deviceInfo['language'],
        'hardwareConcurrency': deviceInfo['hardwareConcurrency'],
        'maxTouchPoints': deviceInfo['maxTouchPoints'],
        'deviceMemory': deviceInfo['deviceMemory'],
      });
    } else if (deviceInfo['platform'] == 'android') {
      fingerprint.addAll({
        'platform': deviceInfo['platform'],
        'androidId': deviceInfo['id'],
        'brand': deviceInfo['brand'],
        'device': deviceInfo['device'],
        'model': deviceInfo['model'],
        'manufacturer': deviceInfo['manufacturer'],
        'hardware': deviceInfo['hardware'],
        'fingerprint': deviceInfo['fingerprint'],
      });
    } else if (deviceInfo['platform'] == 'ios') {
      fingerprint.addAll({
        'platform': deviceInfo['platform'],
        'identifierForVendor': deviceInfo['identifierForVendor'],
        'model': deviceInfo['model'],
        'systemName': deviceInfo['systemName'],
        'systemVersion': deviceInfo['systemVersion'],
      });
    }

    // Add timestamp for uniqueness (but stable for same device)
    fingerprint['timestamp'] = DateTime.now().toIso8601String().split(
      'T',
    )[0]; // Date only

    return fingerprint;
  }

  String _generateFallbackFingerprint() {
    // Generate a fallback fingerprint using timestamp and random data
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final randomData = 'fallback_device_fingerprint';
    final combined = timestamp + randomData;
    final bytes = utf8.encode(combined);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Map<String, dynamic> _getFallbackDeviceInfo() {
    return {
      'platform': 'unknown',
      'model': 'unknown',
      'manufacturer': 'unknown',
      'isPhysicalDevice': true,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  /// Check if device fingerprinting is supported on current platform
  bool isFingerprintingSupported() {
    if (kIsWeb) return true;
    if (Platform.isAndroid) return true;
    if (Platform.isIOS) return true;
    return false;
  }

  /// Get device type for UI display
  Future<String> getDeviceType() async {
    try {
      final deviceInfo = await _getDeviceInfo();

      if (kIsWeb) {
        return 'Web Browser';
      } else if (deviceInfo['platform'] == 'android') {
        return '${deviceInfo['brand']} ${deviceInfo['model']}';
      } else if (deviceInfo['platform'] == 'ios') {
        return '${deviceInfo['model']}';
      } else {
        return 'Unknown Device';
      }
    } catch (e) {
      return 'Unknown Device';
    }
  }

  /// Get platform name
  Future<String> getPlatformName() async {
    if (kIsWeb) return 'Web';
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    return 'Unknown';
  }
}
