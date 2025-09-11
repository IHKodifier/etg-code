// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) {
  return _DeviceInfo.fromJson(json);
}

/// @nodoc
mixin _$DeviceInfo {
  String get id => throw _privateConstructorUsedError;
  String get fingerprint => throw _privateConstructorUsedError;
  String get platform => throw _privateConstructorUsedError;
  String get deviceType => throw _privateConstructorUsedError;
  String get deviceName => throw _privateConstructorUsedError;
  Map<String, dynamic> get deviceDetails => throw _privateConstructorUsedError;
  DateTime get firstLoginAt => throw _privateConstructorUsedError;
  DateTime get lastLoginAt => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_current_device')
  bool get isCurrentDevice => throw _privateConstructorUsedError;

  /// Serializes this DeviceInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceInfoCopyWith<DeviceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceInfoCopyWith<$Res> {
  factory $DeviceInfoCopyWith(
    DeviceInfo value,
    $Res Function(DeviceInfo) then,
  ) = _$DeviceInfoCopyWithImpl<$Res, DeviceInfo>;
  @useResult
  $Res call({
    String id,
    String fingerprint,
    String platform,
    String deviceType,
    String deviceName,
    Map<String, dynamic> deviceDetails,
    DateTime firstLoginAt,
    DateTime lastLoginAt,
    bool isActive,
    @JsonKey(name: 'is_current_device') bool isCurrentDevice,
  });
}

/// @nodoc
class _$DeviceInfoCopyWithImpl<$Res, $Val extends DeviceInfo>
    implements $DeviceInfoCopyWith<$Res> {
  _$DeviceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fingerprint = null,
    Object? platform = null,
    Object? deviceType = null,
    Object? deviceName = null,
    Object? deviceDetails = null,
    Object? firstLoginAt = null,
    Object? lastLoginAt = null,
    Object? isActive = null,
    Object? isCurrentDevice = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fingerprint: null == fingerprint
                ? _value.fingerprint
                : fingerprint // ignore: cast_nullable_to_non_nullable
                      as String,
            platform: null == platform
                ? _value.platform
                : platform // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceType: null == deviceType
                ? _value.deviceType
                : deviceType // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceName: null == deviceName
                ? _value.deviceName
                : deviceName // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceDetails: null == deviceDetails
                ? _value.deviceDetails
                : deviceDetails // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            firstLoginAt: null == firstLoginAt
                ? _value.firstLoginAt
                : firstLoginAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastLoginAt: null == lastLoginAt
                ? _value.lastLoginAt
                : lastLoginAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCurrentDevice: null == isCurrentDevice
                ? _value.isCurrentDevice
                : isCurrentDevice // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeviceInfoImplCopyWith<$Res>
    implements $DeviceInfoCopyWith<$Res> {
  factory _$$DeviceInfoImplCopyWith(
    _$DeviceInfoImpl value,
    $Res Function(_$DeviceInfoImpl) then,
  ) = __$$DeviceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String fingerprint,
    String platform,
    String deviceType,
    String deviceName,
    Map<String, dynamic> deviceDetails,
    DateTime firstLoginAt,
    DateTime lastLoginAt,
    bool isActive,
    @JsonKey(name: 'is_current_device') bool isCurrentDevice,
  });
}

