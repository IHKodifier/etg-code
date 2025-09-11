import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    String? email,
    @JsonKey(name: 'exam_type') String? examType,
    required String tier,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'is_verified') bool? isVerified,
    @JsonKey(name: 'is_anonymous') required bool isAnonymous,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    required Map<String, dynamic> profile,
    @JsonKey(name: 'usage_stats') required Map<String, dynamic> usageStats,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class AuthTokens with _$AuthTokens {
  const factory AuthTokens({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @JsonKey(name: 'token_type') required String tokenType,
    required User user,
  }) = _AuthTokens;

  factory AuthTokens.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensFromJson(json);
}

@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String email,
    required String password,
    @JsonKey(name: 'exam_type') required String examType,
    @JsonKey(name: 'device_info') required Map<String, dynamic> deviceInfo,
    Map<String, dynamic>? profile,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}

@freezed
class GoogleAuthRequest with _$GoogleAuthRequest {
  const factory GoogleAuthRequest({
    @JsonKey(name: 'id_token') required String idToken,
    @JsonKey(name: 'device_info') required Map<String, dynamic> deviceInfo,
    @JsonKey(name: 'exam_type') String? examType,
  }) = _GoogleAuthRequest;

  factory GoogleAuthRequest.fromJson(Map<String, dynamic> json) =>
      _$GoogleAuthRequestFromJson(json);
}
