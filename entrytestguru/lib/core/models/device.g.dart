// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceInfoImpl _$$DeviceInfoImplFromJson(Map<String, dynamic> json) =>
    _$DeviceInfoImpl(
      id: json['id'] as String,
      fingerprint: json['fingerprint'] as String,
      platform: json['platform'] as String,
      deviceType: json['deviceType'] as String,
      deviceName: json['deviceName'] as String,
      deviceDetails: json['deviceDetails'] as Map<String, dynamic>,
      firstLoginAt: DateTime.parse(json['firstLoginAt'] as String),
      lastLoginAt: DateTime.parse(json['lastLoginAt'] as String),
      isActive: json['isActive'] as bool,
      isCurrentDevice: json['is_current_device'] as bool,
    );

Map<String, dynamic> _$$DeviceInfoImplToJson(_$DeviceInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fingerprint': instance.fingerprint,
      'platform': instance.platform,
      'deviceType': instance.deviceType,
      'deviceName': instance.deviceName,
      'deviceDetails': instance.deviceDetails,
      'firstLoginAt': instance.firstLoginAt.toIso8601String(),
      'lastLoginAt': instance.lastLoginAt.toIso8601String(),
      'isActive': instance.isActive,
      'is_current_device': instance.isCurrentDevice,
    };

_$DeviceLimitImpl _$$DeviceLimitImplFromJson(Map<String, dynamic> json) =>
    _$DeviceLimitImpl(
      maxDevices: (json['maxDevices'] as num).toInt(),
      currentDevices: (json['currentDevices'] as num).toInt(),
      isLimitExceeded: json['isLimitExceeded'] as bool,
      devices: (json['devices'] as List<dynamic>)
          .map((e) => DeviceInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DeviceLimitImplToJson(_$DeviceLimitImpl instance) =>
    <String, dynamic>{
      'maxDevices': instance.maxDevices,
      'currentDevices': instance.currentDevices,
      'isLimitExceeded': instance.isLimitExceeded,
      'devices': instance.devices,
    };

_$DeviceManagementRequestImpl _$$DeviceManagementRequestImplFromJson(
  Map<String, dynamic> json,
) => _$DeviceManagementRequestImpl(
  action: json['action'] as String,
  deviceId: json['deviceId'] as String,
  deviceName: json['deviceName'] as String?,
);

Map<String, dynamic> _$$DeviceManagementRequestImplToJson(
  _$DeviceManagementRequestImpl instance,
) => <String, dynamic>{
  'action': instance.action,
  'deviceId': instance.deviceId,
  'deviceName': instance.deviceName,
};

_$DeviceLimitResponseImpl _$$DeviceLimitResponseImplFromJson(
  Map<String, dynamic> json,
) => _$DeviceLimitResponseImpl(
  success: json['success'] as bool,
  deviceLimit: DeviceLimit.fromJson(
    json['deviceLimit'] as Map<String, dynamic>,
  ),
  message: json['message'] as String?,
  redirectUrl: json['redirectUrl'] as String?,
);

Map<String, dynamic> _$$DeviceLimitResponseImplToJson(
  _$DeviceLimitResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'deviceLimit': instance.deviceLimit,
  'message': instance.message,
  'redirectUrl': instance.redirectUrl,
};