/// @nodoc
class __$$DeviceInfoImplCopyWithImpl<$Res>
    extends _$DeviceInfoCopyWithImpl<$Res, _$DeviceInfoImpl>
    implements _$$DeviceInfoImplCopyWith<$Res> {
  __$$DeviceInfoImplCopyWithImpl(
    _$DeviceInfoImpl _value,
    $Res Function(_$DeviceInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fingerprint = null,
    Object? platform = null,
    Object? deviceType = null,
    Object? deviceName = null,
    Object? deviceDetails = null,
    Object? firstLoginAt = null,
    Object? lastLoginAt = null,
    Object? isActive = null,
    Object? isCurrentDevice = null,
  }) {
    return _then(
      _$DeviceInfoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fingerprint: null == fingerprint
            ? _value.fingerprint
            : fingerprint // ignore: cast_nullable_to_non_nullable
                  as String,
        platform: null == platform
            ? _value.platform
            : platform // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceType: null == deviceType
            ? _value.deviceType
            : deviceType // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceName: null == deviceName
            ? _value.deviceName
            : deviceName // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceDetails: null == deviceDetails
            ? _value._deviceDetails
            : deviceDetails // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        firstLoginAt: null == firstLoginAt
            ? _value.firstLoginAt
            : firstLoginAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastLoginAt: null == lastLoginAt
            ? _value.lastLoginAt
            : lastLoginAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCurrentDevice: null == isCurrentDevice
            ? _value.isCurrentDevice
            : isCurrentDevice // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceInfoImpl implements _DeviceInfo {
  const _$DeviceInfoImpl({
    required this.id,
    required this.fingerprint,
    required this.platform,
    required this.deviceType,
    required this.deviceName,
    required final Map<String, dynamic> deviceDetails,
    required this.firstLoginAt,
    required this.lastLoginAt,
    required this.isActive,
    @JsonKey(name: 'is_current_device') required this.isCurrentDevice,
  }) : _deviceDetails = deviceDetails;

  factory _$DeviceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceInfoImplFromJson(json);

  @override
  final String id;
  @override
  final String fingerprint;
  @override
  final String platform;
  @override
  final String deviceType;
  @override
  final String deviceName;
  final Map<String, dynamic> _deviceDetails;
  @override
  Map<String, dynamic> get deviceDetails {
    if (_deviceDetails is EqualUnmodifiableMapView) return _deviceDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_deviceDetails);
  }

  @override
  final DateTime firstLoginAt;
  @override
  final DateTime lastLoginAt;
  @override
  final bool isActive;
  @override
  @JsonKey(name: 'is_current_device')
  final bool isCurrentDevice;

  @override
  String toString() {
    return 'DeviceInfo(id: $id, fingerprint: $fingerprint, platform: $platform, deviceType: $deviceType, deviceName: $deviceName, deviceDetails: $deviceDetails, firstLoginAt: $firstLoginAt, lastLoginAt: $lastLoginAt, isActive: $isActive, isCurrentDevice: $isCurrentDevice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fingerprint, fingerprint) ||
                other.fingerprint == fingerprint) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            const DeepCollectionEquality().equals(
              other._deviceDetails,
              _deviceDetails,
            ) &&
            (identical(other.firstLoginAt, firstLoginAt) ||
                other.firstLoginAt == firstLoginAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isCurrentDevice, isCurrentDevice) ||
                other.isCurrentDevice == isCurrentDevice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fingerprint,
    platform,
    deviceType,
    deviceName,
    const DeepCollectionEquality().hash(_deviceDetails),
    firstLoginAt,
    lastLoginAt,
    isActive,
    isCurrentDevice,
  );

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceInfoImplCopyWith<_$DeviceInfoImpl> get copyWith =>
      __$$DeviceInfoImplCopyWithImpl<_$DeviceInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceInfoImplToJson(this);
  }
}

abstract class _DeviceInfo implements DeviceInfo {
  const factory _DeviceInfo({
    required final String id,
    required final String fingerprint,
    required final String platform,
    required final String deviceType,
    required final String deviceName,
    required final Map<String, dynamic> deviceDetails,
    required final DateTime firstLoginAt,
    required final DateTime lastLoginAt,
    required final bool isActive,
    @JsonKey(name: 'is_current_device') required final bool isCurrentDevice,
  }) = _$DeviceInfoImpl;

  factory _DeviceInfo.fromJson(Map<String, dynamic> json) =
      _$DeviceInfoImpl.fromJson;

