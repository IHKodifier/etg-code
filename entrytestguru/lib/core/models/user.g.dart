// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  id: json['id'] as String,
  email: json['email'] as String?,
  examType: json['exam_type'] as String?,
  tier: json['tier'] as String,
  isActive: json['is_active'] as bool,
  isVerified: json['is_verified'] as bool?,
  isAnonymous: json['is_anonymous'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
  profile: json['profile'] as Map<String, dynamic>,
  usageStats: json['usage_stats'] as Map<String, dynamic>,
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'exam_type': instance.examType,
      'tier': instance.tier,
      'is_active': instance.isActive,
      'is_verified': instance.isVerified,
      'is_anonymous': instance.isAnonymous,
      'created_at': instance.createdAt.toIso8601String(),
      'profile': instance.profile,
      'usage_stats': instance.usageStats,
    };

_$AuthTokensImpl _$$AuthTokensImplFromJson(Map<String, dynamic> json) =>
    _$AuthTokensImpl(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthTokensImplToJson(_$AuthTokensImpl instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'token_type': instance.tokenType,
      'user': instance.user,
    };

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_$RegisterRequestImpl _$$RegisterRequestImplFromJson(
  Map<String, dynamic> json,
) => _$RegisterRequestImpl(
  email: json['email'] as String,
  password: json['password'] as String,
  examType: json['exam_type'] as String,
  deviceInfo: json['device_info'] as Map<String, dynamic>,
  profile: json['profile'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$RegisterRequestImplToJson(
  _$RegisterRequestImpl instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'exam_type': instance.examType,
  'device_info': instance.deviceInfo,
  'profile': instance.profile,
};

_$GoogleAuthRequestImpl _$$GoogleAuthRequestImplFromJson(
  Map<String, dynamic> json,
) => _$GoogleAuthRequestImpl(
  idToken: json['id_token'] as String,
  deviceInfo: json['device_info'] as Map<String, dynamic>,
  examType: json['exam_type'] as String?,
);

Map<String, dynamic> _$$GoogleAuthRequestImplToJson(
  _$GoogleAuthRequestImpl instance,
) => <String, dynamic>{
  'id_token': instance.idToken,
  'device_info': instance.deviceInfo,
  'exam_type': instance.examType,
};
