import 'package:freezed_annotation/freezed_annotation.dart';

part 'device.freezed.dart';
part 'device.g.dart';

@freezed
class DeviceInfo with _$DeviceInfo {
  const factory DeviceInfo({
    required String id,
    required String fingerprint,
    required String platform,
    required String deviceType,
    required String deviceName,
    required Map<String, dynamic> deviceDetails,
    required DateTime firstLoginAt,
    required DateTime lastLoginAt,
    required bool isActive,
    @JsonKey(name: 'is_current_device') required bool isCurrentDevice,
  }) = _DeviceInfo;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
}

@freezed
class DeviceLimit with _$DeviceLimit {
  const factory DeviceLimit({
    required int maxDevices,
    required int currentDevices,
    required bool isLimitExceeded,
    required List<DeviceInfo> devices,
  }) = _DeviceLimit;

  factory DeviceLimit.fromJson(Map<String, dynamic> json) =>
      _$DeviceLimitFromJson(json);
}

@freezed
class DeviceManagementRequest with _$DeviceManagementRequest {
  const factory DeviceManagementRequest({
    required String action, // 'add', 'remove', 'update'
    required String deviceId,
    String? deviceName,
  }) = _DeviceManagementRequest;

  factory DeviceManagementRequest.fromJson(Map<String, dynamic> json) =>
      _$DeviceManagementRequestFromJson(json);
}

@freezed
class DeviceLimitResponse with _$DeviceLimitResponse {
  const factory DeviceLimitResponse({
    required bool success,
    required DeviceLimit deviceLimit,
    String? message,
    String? redirectUrl, // URL to device management page
  }) = _DeviceLimitResponse;

  factory DeviceLimitResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceLimitResponseFromJson(json);
}

enum DeviceAction { add, remove, update }

extension DeviceActionExtension on DeviceAction {
  String get value {
    switch (this) {
      case DeviceAction.add:
        return 'add';
      case DeviceAction.remove:
        return 'remove';
      case DeviceAction.update:
        return 'update';
    }
  }
}