  @override
  String get id;
  @override
  String get fingerprint;
  @override
  String get platform;
  @override
  String get deviceType;
  @override
  String get deviceName;
  @override
  Map<String, dynamic> get deviceDetails;
  @override
  DateTime get firstLoginAt;
  @override
  DateTime get lastLoginAt;
  @override
  bool get isActive;
  @override
  @JsonKey(name: 'is_current_device')
  bool get isCurrentDevice;

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceInfoImplCopyWith<_$DeviceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeviceLimit _$DeviceLimitFromJson(Map<String, dynamic> json) {
  return _DeviceLimit.fromJson(json);
}

/// @nodoc
mixin _$DeviceLimit {
  int get maxDevices => throw _privateConstructorUsedError;
  int get currentDevices => throw _privateConstructorUsedError;
  bool get isLimitExceeded => throw _privateConstructorUsedError;
  List<DeviceInfo> get devices => throw _privateConstructorUsedError;

  /// Serializes this DeviceLimit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceLimit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceLimitCopyWith<DeviceLimit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceLimitCopyWith<$Res> {
  factory $DeviceLimitCopyWith(
    DeviceLimit value,
    $Res Function(DeviceLimit) then,
  ) = _$DeviceLimitCopyWithImpl<$Res, DeviceLimit>;
  @useResult
  $Res call({
    int maxDevices,
    int currentDevices,
    bool isLimitExceeded,
    List<DeviceInfo> devices,
  });
}

/// @nodoc
class _$DeviceLimitCopyWithImpl<$Res, $Val extends DeviceLimit>
    implements $DeviceLimitCopyWith<$Res> {
  _$DeviceLimitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceLimit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxDevices = null,
    Object? currentDevices = null,
    Object? isLimitExceeded = null,
    Object? devices = null,
  }) {
    return _then(
      _value.copyWith(
            maxDevices: null == maxDevices
                ? _value.maxDevices
                : maxDevices // ignore: cast_nullable_to_non_nullable
                      as int,
            currentDevices: null == currentDevices
                ? _value.currentDevices
                : currentDevices // ignore: cast_nullable_to_non_nullable
                      as int,
            isLimitExceeded: null == isLimitExceeded
                ? _value.isLimitExceeded
                : isLimitExceeded // ignore: cast_nullable_to_non_nullable
                      as bool,
            devices: null == devices
                ? _value.devices
                : devices // ignore: cast_nullable_to_non_nullable
                      as List<DeviceInfo>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeviceLimitImplCopyWith<$Res>
    implements $DeviceLimitCopyWith<$Res> {
  factory _$$DeviceLimitImplCopyWith(
    _$DeviceLimitImpl value,
    $Res Function(_$DeviceLimitImpl) then,
  ) = __$$DeviceLimitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int maxDevices,
    int currentDevices,
    bool isLimitExceeded,
    List<DeviceInfo> devices,
  });
}

/// @nodoc
class __$$DeviceLimitImplCopyWithImpl<$Res>
    extends _$DeviceLimitCopyWithImpl<$Res, _$DeviceLimitImpl>
    implements _$$DeviceLimitImplCopyWith<$Res> {
  __$$DeviceLimitImplCopyWithImpl(
    _$DeviceLimitImpl _value,
    $Res Function(_$DeviceLimitImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeviceLimit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxDevices = null,
    Object? currentDevices = null,
    Object? isLimitExceeded = null,
    Object? devices = null,
  }) {
    return _then(
      _$DeviceLimitImpl(
        maxDevices: null == maxDevices
            ? _value.maxDevices
            : maxDevices // ignore: cast_nullable_to_non_nullable
                  as int,
        currentDevices: null == currentDevices
            ? _value.currentDevices
            : currentDevices // ignore: cast_nullable_to_non_nullable
                  as int,
        isLimitExceeded: null == isLimitExceeded
            ? _value.isLimitExceeded
            : isLimitExceeded // ignore: cast_nullable_to_non_nullable
                  as bool,
        devices: null == devices
            ? _value._devices
            : devices // ignore: cast_nullable_to_non_nullable
                  as List<DeviceInfo>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceLimitImpl implements _DeviceLimit {
  const _$DeviceLimitImpl({
    required this.maxDevices,
    required this.currentDevices,
    required this.isLimitExceeded,
    required final List<DeviceInfo> devices,
  }) : _devices = devices;

  factory _$DeviceLimitImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceLimitImplFromJson(json);

  @override
  final int maxDevices;
  @override
  final int currentDevices;
  @override
  final bool isLimitExceeded;
  final List<DeviceInfo> _devices;
  @override
  List<DeviceInfo> get devices {
    if (_devices is EqualUnmodifiableListView) return _devices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_devices);
  }

  @override
  String toString() {
    return 'DeviceLimit(maxDevices: $maxDevices, currentDevices: $currentDevices, isLimitExceeded: $isLimitExceeded, devices: $devices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceLimitImpl &&
            (identical(other.maxDevices, maxDevices) ||
                other.maxDevices == maxDevices) &&
            (identical(other.currentDevices, currentDevices) ||
                other.currentDevices == currentDevices) &&
            (identical(other.isLimitExceeded, isLimitExceeded) ||
                other.isLimitExceeded == isLimitExceeded) &&
            const DeepCollectionEquality().equals(other._devices, _devices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    maxDevices,
    currentDevices,
    isLimitExceeded,
    const DeepCollectionEquality().hash(_devices),
  );

  /// Create a copy of DeviceLimit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceLimitImplCopyWith<_$DeviceLimitImpl> get copyWith =>
      __$$DeviceLimitImplCopyWithImpl<_$DeviceLimitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceLimitImplToJson(this);
  }
}

abstract class _DeviceLimit implements DeviceLimit {
  const factory _DeviceLimit({
    required final int maxDevices,
    required final int currentDevices,
    required final bool isLimitExceeded,
    required final List<DeviceInfo> devices,
  }) = _$DeviceLimitImpl;

  factory _DeviceLimit.fromJson(Map<String, dynamic> json) =
      _$DeviceLimitImpl.fromJson;

  @override
  int get maxDevices;
  @override
  int get currentDevices;
  @override
  bool get isLimitExceeded;
  @override
  List<DeviceInfo> get devices;

  /// Create a copy of DeviceLimit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceLimitImplCopyWith<_$DeviceLimitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeviceManagementRequest _$DeviceManagementRequestFromJson(
  Map<String, dynamic> json,
) {
  return _DeviceManagementRequest.fromJson(json);
}

/// @nodoc
mixin _$DeviceManagementRequest {
  String get action =>
      throw _privateConstructorUsedError; // 'add', 'remove', 'update'
  String get deviceId => throw _privateConstructorUsedError;
  String? get deviceName => throw _privateConstructorUsedError;

  /// Serializes this DeviceManagementRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceManagementRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceManagementRequestCopyWith<DeviceManagementRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceManagementRequestCopyWith<$Res> {
  factory $DeviceManagementRequestCopyWith(
    DeviceManagementRequest value,
    $Res Function(DeviceManagementRequest) then,
  ) = _$DeviceManagementRequestCopyWithImpl<$Res, DeviceManagementRequest>;
  @useResult
  $Res call({String action, String deviceId, String? deviceName});
}

/// @nodoc
class _$DeviceManagementRequestCopyWithImpl<
  $Res,
  $Val extends DeviceManagementRequest
>
    implements $DeviceManagementRequestCopyWith<$Res> {
  _$DeviceManagementRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceManagementRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? deviceId = null,
    Object? deviceName = freezed,
  }) {
    return _then(
      _value.copyWith(
            action: null == action
                ? _value.action
                : action // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceId: null == deviceId
                ? _value.deviceId
                : deviceId // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceName: freezed == deviceName
                ? _value.deviceName
                : deviceName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeviceManagementRequestImplCopyWith<$Res>
    implements $DeviceManagementRequestCopyWith<$Res> {
  factory _$$DeviceManagementRequestImplCopyWith(
    _$DeviceManagementRequestImpl value,
    $Res Function(_$DeviceManagementRequestImpl) then,
  ) = __$$DeviceManagementRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String action, String deviceId, String? deviceName});
}

/// @nodoc
class __$$DeviceManagementRequestImplCopyWithImpl<$Res>
    extends
        _$DeviceManagementRequestCopyWithImpl<
          $Res,
          _$DeviceManagementRequestImpl
        >
    implements _$$DeviceManagementRequestImplCopyWith<$Res> {
  __$$DeviceManagementRequestImplCopyWithImpl(
    _$DeviceManagementRequestImpl _value,
    $Res Function(_$DeviceManagementRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeviceManagementRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? deviceId = null,
    Object? deviceName = freezed,
  }) {
    return _then(
      _$DeviceManagementRequestImpl(
        action: null == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceId: null == deviceId
            ? _value.deviceId
            : deviceId // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceName: freezed == deviceName
            ? _value.deviceName
            : deviceName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceManagementRequestImpl implements _DeviceManagementRequest {
  const _$DeviceManagementRequestImpl({
    required this.action,
    required this.deviceId,
    this.deviceName,
  });

  factory _$DeviceManagementRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceManagementRequestImplFromJson(json);

  @override
  final String action;
  // 'add', 'remove', 'update'
  @override
  final String deviceId;
  @override
  final String? deviceName;

  @override
  String toString() {
    return 'DeviceManagementRequest(action: $action, deviceId: $deviceId, deviceName: $deviceName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceManagementRequestImpl &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, action, deviceId, deviceName);

  /// Create a copy of DeviceManagementRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceManagementRequestImplCopyWith<_$DeviceManagementRequestImpl>
  get copyWith =>
      __$$DeviceManagementRequestImplCopyWithImpl<
        _$DeviceManagementRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceManagementRequestImplToJson(this);
  }
}

abstract class _DeviceManagementRequest implements DeviceManagementRequest {
  const factory _DeviceManagementRequest({
    required final String action,
    required final String deviceId,
    final String? deviceName,
  }) = _$DeviceManagementRequestImpl;

  factory _DeviceManagementRequest.fromJson(Map<String, dynamic> json) =
      _$DeviceManagementRequestImpl.fromJson;

  @override
  String get action; // 'add', 'remove', 'update'
  @override
  String get deviceId;
  @override
  String? get deviceName;

  /// Create a copy of DeviceManagementRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceManagementRequestImplCopyWith<_$DeviceManagementRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DeviceLimitResponse _$DeviceLimitResponseFromJson(Map<String, dynamic> json) {
  return _DeviceLimitResponse.fromJson(json);
}

/// @nodoc
mixin _$DeviceLimitResponse {
  bool get success => throw _privateConstructorUsedError;
  DeviceLimit get deviceLimit => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get redirectUrl => throw _privateConstructorUsedError;

  /// Serializes this DeviceLimitResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceLimitResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceLimitResponseCopyWith<DeviceLimitResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceLimitResponseCopyWith<$Res> {
  factory $DeviceLimitResponseCopyWith(
    DeviceLimitResponse value,
    $Res Function(DeviceLimitResponse) then,
  ) = _$DeviceLimitResponseCopyWithImpl<$Res, DeviceLimitResponse>;
  @useResult
  $Res call({
    bool success,
    DeviceLimit deviceLimit,
    String? message,
    String? redirectUrl,
  });

  $DeviceLimitCopyWith<$Res> get deviceLimit;
}

/// @nodoc
class _$DeviceLimitResponseCopyWithImpl<$Res, $Val extends DeviceLimitResponse>
    implements $DeviceLimitResponseCopyWith<$Res> {
  _$DeviceLimitResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceLimitResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? deviceLimit = null,
    Object? message = freezed,
    Object? redirectUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            deviceLimit: null == deviceLimit
                ? _value.deviceLimit
                : deviceLimit // ignore: cast_nullable_to_non_nullable
                      as DeviceLimit,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            redirectUrl: freezed == redirectUrl
                ? _value.redirectUrl
                : redirectUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of DeviceLimitResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeviceLimitCopyWith<$Res> get deviceLimit {
    return $DeviceLimitCopyWith<$Res>(_value.deviceLimit, (value) {
      return _then(_value.copyWith(deviceLimit: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DeviceLimitResponseImplCopyWith<$Res>
    implements $DeviceLimitResponseCopyWith<$Res> {
  factory _$$DeviceLimitResponseImplCopyWith(
    _$DeviceLimitResponseImpl value,
    $Res Function(_$DeviceLimitResponseImpl) then,
  ) = __$$DeviceLimitResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    DeviceLimit deviceLimit,
    String? message,
    String? redirectUrl,
  });

  @override
  $DeviceLimitCopyWith<$Res> get deviceLimit;
}

/// @nodoc
class __$$DeviceLimitResponseImplCopyWithImpl<$Res>
    extends _$DeviceLimitResponseCopyWithImpl<$Res, _$DeviceLimitResponseImpl>
    implements _$$DeviceLimitResponseImplCopyWith<$Res> {
  __$$DeviceLimitResponseImplCopyWithImpl(
    _$DeviceLimitResponseImpl _value,
    $Res Function(_$DeviceLimitResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeviceLimitResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? deviceLimit = null,
    Object? message = freezed,
    Object? redirectUrl = freezed,
  }) {
    return _then(
      _$DeviceLimitResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        deviceLimit: null == deviceLimit
            ? _value.deviceLimit
            : deviceLimit // ignore: cast_nullable_to_non_nullable
                  as DeviceLimit,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        redirectUrl: freezed == redirectUrl
            ? _value.redirectUrl
            : redirectUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceLimitResponseImpl implements _DeviceLimitResponse {
  const _$DeviceLimitResponseImpl({
    required this.success,
    required this.deviceLimit,
    this.message,
    this.redirectUrl,
  });

  factory _$DeviceLimitResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceLimitResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final DeviceLimit deviceLimit;
  @override
  final String? message;
  @override
  final String? redirectUrl;

  @override
  String toString() {
    return 'DeviceLimitResponse(success: $success, deviceLimit: $deviceLimit, message: $message, redirectUrl: $redirectUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceLimitResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.deviceLimit, deviceLimit) ||
                other.deviceLimit == deviceLimit) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.redirectUrl, redirectUrl) ||
                other.redirectUrl == redirectUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, success, deviceLimit, message, redirectUrl);

  /// Create a copy of DeviceLimitResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceLimitResponseImplCopyWith<_$DeviceLimitResponseImpl> get copyWith =>
      __$$DeviceLimitResponseImplCopyWithImpl<_$DeviceLimitResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceLimitResponseImplToJson(this);
  }
}

abstract class _DeviceLimitResponse implements DeviceLimitResponse {
  const factory _DeviceLimitResponse({
    required final bool success,
    required final DeviceLimit deviceLimit,
    final String? message,
    final String? redirectUrl,
  }) = _$DeviceLimitResponseImpl;

  factory _DeviceLimitResponse.fromJson(Map<String, dynamic> json) =
      _$DeviceLimitResponseImpl.fromJson;

  @override
  bool get success;
  @override
  DeviceLimit get deviceLimit;
  @override
  String? get message;
  @override
  String? get redirectUrl;

  /// Create a copy of DeviceLimitResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceLimitResponseImplCopyWith<_$DeviceLimitResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
