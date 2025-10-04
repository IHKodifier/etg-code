// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'practice_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PracticeSessionFilter _$PracticeSessionFilterFromJson(
  Map<String, dynamic> json,
) {
  return _PracticeSessionFilter.fromJson(json);
}

/// @nodoc
mixin _$PracticeSessionFilter {
  @JsonKey(name: 'exam_type')
  String get examType => throw _privateConstructorUsedError;
  String? get subject => throw _privateConstructorUsedError;
  String? get topic => throw _privateConstructorUsedError;
  String? get difficulty => throw _privateConstructorUsedError;
  @JsonKey(name: 'arde_probability')
  String? get ardeProbability => throw _privateConstructorUsedError;
  @JsonKey(name: 'question_count')
  int get questionCount => throw _privateConstructorUsedError;

  /// Serializes this PracticeSessionFilter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PracticeSessionFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PracticeSessionFilterCopyWith<PracticeSessionFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PracticeSessionFilterCopyWith<$Res> {
  factory $PracticeSessionFilterCopyWith(
    PracticeSessionFilter value,
    $Res Function(PracticeSessionFilter) then,
  ) = _$PracticeSessionFilterCopyWithImpl<$Res, PracticeSessionFilter>;
  @useResult
  $Res call({
    @JsonKey(name: 'exam_type') String examType,
    String? subject,
    String? topic,
    String? difficulty,
    @JsonKey(name: 'arde_probability') String? ardeProbability,
    @JsonKey(name: 'question_count') int questionCount,
  });
}

/// @nodoc
class _$PracticeSessionFilterCopyWithImpl<
  $Res,
  $Val extends PracticeSessionFilter
>
    implements $PracticeSessionFilterCopyWith<$Res> {
  _$PracticeSessionFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PracticeSessionFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? examType = null,
    Object? subject = freezed,
    Object? topic = freezed,
    Object? difficulty = freezed,
    Object? ardeProbability = freezed,
    Object? questionCount = null,
  }) {
    return _then(
      _value.copyWith(
            examType: null == examType
                ? _value.examType
                : examType // ignore: cast_nullable_to_non_nullable
                      as String,
            subject: freezed == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String?,
            topic: freezed == topic
                ? _value.topic
                : topic // ignore: cast_nullable_to_non_nullable
                      as String?,
            difficulty: freezed == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as String?,
            ardeProbability: freezed == ardeProbability
                ? _value.ardeProbability
                : ardeProbability // ignore: cast_nullable_to_non_nullable
                      as String?,
            questionCount: null == questionCount
                ? _value.questionCount
                : questionCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PracticeSessionFilterImplCopyWith<$Res>
    implements $PracticeSessionFilterCopyWith<$Res> {
  factory _$$PracticeSessionFilterImplCopyWith(
    _$PracticeSessionFilterImpl value,
    $Res Function(_$PracticeSessionFilterImpl) then,
  ) = __$$PracticeSessionFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'exam_type') String examType,
    String? subject,
    String? topic,
    String? difficulty,
    @JsonKey(name: 'arde_probability') String? ardeProbability,
    @JsonKey(name: 'question_count') int questionCount,
  });
}

/// @nodoc
class __$$PracticeSessionFilterImplCopyWithImpl<$Res>
    extends
        _$PracticeSessionFilterCopyWithImpl<$Res, _$PracticeSessionFilterImpl>
    implements _$$PracticeSessionFilterImplCopyWith<$Res> {
  __$$PracticeSessionFilterImplCopyWithImpl(
    _$PracticeSessionFilterImpl _value,
    $Res Function(_$PracticeSessionFilterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PracticeSessionFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? examType = null,
    Object? subject = freezed,
    Object? topic = freezed,
    Object? difficulty = freezed,
    Object? ardeProbability = freezed,
    Object? questionCount = null,
  }) {
    return _then(
      _$PracticeSessionFilterImpl(
        examType: null == examType
            ? _value.examType
            : examType // ignore: cast_nullable_to_non_nullable
                  as String,
        subject: freezed == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String?,
        topic: freezed == topic
            ? _value.topic
            : topic // ignore: cast_nullable_to_non_nullable
                  as String?,
        difficulty: freezed == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as String?,
        ardeProbability: freezed == ardeProbability
            ? _value.ardeProbability
            : ardeProbability // ignore: cast_nullable_to_non_nullable
                  as String?,
        questionCount: null == questionCount
            ? _value.questionCount
            : questionCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PracticeSessionFilterImpl implements _PracticeSessionFilter {
  const _$PracticeSessionFilterImpl({
    @JsonKey(name: 'exam_type') required this.examType,
    this.subject,
    this.topic,
    this.difficulty,
    @JsonKey(name: 'arde_probability') this.ardeProbability,
    @JsonKey(name: 'question_count') this.questionCount = 10,
  });

  factory _$PracticeSessionFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$PracticeSessionFilterImplFromJson(json);

  @override
  @JsonKey(name: 'exam_type')
  final String examType;
  @override
  final String? subject;
  @override
  final String? topic;
  @override
  final String? difficulty;
  @override
  @JsonKey(name: 'arde_probability')
  final String? ardeProbability;
  @override
  @JsonKey(name: 'question_count')
  final int questionCount;

  @override
  String toString() {
    return 'PracticeSessionFilter(examType: $examType, subject: $subject, topic: $topic, difficulty: $difficulty, ardeProbability: $ardeProbability, questionCount: $questionCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PracticeSessionFilterImpl &&
            (identical(other.examType, examType) ||
                other.examType == examType) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.ardeProbability, ardeProbability) ||
                other.ardeProbability == ardeProbability) &&
            (identical(other.questionCount, questionCount) ||
                other.questionCount == questionCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    examType,
    subject,
    topic,
    difficulty,
    ardeProbability,
    questionCount,
  );

  /// Create a copy of PracticeSessionFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PracticeSessionFilterImplCopyWith<_$PracticeSessionFilterImpl>
  get copyWith =>
      __$$PracticeSessionFilterImplCopyWithImpl<_$PracticeSessionFilterImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PracticeSessionFilterImplToJson(this);
  }
}

abstract class _PracticeSessionFilter implements PracticeSessionFilter {
  const factory _PracticeSessionFilter({
    @JsonKey(name: 'exam_type') required final String examType,
    final String? subject,
    final String? topic,
    final String? difficulty,
    @JsonKey(name: 'arde_probability') final String? ardeProbability,
    @JsonKey(name: 'question_count') final int questionCount,
  }) = _$PracticeSessionFilterImpl;

  factory _PracticeSessionFilter.fromJson(Map<String, dynamic> json) =
      _$PracticeSessionFilterImpl.fromJson;

  @override
  @JsonKey(name: 'exam_type')
  String get examType;
  @override
  String? get subject;
  @override
  String? get topic;
  @override
  String? get difficulty;
  @override
  @JsonKey(name: 'arde_probability')
  String? get ardeProbability;
  @override
  @JsonKey(name: 'question_count')
  int get questionCount;

  /// Create a copy of PracticeSessionFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PracticeSessionFilterImplCopyWith<_$PracticeSessionFilterImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PracticeSessionSettings _$PracticeSessionSettingsFromJson(
  Map<String, dynamic> json,
) {
  return _PracticeSessionSettings.fromJson(json);
}

/// @nodoc
mixin _$PracticeSessionSettings {
  @JsonKey(name: 'show_explanations')
  bool get showExplanations => throw _privateConstructorUsedError;
  @JsonKey(name: 'randomize_order')
  bool get randomizeOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'allow_skipping')
  bool get allowSkipping => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_limit_per_question')
  int? get timeLimitPerQuestion => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_attempts_per_question')
  int get maxAttemptsPerQuestion => throw _privateConstructorUsedError;

  /// Serializes this PracticeSessionSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PracticeSessionSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PracticeSessionSettingsCopyWith<PracticeSessionSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PracticeSessionSettingsCopyWith<$Res> {
  factory $PracticeSessionSettingsCopyWith(
    PracticeSessionSettings value,
    $Res Function(PracticeSessionSettings) then,
  ) = _$PracticeSessionSettingsCopyWithImpl<$Res, PracticeSessionSettings>;
  @useResult
  $Res call({
    @JsonKey(name: 'show_explanations') bool showExplanations,
    @JsonKey(name: 'randomize_order') bool randomizeOrder,
    @JsonKey(name: 'allow_skipping') bool allowSkipping,
    @JsonKey(name: 'time_limit_per_question') int? timeLimitPerQuestion,
    @JsonKey(name: 'max_attempts_per_question') int maxAttemptsPerQuestion,
  });
}

/// @nodoc
class _$PracticeSessionSettingsCopyWithImpl<
  $Res,
  $Val extends PracticeSessionSettings
>
    implements $PracticeSessionSettingsCopyWith<$Res> {
  _$PracticeSessionSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PracticeSessionSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showExplanations = null,
    Object? randomizeOrder = null,
    Object? allowSkipping = null,
    Object? timeLimitPerQuestion = freezed,
    Object? maxAttemptsPerQuestion = null,
  }) {
    return _then(
      _value.copyWith(
            showExplanations: null == showExplanations
                ? _value.showExplanations
                : showExplanations // ignore: cast_nullable_to_non_nullable
                      as bool,
            randomizeOrder: null == randomizeOrder
                ? _value.randomizeOrder
                : randomizeOrder // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowSkipping: null == allowSkipping
                ? _value.allowSkipping
                : allowSkipping // ignore: cast_nullable_to_non_nullable
                      as bool,
            timeLimitPerQuestion: freezed == timeLimitPerQuestion
                ? _value.timeLimitPerQuestion
                : timeLimitPerQuestion // ignore: cast_nullable_to_non_nullable
                      as int?,
            maxAttemptsPerQuestion: null == maxAttemptsPerQuestion
                ? _value.maxAttemptsPerQuestion
                : maxAttemptsPerQuestion // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PracticeSessionSettingsImplCopyWith<$Res>
    implements $PracticeSessionSettingsCopyWith<$Res> {
  factory _$$PracticeSessionSettingsImplCopyWith(
    _$PracticeSessionSettingsImpl value,
    $Res Function(_$PracticeSessionSettingsImpl) then,
  ) = __$$PracticeSessionSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'show_explanations') bool showExplanations,
    @JsonKey(name: 'randomize_order') bool randomizeOrder,
    @JsonKey(name: 'allow_skipping') bool allowSkipping,
    @JsonKey(name: 'time_limit_per_question') int? timeLimitPerQuestion,
    @JsonKey(name: 'max_attempts_per_question') int maxAttemptsPerQuestion,
  });
}

/// @nodoc
class __$$PracticeSessionSettingsImplCopyWithImpl<$Res>
    extends
        _$PracticeSessionSettingsCopyWithImpl<
          $Res,
          _$PracticeSessionSettingsImpl
        >
    implements _$$PracticeSessionSettingsImplCopyWith<$Res> {
  __$$PracticeSessionSettingsImplCopyWithImpl(
    _$PracticeSessionSettingsImpl _value,
    $Res Function(_$PracticeSessionSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PracticeSessionSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showExplanations = null,
    Object? randomizeOrder = null,
    Object? allowSkipping = null,
    Object? timeLimitPerQuestion = freezed,
    Object? maxAttemptsPerQuestion = null,
  }) {
    return _then(
      _$PracticeSessionSettingsImpl(
        showExplanations: null == showExplanations
            ? _value.showExplanations
            : showExplanations // ignore: cast_nullable_to_non_nullable
                  as bool,
        randomizeOrder: null == randomizeOrder
            ? _value.randomizeOrder
            : randomizeOrder // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowSkipping: null == allowSkipping
            ? _value.allowSkipping
            : allowSkipping // ignore: cast_nullable_to_non_nullable
                  as bool,
        timeLimitPerQuestion: freezed == timeLimitPerQuestion
            ? _value.timeLimitPerQuestion
            : timeLimitPerQuestion // ignore: cast_nullable_to_non_nullable
                  as int?,
        maxAttemptsPerQuestion: null == maxAttemptsPerQuestion
            ? _value.maxAttemptsPerQuestion
            : maxAttemptsPerQuestion // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PracticeSessionSettingsImpl implements _PracticeSessionSettings {
  const _$PracticeSessionSettingsImpl({
    @JsonKey(name: 'show_explanations') this.showExplanations = true,
    @JsonKey(name: 'randomize_order') this.randomizeOrder = true,
    @JsonKey(name: 'allow_skipping') this.allowSkipping = true,
    @JsonKey(name: 'time_limit_per_question') this.timeLimitPerQuestion,
    @JsonKey(name: 'max_attempts_per_question') this.maxAttemptsPerQuestion = 3,
  });

  factory _$PracticeSessionSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PracticeSessionSettingsImplFromJson(json);

  @override
  @JsonKey(name: 'show_explanations')
  final bool showExplanations;
  @override
  @JsonKey(name: 'randomize_order')
  final bool randomizeOrder;
  @override
  @JsonKey(name: 'allow_skipping')
  final bool allowSkipping;
  @override
  @JsonKey(name: 'time_limit_per_question')
  final int? timeLimitPerQuestion;
  @override
  @JsonKey(name: 'max_attempts_per_question')
  final int maxAttemptsPerQuestion;

  @override
  String toString() {
    return 'PracticeSessionSettings(showExplanations: $showExplanations, randomizeOrder: $randomizeOrder, allowSkipping: $allowSkipping, timeLimitPerQuestion: $timeLimitPerQuestion, maxAttemptsPerQuestion: $maxAttemptsPerQuestion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PracticeSessionSettingsImpl &&
            (identical(other.showExplanations, showExplanations) ||
                other.showExplanations == showExplanations) &&
            (identical(other.randomizeOrder, randomizeOrder) ||
                other.randomizeOrder == randomizeOrder) &&
            (identical(other.allowSkipping, allowSkipping) ||
                other.allowSkipping == allowSkipping) &&
            (identical(other.timeLimitPerQuestion, timeLimitPerQuestion) ||
                other.timeLimitPerQuestion == timeLimitPerQuestion) &&
            (identical(other.maxAttemptsPerQuestion, maxAttemptsPerQuestion) ||
                other.maxAttemptsPerQuestion == maxAttemptsPerQuestion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    showExplanations,
    randomizeOrder,
    allowSkipping,
    timeLimitPerQuestion,
    maxAttemptsPerQuestion,
  );

  /// Create a copy of PracticeSessionSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PracticeSessionSettingsImplCopyWith<_$PracticeSessionSettingsImpl>
  get copyWith =>
      __$$PracticeSessionSettingsImplCopyWithImpl<
        _$PracticeSessionSettingsImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PracticeSessionSettingsImplToJson(this);
  }
}

abstract class _PracticeSessionSettings implements PracticeSessionSettings {
  const factory _PracticeSessionSettings({
    @JsonKey(name: 'show_explanations') final bool showExplanations,
    @JsonKey(name: 'randomize_order') final bool randomizeOrder,
    @JsonKey(name: 'allow_skipping') final bool allowSkipping,
    @JsonKey(name: 'time_limit_per_question') final int? timeLimitPerQuestion,
    @JsonKey(name: 'max_attempts_per_question')
    final int maxAttemptsPerQuestion,
  }) = _$PracticeSessionSettingsImpl;

  factory _PracticeSessionSettings.fromJson(Map<String, dynamic> json) =
      _$PracticeSessionSettingsImpl.fromJson;

  @override
  @JsonKey(name: 'show_explanations')
  bool get showExplanations;
  @override
  @JsonKey(name: 'randomize_order')
  bool get randomizeOrder;
  @override
  @JsonKey(name: 'allow_skipping')
  bool get allowSkipping;
  @override
  @JsonKey(name: 'time_limit_per_question')
  int? get timeLimitPerQuestion;
  @override
  @JsonKey(name: 'max_attempts_per_question')
  int get maxAttemptsPerQuestion;

  /// Create a copy of PracticeSessionSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PracticeSessionSettingsImplCopyWith<_$PracticeSessionSettingsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PracticeSessionCreateRequest _$PracticeSessionCreateRequestFromJson(
  Map<String, dynamic> json,
) {
  return _PracticeSessionCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$PracticeSessionCreateRequest {
  @JsonKey(name: 'filter_criteria')
  PracticeSessionFilter get filterCriteria =>
      throw _privateConstructorUsedError;
  PracticeSessionSettings? get settings => throw _privateConstructorUsedError;

  /// Serializes this PracticeSessionCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PracticeSessionCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PracticeSessionCreateRequestCopyWith<PracticeSessionCreateRequest>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PracticeSessionCreateRequestCopyWith<$Res> {
  factory $PracticeSessionCreateRequestCopyWith(
    PracticeSessionCreateRequest value,
    $Res Function(PracticeSessionCreateRequest) then,
  ) =
      _$PracticeSessionCreateRequestCopyWithImpl<
        $Res,
        PracticeSessionCreateRequest
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'filter_criteria') PracticeSessionFilter filterCriteria,
    PracticeSessionSettings? settings,
  });

  $PracticeSessionFilterCopyWith<$Res> get filterCriteria;
  $PracticeSessionSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class _$PracticeSessionCreateRequestCopyWithImpl<
  $Res,
  $Val extends PracticeSessionCreateRequest
>
    implements $PracticeSessionCreateRequestCopyWith<$Res> {
  _$PracticeSessionCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PracticeSessionCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? filterCriteria = null, Object? settings = freezed}) {
    return _then(
      _value.copyWith(
            filterCriteria: null == filterCriteria
                ? _value.filterCriteria
                : filterCriteria // ignore: cast_nullable_to_non_nullable
                      as PracticeSessionFilter,
            settings: freezed == settings
                ? _value.settings
                : settings // ignore: cast_nullable_to_non_nullable
                      as PracticeSessionSettings?,
          )
          as $Val,
    );
  }

  /// Create a copy of PracticeSessionCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PracticeSessionFilterCopyWith<$Res> get filterCriteria {
    return $PracticeSessionFilterCopyWith<$Res>(_value.filterCriteria, (value) {
      return _then(_value.copyWith(filterCriteria: value) as $Val);
    });
  }

  /// Create a copy of PracticeSessionCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PracticeSessionSettingsCopyWith<$Res>? get settings {
    if (_value.settings == null) {
      return null;
    }

    return $PracticeSessionSettingsCopyWith<$Res>(_value.settings!, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PracticeSessionCreateRequestImplCopyWith<$Res>
    implements $PracticeSessionCreateRequestCopyWith<$Res> {
  factory _$$PracticeSessionCreateRequestImplCopyWith(
    _$PracticeSessionCreateRequestImpl value,
    $Res Function(_$PracticeSessionCreateRequestImpl) then,
  ) = __$$PracticeSessionCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'filter_criteria') PracticeSessionFilter filterCriteria,
    PracticeSessionSettings? settings,
  });

  @override
  $PracticeSessionFilterCopyWith<$Res> get filterCriteria;
  @override
  $PracticeSessionSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class __$$PracticeSessionCreateRequestImplCopyWithImpl<$Res>
    extends
        _$PracticeSessionCreateRequestCopyWithImpl<
          $Res,
          _$PracticeSessionCreateRequestImpl
        >
    implements _$$PracticeSessionCreateRequestImplCopyWith<$Res> {
  __$$PracticeSessionCreateRequestImplCopyWithImpl(
    _$PracticeSessionCreateRequestImpl _value,
    $Res Function(_$PracticeSessionCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PracticeSessionCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? filterCriteria = null, Object? settings = freezed}) {
    return _then(
      _$PracticeSessionCreateRequestImpl(
        filterCriteria: null == filterCriteria
            ? _value.filterCriteria
            : filterCriteria // ignore: cast_nullable_to_non_nullable
                  as PracticeSessionFilter,
        settings: freezed == settings
            ? _value.settings
            : settings // ignore: cast_nullable_to_non_nullable
                  as PracticeSessionSettings?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PracticeSessionCreateRequestImpl
    implements _PracticeSessionCreateRequest {
  const _$PracticeSessionCreateRequestImpl({
    @JsonKey(name: 'filter_criteria') required this.filterCriteria,
    this.settings,
  });

  factory _$PracticeSessionCreateRequestImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$PracticeSessionCreateRequestImplFromJson(json);

  @override
  @JsonKey(name: 'filter_criteria')
  final PracticeSessionFilter filterCriteria;
  @override
  final PracticeSessionSettings? settings;

  @override
  String toString() {
    return 'PracticeSessionCreateRequest(filterCriteria: $filterCriteria, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PracticeSessionCreateRequestImpl &&
            (identical(other.filterCriteria, filterCriteria) ||
                other.filterCriteria == filterCriteria) &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, filterCriteria, settings);

  /// Create a copy of PracticeSessionCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PracticeSessionCreateRequestImplCopyWith<
    _$PracticeSessionCreateRequestImpl
  >
  get copyWith =>
      __$$PracticeSessionCreateRequestImplCopyWithImpl<
        _$PracticeSessionCreateRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PracticeSessionCreateRequestImplToJson(this);
  }
}

abstract class _PracticeSessionCreateRequest
    implements PracticeSessionCreateRequest {
  const factory _PracticeSessionCreateRequest({
    @JsonKey(name: 'filter_criteria')
    required final PracticeSessionFilter filterCriteria,
    final PracticeSessionSettings? settings,
  }) = _$PracticeSessionCreateRequestImpl;

  factory _PracticeSessionCreateRequest.fromJson(Map<String, dynamic> json) =
      _$PracticeSessionCreateRequestImpl.fromJson;

  @override
  @JsonKey(name: 'filter_criteria')
  PracticeSessionFilter get filterCriteria;
  @override
  PracticeSessionSettings? get settings;

  /// Create a copy of PracticeSessionCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PracticeSessionCreateRequestImplCopyWith<
    _$PracticeSessionCreateRequestImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

PracticeSessionSummary _$PracticeSessionSummaryFromJson(
  Map<String, dynamic> json,
) {
  return _PracticeSessionSummary.fromJson(json);
}

/// @nodoc
mixin _$PracticeSessionSummary {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'session_type')
  String get sessionType => throw _privateConstructorUsedError;
  @JsonKey(name: 'exam_type')
  String get examType => throw _privateConstructorUsedError;
  String? get subject => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_questions')
  int get totalQuestions => throw _privateConstructorUsedError;
  @JsonKey(name: 'answered_questions')
  int get answeredQuestions => throw _privateConstructorUsedError;
  @JsonKey(name: 'correct_answers')
  int get correctAnswers => throw _privateConstructorUsedError;
  @JsonKey(name: 'accuracy_percentage')
  double get accuracyPercentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_time_spent')
  int get totalTimeSpent => throw _privateConstructorUsedError;
  @JsonKey(name: 'started_at')
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this PracticeSessionSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PracticeSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PracticeSessionSummaryCopyWith<PracticeSessionSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PracticeSessionSummaryCopyWith<$Res> {
  factory $PracticeSessionSummaryCopyWith(
    PracticeSessionSummary value,
    $Res Function(PracticeSessionSummary) then,
  ) = _$PracticeSessionSummaryCopyWithImpl<$Res, PracticeSessionSummary>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'session_type') String sessionType,
    @JsonKey(name: 'exam_type') String examType,
    String? subject,
    @JsonKey(name: 'total_questions') int totalQuestions,
    @JsonKey(name: 'answered_questions') int answeredQuestions,
    @JsonKey(name: 'correct_answers') int correctAnswers,
    @JsonKey(name: 'accuracy_percentage') double accuracyPercentage,
    @JsonKey(name: 'total_time_spent') int totalTimeSpent,
    @JsonKey(name: 'started_at') DateTime startedAt,
    DateTime? completedAt,
    String status,
  });
}

/// @nodoc
class _$PracticeSessionSummaryCopyWithImpl<
  $Res,
  $Val extends PracticeSessionSummary
>
    implements $PracticeSessionSummaryCopyWith<$Res> {
  _$PracticeSessionSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PracticeSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionType = null,
    Object? examType = null,
    Object? subject = freezed,
    Object? totalQuestions = null,
    Object? answeredQuestions = null,
    Object? correctAnswers = null,
    Object? accuracyPercentage = null,
    Object? totalTimeSpent = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            sessionType: null == sessionType
                ? _value.sessionType
                : sessionType // ignore: cast_nullable_to_non_nullable
                      as String,
            examType: null == examType
                ? _value.examType
                : examType // ignore: cast_nullable_to_non_nullable
                      as String,
            subject: freezed == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalQuestions: null == totalQuestions
                ? _value.totalQuestions
                : totalQuestions // ignore: cast_nullable_to_non_nullable
                      as int,
            answeredQuestions: null == answeredQuestions
                ? _value.answeredQuestions
                : answeredQuestions // ignore: cast_nullable_to_non_nullable
                      as int,
            correctAnswers: null == correctAnswers
                ? _value.correctAnswers
                : correctAnswers // ignore: cast_nullable_to_non_nullable
                      as int,
            accuracyPercentage: null == accuracyPercentage
                ? _value.accuracyPercentage
                : accuracyPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            totalTimeSpent: null == totalTimeSpent
                ? _value.totalTimeSpent
                : totalTimeSpent // ignore: cast_nullable_to_non_nullable
                      as int,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PracticeSessionSummaryImplCopyWith<$Res>
    implements $PracticeSessionSummaryCopyWith<$Res> {
  factory _$$PracticeSessionSummaryImplCopyWith(
    _$PracticeSessionSummaryImpl value,
    $Res Function(_$PracticeSessionSummaryImpl) then,
  ) = __$$PracticeSessionSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'session_type') String sessionType,
    @JsonKey(name: 'exam_type') String examType,
    String? subject,
    @JsonKey(name: 'total_questions') int totalQuestions,
    @JsonKey(name: 'answered_questions') int answeredQuestions,
    @JsonKey(name: 'correct_answers') int correctAnswers,
    @JsonKey(name: 'accuracy_percentage') double accuracyPercentage,
    @JsonKey(name: 'total_time_spent') int totalTimeSpent,
    @JsonKey(name: 'started_at') DateTime startedAt,
    DateTime? completedAt,
    String status,
  });
}

/// @nodoc
class __$$PracticeSessionSummaryImplCopyWithImpl<$Res>
    extends
        _$PracticeSessionSummaryCopyWithImpl<$Res, _$PracticeSessionSummaryImpl>
    implements _$$PracticeSessionSummaryImplCopyWith<$Res> {
  __$$PracticeSessionSummaryImplCopyWithImpl(
    _$PracticeSessionSummaryImpl _value,
    $Res Function(_$PracticeSessionSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PracticeSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionType = null,
    Object? examType = null,
    Object? subject = freezed,
    Object? totalQuestions = null,
    Object? answeredQuestions = null,
    Object? correctAnswers = null,
    Object? accuracyPercentage = null,
    Object? totalTimeSpent = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? status = null,
  }) {
    return _then(
      _$PracticeSessionSummaryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        sessionType: null == sessionType
            ? _value.sessionType
            : sessionType // ignore: cast_nullable_to_non_nullable
                  as String,
        examType: null == examType
            ? _value.examType
            : examType // ignore: cast_nullable_to_non_nullable
                  as String,
        subject: freezed == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalQuestions: null == totalQuestions
            ? _value.totalQuestions
            : totalQuestions // ignore: cast_nullable_to_non_nullable
                  as int,
        answeredQuestions: null == answeredQuestions
            ? _value.answeredQuestions
            : answeredQuestions // ignore: cast_nullable_to_non_nullable
                  as int,
        correctAnswers: null == correctAnswers
            ? _value.correctAnswers
            : correctAnswers // ignore: cast_nullable_to_non_nullable
                  as int,
        accuracyPercentage: null == accuracyPercentage
            ? _value.accuracyPercentage
            : accuracyPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        totalTimeSpent: null == totalTimeSpent
            ? _value.totalTimeSpent
            : totalTimeSpent // ignore: cast_nullable_to_non_nullable
                  as int,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PracticeSessionSummaryImpl implements _PracticeSessionSummary {
  const _$PracticeSessionSummaryImpl({
    required this.id,
    @JsonKey(name: 'session_type') required this.sessionType,
    @JsonKey(name: 'exam_type') required this.examType,
    this.subject,
    @JsonKey(name: 'total_questions') required this.totalQuestions,
    @JsonKey(name: 'answered_questions') required this.answeredQuestions,
    @JsonKey(name: 'correct_answers') required this.correctAnswers,
    @JsonKey(name: 'accuracy_percentage') required this.accuracyPercentage,
    @JsonKey(name: 'total_time_spent') required this.totalTimeSpent,
    @JsonKey(name: 'started_at') required this.startedAt,
    this.completedAt,
    required this.status,
  });

  factory _$PracticeSessionSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PracticeSessionSummaryImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'session_type')
  final String sessionType;
  @override
  @JsonKey(name: 'exam_type')
  final String examType;
  @override
  final String? subject;
  @override
  @JsonKey(name: 'total_questions')
  final int totalQuestions;
  @override
  @JsonKey(name: 'answered_questions')
  final int answeredQuestions;
  @override
  @JsonKey(name: 'correct_answers')
  final int correctAnswers;
  @override
  @JsonKey(name: 'accuracy_percentage')
  final double accuracyPercentage;
  @override
  @JsonKey(name: 'total_time_spent')
  final int totalTimeSpent;
  @override
  @JsonKey(name: 'started_at')
  final DateTime startedAt;
  @override
  final DateTime? completedAt;
  @override
  final String status;

  @override
  String toString() {
    return 'PracticeSessionSummary(id: $id, sessionType: $sessionType, examType: $examType, subject: $subject, totalQuestions: $totalQuestions, answeredQuestions: $answeredQuestions, correctAnswers: $correctAnswers, accuracyPercentage: $accuracyPercentage, totalTimeSpent: $totalTimeSpent, startedAt: $startedAt, completedAt: $completedAt, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PracticeSessionSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sessionType, sessionType) ||
                other.sessionType == sessionType) &&
            (identical(other.examType, examType) ||
                other.examType == examType) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.answeredQuestions, answeredQuestions) ||
                other.answeredQuestions == answeredQuestions) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.accuracyPercentage, accuracyPercentage) ||
                other.accuracyPercentage == accuracyPercentage) &&
            (identical(other.totalTimeSpent, totalTimeSpent) ||
                other.totalTimeSpent == totalTimeSpent) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sessionType,
    examType,
    subject,
    totalQuestions,
    answeredQuestions,
    correctAnswers,
    accuracyPercentage,
    totalTimeSpent,
    startedAt,
    completedAt,
    status,
  );

  /// Create a copy of PracticeSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PracticeSessionSummaryImplCopyWith<_$PracticeSessionSummaryImpl>
  get copyWith =>
      __$$PracticeSessionSummaryImplCopyWithImpl<_$PracticeSessionSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PracticeSessionSummaryImplToJson(this);
  }
}

abstract class _PracticeSessionSummary implements PracticeSessionSummary {
  const factory _PracticeSessionSummary({
    required final String id,
    @JsonKey(name: 'session_type') required final String sessionType,
    @JsonKey(name: 'exam_type') required final String examType,
    final String? subject,
    @JsonKey(name: 'total_questions') required final int totalQuestions,
    @JsonKey(name: 'answered_questions') required final int answeredQuestions,
    @JsonKey(name: 'correct_answers') required final int correctAnswers,
    @JsonKey(name: 'accuracy_percentage')
    required final double accuracyPercentage,
    @JsonKey(name: 'total_time_spent') required final int totalTimeSpent,
    @JsonKey(name: 'started_at') required final DateTime startedAt,
    final DateTime? completedAt,
    required final String status,
  }) = _$PracticeSessionSummaryImpl;

  factory _PracticeSessionSummary.fromJson(Map<String, dynamic> json) =
      _$PracticeSessionSummaryImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'session_type')
  String get sessionType;
  @override
  @JsonKey(name: 'exam_type')
  String get examType;
  @override
  String? get subject;
  @override
  @JsonKey(name: 'total_questions')
  int get totalQuestions;
  @override
  @JsonKey(name: 'answered_questions')
  int get answeredQuestions;
  @override
  @JsonKey(name: 'correct_answers')
  int get correctAnswers;
  @override
  @JsonKey(name: 'accuracy_percentage')
  double get accuracyPercentage;
  @override
  @JsonKey(name: 'total_time_spent')
  int get totalTimeSpent;
  @override
  @JsonKey(name: 'started_at')
  DateTime get startedAt;
  @override
  DateTime? get completedAt;
  @override
  String get status;

  /// Create a copy of PracticeSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PracticeSessionSummaryImplCopyWith<_$PracticeSessionSummaryImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PracticeSessionResponse _$PracticeSessionResponseFromJson(
  Map<String, dynamic> json,
) {
  return _PracticeSessionResponse.fromJson(json);
}

/// @nodoc
mixin _$PracticeSessionResponse {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'session_type')
  String get sessionType => throw _privateConstructorUsedError;
  PracticeSessionFilter get filterCriteria =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'current_question_index')
  int get currentQuestionIndex => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'started_at')
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_questions')
  int get totalQuestions => throw _privateConstructorUsedError;
  @JsonKey(name: 'answered_questions')
  int get answeredQuestions => throw _privateConstructorUsedError;
  @JsonKey(name: 'correct_answers')
  int get correctAnswers => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_time_spent')
  int get totalTimeSpent => throw _privateConstructorUsedError;
  PracticeSessionSettings get settings => throw _privateConstructorUsedError;
  @JsonKey(name: 'progress_percentage')
  double get progressPercentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'accuracy_percentage')
  double get accuracyPercentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_time_per_question')
  double get averageTimePerQuestion => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_question_id')
  String? get currentQuestionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_next_question')
  bool get hasNextQuestion => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_previous_question')
  bool get hasPreviousQuestion => throw _privateConstructorUsedError;

  /// Serializes this PracticeSessionResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PracticeSessionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PracticeSessionResponseCopyWith<PracticeSessionResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PracticeSessionResponseCopyWith<$Res> {
  factory $PracticeSessionResponseCopyWith(
    PracticeSessionResponse value,
    $Res Function(PracticeSessionResponse) then,
  ) = _$PracticeSessionResponseCopyWithImpl<$Res, PracticeSessionResponse>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'session_type') String sessionType,
    PracticeSessionFilter filterCriteria,
    @JsonKey(name: 'current_question_index') int currentQuestionIndex,
    String status,
    @JsonKey(name: 'started_at') DateTime startedAt,
    DateTime? completedAt,
    @JsonKey(name: 'total_questions') int totalQuestions,
    @JsonKey(name: 'answered_questions') int answeredQuestions,
    @JsonKey(name: 'correct_answers') int correctAnswers,
    @JsonKey(name: 'total_time_spent') int totalTimeSpent,
    PracticeSessionSettings settings,
    @JsonKey(name: 'progress_percentage') double progressPercentage,
    @JsonKey(name: 'accuracy_percentage') double accuracyPercentage,
    @JsonKey(name: 'average_time_per_question') double averageTimePerQuestion,
    @JsonKey(name: 'current_question_id') String? currentQuestionId,
    @JsonKey(name: 'has_next_question') bool hasNextQuestion,
    @JsonKey(name: 'has_previous_question') bool hasPreviousQuestion,
  });

  $PracticeSessionFilterCopyWith<$Res> get filterCriteria;
  $PracticeSessionSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class _$PracticeSessionResponseCopyWithImpl<
  $Res,
  $Val extends PracticeSessionResponse
>
    implements $PracticeSessionResponseCopyWith<$Res> {
  _$PracticeSessionResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PracticeSessionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionType = null,
    Object? filterCriteria = null,
    Object? currentQuestionIndex = null,
    Object? status = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? totalQuestions = null,
    Object? answeredQuestions = null,
    Object? correctAnswers = null,
    Object? totalTimeSpent = null,
    Object? settings = null,
    Object? progressPercentage = null,
    Object? accuracyPercentage = null,
    Object? averageTimePerQuestion = null,
    Object? currentQuestionId = freezed,
    Object? hasNextQuestion = null,
    Object? hasPreviousQuestion = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            sessionType: null == sessionType
                ? _value.sessionType
                : sessionType // ignore: cast_nullable_to_non_nullable
                      as String,
            filterCriteria: null == filterCriteria
                ? _value.filterCriteria
                : filterCriteria // ignore: cast_nullable_to_non_nullable
                      as PracticeSessionFilter,
            currentQuestionIndex: null == currentQuestionIndex
                ? _value.currentQuestionIndex
                : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            totalQuestions: null == totalQuestions
                ? _value.totalQuestions
                : totalQuestions // ignore: cast_nullable_to_non_nullable
                      as int,
            answeredQuestions: null == answeredQuestions
                ? _value.answeredQuestions
                : answeredQuestions // ignore: cast_nullable_to_non_nullable
                      as int,
            correctAnswers: null == correctAnswers
                ? _value.correctAnswers
                : correctAnswers // ignore: cast_nullable_to_non_nullable
                      as int,
            totalTimeSpent: null == totalTimeSpent
                ? _value.totalTimeSpent
                : totalTimeSpent // ignore: cast_nullable_to_non_nullable
                      as int,
            settings: null == settings
                ? _value.settings
                : settings // ignore: cast_nullable_to_non_nullable
                      as PracticeSessionSettings,
            progressPercentage: null == progressPercentage
                ? _value.progressPercentage
                : progressPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            accuracyPercentage: null == accuracyPercentage
                ? _value.accuracyPercentage
                : accuracyPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            averageTimePerQuestion: null == averageTimePerQuestion
                ? _value.averageTimePerQuestion
                : averageTimePerQuestion // ignore: cast_nullable_to_non_nullable
                      as double,
            currentQuestionId: freezed == currentQuestionId
                ? _value.currentQuestionId
                : currentQuestionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            hasNextQuestion: null == hasNextQuestion
                ? _value.hasNextQuestion
                : hasNextQuestion // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasPreviousQuestion: null == hasPreviousQuestion
                ? _value.hasPreviousQuestion
                : hasPreviousQuestion // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of PracticeSessionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PracticeSessionFilterCopyWith<$Res> get filterCriteria {
    return $PracticeSessionFilterCopyWith<$Res>(_value.filterCriteria, (value) {
      return _then(_value.copyWith(filterCriteria: value) as $Val);
    });
  }

  /// Create a copy of PracticeSessionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PracticeSessionSettingsCopyWith<$Res> get settings {
    return $PracticeSessionSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PracticeSessionResponseImplCopyWith<$Res>
    implements $PracticeSessionResponseCopyWith<$Res> {
  factory _$$PracticeSessionResponseImplCopyWith(
    _$PracticeSessionResponseImpl value,
    $Res Function(_$PracticeSessionResponseImpl) then,
  ) = __$$PracticeSessionResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'session_type') String sessionType,
    PracticeSessionFilter filterCriteria,
    @JsonKey(name: 'current_question_index') int currentQuestionIndex,
    String status,
    @JsonKey(name: 'started_at') DateTime startedAt,
    DateTime? completedAt,
    @JsonKey(name: 'total_questions') int totalQuestions,
    @JsonKey(name: 'answered_questions') int answeredQuestions,
    @JsonKey(name: 'correct_answers') int correctAnswers,
    @JsonKey(name: 'total_time_spent') int totalTimeSpent,
    PracticeSessionSettings settings,
    @JsonKey(name: 'progress_percentage') double progressPercentage,
    @JsonKey(name: 'accuracy_percentage') double accuracyPercentage,
    @JsonKey(name: 'average_time_per_question') double averageTimePerQuestion,
    @JsonKey(name: 'current_question_id') String? currentQuestionId,
    @JsonKey(name: 'has_next_question') bool hasNextQuestion,
    @JsonKey(name: 'has_previous_question') bool hasPreviousQuestion,
  });

  @override
  $PracticeSessionFilterCopyWith<$Res> get filterCriteria;
  @override
  $PracticeSessionSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class __$$PracticeSessionResponseImplCopyWithImpl<$Res>
    extends
        _$PracticeSessionResponseCopyWithImpl<
          $Res,
          _$PracticeSessionResponseImpl
        >
    implements _$$PracticeSessionResponseImplCopyWith<$Res> {
  __$$PracticeSessionResponseImplCopyWithImpl(
    _$PracticeSessionResponseImpl _value,
    $Res Function(_$PracticeSessionResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PracticeSessionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionType = null,
    Object? filterCriteria = null,
    Object? currentQuestionIndex = null,
    Object? status = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? totalQuestions = null,
    Object? answeredQuestions = null,
    Object? correctAnswers = null,
    Object? totalTimeSpent = null,
    Object? settings = null,
    Object? progressPercentage = null,
    Object? accuracyPercentage = null,
    Object? averageTimePerQuestion = null,
    Object? currentQuestionId = freezed,
    Object? hasNextQuestion = null,
    Object? hasPreviousQuestion = null,
  }) {
    return _then(
      _$PracticeSessionResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        sessionType: null == sessionType
            ? _value.sessionType
            : sessionType // ignore: cast_nullable_to_non_nullable
                  as String,
        filterCriteria: null == filterCriteria
            ? _value.filterCriteria
            : filterCriteria // ignore: cast_nullable_to_non_nullable
                  as PracticeSessionFilter,
        currentQuestionIndex: null == currentQuestionIndex
            ? _value.currentQuestionIndex
            : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        totalQuestions: null == totalQuestions
            ? _value.totalQuestions
            : totalQuestions // ignore: cast_nullable_to_non_nullable
                  as int,
        answeredQuestions: null == answeredQuestions
            ? _value.answeredQuestions
            : answeredQuestions // ignore: cast_nullable_to_non_nullable
                  as int,
        correctAnswers: null == correctAnswers
            ? _value.correctAnswers
            : correctAnswers // ignore: cast_nullable_to_non_nullable
                  as int,
        totalTimeSpent: null == totalTimeSpent
            ? _value.totalTimeSpent
            : totalTimeSpent // ignore: cast_nullable_to_non_nullable
                  as int,
        settings: null == settings
            ? _value.settings
            : settings // ignore: cast_nullable_to_non_nullable
                  as PracticeSessionSettings,
        progressPercentage: null == progressPercentage
            ? _value.progressPercentage
            : progressPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        accuracyPercentage: null == accuracyPercentage
            ? _value.accuracyPercentage
            : accuracyPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        averageTimePerQuestion: null == averageTimePerQuestion
            ? _value.averageTimePerQuestion
            : averageTimePerQuestion // ignore: cast_nullable_to_non_nullable
                  as double,
        currentQuestionId: freezed == currentQuestionId
            ? _value.currentQuestionId
            : currentQuestionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        hasNextQuestion: null == hasNextQuestion
            ? _value.hasNextQuestion
            : hasNextQuestion // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasPreviousQuestion: null == hasPreviousQuestion
            ? _value.hasPreviousQuestion
            : hasPreviousQuestion // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PracticeSessionResponseImpl implements _PracticeSessionResponse {
  const _$PracticeSessionResponseImpl({
    required this.id,
    @JsonKey(name: 'session_type') required this.sessionType,
    required this.filterCriteria,
    @JsonKey(name: 'current_question_index') required this.currentQuestionIndex,
    required this.status,
    @JsonKey(name: 'started_at') required this.startedAt,
    this.completedAt,
    @JsonKey(name: 'total_questions') required this.totalQuestions,
    @JsonKey(name: 'answered_questions') required this.answeredQuestions,
    @JsonKey(name: 'correct_answers') required this.correctAnswers,
    @JsonKey(name: 'total_time_spent') required this.totalTimeSpent,
    required this.settings,
    @JsonKey(name: 'progress_percentage') required this.progressPercentage,
    @JsonKey(name: 'accuracy_percentage') required this.accuracyPercentage,
    @JsonKey(name: 'average_time_per_question')
    required this.averageTimePerQuestion,
    @JsonKey(name: 'current_question_id') this.currentQuestionId,
    @JsonKey(name: 'has_next_question') required this.hasNextQuestion,
    @JsonKey(name: 'has_previous_question') required this.hasPreviousQuestion,
  });

  factory _$PracticeSessionResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PracticeSessionResponseImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'session_type')
  final String sessionType;
  @override
  final PracticeSessionFilter filterCriteria;
  @override
  @JsonKey(name: 'current_question_index')
  final int currentQuestionIndex;
  @override
  final String status;
  @override
  @JsonKey(name: 'started_at')
  final DateTime startedAt;
  @override
  final DateTime? completedAt;
  @override
  @JsonKey(name: 'total_questions')
  final int totalQuestions;
  @override
  @JsonKey(name: 'answered_questions')
  final int answeredQuestions;
  @override
  @JsonKey(name: 'correct_answers')
  final int correctAnswers;
  @override
  @JsonKey(name: 'total_time_spent')
  final int totalTimeSpent;
  @override
  final PracticeSessionSettings settings;
  @override
  @JsonKey(name: 'progress_percentage')
  final double progressPercentage;
  @override
  @JsonKey(name: 'accuracy_percentage')
  final double accuracyPercentage;
  @override
  @JsonKey(name: 'average_time_per_question')
  final double averageTimePerQuestion;
  @override
  @JsonKey(name: 'current_question_id')
  final String? currentQuestionId;
  @override
  @JsonKey(name: 'has_next_question')
  final bool hasNextQuestion;
  @override
  @JsonKey(name: 'has_previous_question')
  final bool hasPreviousQuestion;

  @override
  String toString() {
    return 'PracticeSessionResponse(id: $id, sessionType: $sessionType, filterCriteria: $filterCriteria, currentQuestionIndex: $currentQuestionIndex, status: $status, startedAt: $startedAt, completedAt: $completedAt, totalQuestions: $totalQuestions, answeredQuestions: $answeredQuestions, correctAnswers: $correctAnswers, totalTimeSpent: $totalTimeSpent, settings: $settings, progressPercentage: $progressPercentage, accuracyPercentage: $accuracyPercentage, averageTimePerQuestion: $averageTimePerQuestion, currentQuestionId: $currentQuestionId, hasNextQuestion: $hasNextQuestion, hasPreviousQuestion: $hasPreviousQuestion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PracticeSessionResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sessionType, sessionType) ||
                other.sessionType == sessionType) &&
            (identical(other.filterCriteria, filterCriteria) ||
                other.filterCriteria == filterCriteria) &&
            (identical(other.currentQuestionIndex, currentQuestionIndex) ||
                other.currentQuestionIndex == currentQuestionIndex) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.answeredQuestions, answeredQuestions) ||
                other.answeredQuestions == answeredQuestions) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.totalTimeSpent, totalTimeSpent) ||
                other.totalTimeSpent == totalTimeSpent) &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.progressPercentage, progressPercentage) ||
                other.progressPercentage == progressPercentage) &&
            (identical(other.accuracyPercentage, accuracyPercentage) ||
                other.accuracyPercentage == accuracyPercentage) &&
            (identical(other.averageTimePerQuestion, averageTimePerQuestion) ||
                other.averageTimePerQuestion == averageTimePerQuestion) &&
            (identical(other.currentQuestionId, currentQuestionId) ||
                other.currentQuestionId == currentQuestionId) &&
            (identical(other.hasNextQuestion, hasNextQuestion) ||
                other.hasNextQuestion == hasNextQuestion) &&
            (identical(other.hasPreviousQuestion, hasPreviousQuestion) ||
                other.hasPreviousQuestion == hasPreviousQuestion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sessionType,
    filterCriteria,
    currentQuestionIndex,
    status,
    startedAt,
    completedAt,
    totalQuestions,
    answeredQuestions,
    correctAnswers,
    totalTimeSpent,
    settings,
    progressPercentage,
    accuracyPercentage,
    averageTimePerQuestion,
    currentQuestionId,
    hasNextQuestion,
    hasPreviousQuestion,
  );

  /// Create a copy of PracticeSessionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PracticeSessionResponseImplCopyWith<_$PracticeSessionResponseImpl>
  get copyWith =>
      __$$PracticeSessionResponseImplCopyWithImpl<
        _$PracticeSessionResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PracticeSessionResponseImplToJson(this);
  }
}

abstract class _PracticeSessionResponse implements PracticeSessionResponse {
  const factory _PracticeSessionResponse({
    required final String id,
    @JsonKey(name: 'session_type') required final String sessionType,
    required final PracticeSessionFilter filterCriteria,
    @JsonKey(name: 'current_question_index')
    required final int currentQuestionIndex,
    required final String status,
    @JsonKey(name: 'started_at') required final DateTime startedAt,
    final DateTime? completedAt,
    @JsonKey(name: 'total_questions') required final int totalQuestions,
    @JsonKey(name: 'answered_questions') required final int answeredQuestions,
    @JsonKey(name: 'correct_answers') required final int correctAnswers,
    @JsonKey(name: 'total_time_spent') required final int totalTimeSpent,
    required final PracticeSessionSettings settings,
    @JsonKey(name: 'progress_percentage')
    required final double progressPercentage,
    @JsonKey(name: 'accuracy_percentage')
    required final double accuracyPercentage,
    @JsonKey(name: 'average_time_per_question')
    required final double averageTimePerQuestion,
    @JsonKey(name: 'current_question_id') final String? currentQuestionId,
    @JsonKey(name: 'has_next_question') required final bool hasNextQuestion,
    @JsonKey(name: 'has_previous_question')
    required final bool hasPreviousQuestion,
  }) = _$PracticeSessionResponseImpl;

  factory _PracticeSessionResponse.fromJson(Map<String, dynamic> json) =
      _$PracticeSessionResponseImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'session_type')
  String get sessionType;
  @override
  PracticeSessionFilter get filterCriteria;
  @override
  @JsonKey(name: 'current_question_index')
  int get currentQuestionIndex;
  @override
  String get status;
  @override
  @JsonKey(name: 'started_at')
  DateTime get startedAt;
  @override
  DateTime? get completedAt;
  @override
  @JsonKey(name: 'total_questions')
  int get totalQuestions;
  @override
  @JsonKey(name: 'answered_questions')
  int get answeredQuestions;
  @override
  @JsonKey(name: 'correct_answers')
  int get correctAnswers;
  @override
  @JsonKey(name: 'total_time_spent')
  int get totalTimeSpent;
  @override
  PracticeSessionSettings get settings;
  @override
  @JsonKey(name: 'progress_percentage')
  double get progressPercentage;
  @override
  @JsonKey(name: 'accuracy_percentage')
  double get accuracyPercentage;
  @override
  @JsonKey(name: 'average_time_per_question')
  double get averageTimePerQuestion;
  @override
  @JsonKey(name: 'current_question_id')
  String? get currentQuestionId;
  @override
  @JsonKey(name: 'has_next_question')
  bool get hasNextQuestion;
  @override
  @JsonKey(name: 'has_previous_question')
  bool get hasPreviousQuestion;

  /// Create a copy of PracticeSessionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PracticeSessionResponseImplCopyWith<_$PracticeSessionResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PracticeSessionAttempt _$PracticeSessionAttemptFromJson(
  Map<String, dynamic> json,
) {
  return _PracticeSessionAttempt.fromJson(json);
}

/// @nodoc
mixin _$PracticeSessionAttempt {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'session_id')
  String get sessionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'question_id')
  String get questionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'selected_answers')
  List<String> get selectedAnswers => throw _privateConstructorUsedError;
  @JsonKey(name: 'correct_answers')
  List<String> get correctAnswers => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_correct')
  bool get isCorrect => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_spent')
  int get timeSpent => throw _privateConstructorUsedError;
  @JsonKey(name: 'attempt_number')
  int get attemptNumber => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  @JsonKey(name: 'explanation_shown')
  bool get explanationShown => throw _privateConstructorUsedError;
  @JsonKey(name: 'hint_used')
  bool get hintUsed => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this PracticeSessionAttempt to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PracticeSessionAttempt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PracticeSessionAttemptCopyWith<PracticeSessionAttempt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PracticeSessionAttemptCopyWith<$Res> {
  factory $PracticeSessionAttemptCopyWith(
    PracticeSessionAttempt value,
    $Res Function(PracticeSessionAttempt) then,
  ) = _$PracticeSessionAttemptCopyWithImpl<$Res, PracticeSessionAttempt>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'session_id') String sessionId,
    @JsonKey(name: 'question_id') String questionId,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'selected_answers') List<String> selectedAnswers,
    @JsonKey(name: 'correct_answers') List<String> correctAnswers,
    @JsonKey(name: 'is_correct') bool isCorrect,
    @JsonKey(name: 'time_spent') int timeSpent,
    @JsonKey(name: 'attempt_number') int attemptNumber,
    DateTime timestamp,
    @JsonKey(name: 'explanation_shown') bool explanationShown,
    @JsonKey(name: 'hint_used') bool hintUsed,
    String? notes,
  });
}

/// @nodoc
class _$PracticeSessionAttemptCopyWithImpl<
  $Res,
  $Val extends PracticeSessionAttempt
>
    implements $PracticeSessionAttemptCopyWith<$Res> {
  _$PracticeSessionAttemptCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PracticeSessionAttempt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? questionId = null,
    Object? userId = null,
    Object? selectedAnswers = null,
    Object? correctAnswers = null,
    Object? isCorrect = null,
    Object? timeSpent = null,
    Object? attemptNumber = null,
    Object? timestamp = null,
    Object? explanationShown = null,
    Object? hintUsed = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            sessionId: null == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                      as String,
            questionId: null == questionId
                ? _value.questionId
                : questionId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedAnswers: null == selectedAnswers
                ? _value.selectedAnswers
                : selectedAnswers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            correctAnswers: null == correctAnswers
                ? _value.correctAnswers
                : correctAnswers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isCorrect: null == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool,
            timeSpent: null == timeSpent
                ? _value.timeSpent
                : timeSpent // ignore: cast_nullable_to_non_nullable
                      as int,
            attemptNumber: null == attemptNumber
                ? _value.attemptNumber
                : attemptNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            explanationShown: null == explanationShown
                ? _value.explanationShown
                : explanationShown // ignore: cast_nullable_to_non_nullable
                      as bool,
            hintUsed: null == hintUsed
                ? _value.hintUsed
                : hintUsed // ignore: cast_nullable_to_non_nullable
                      as bool,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PracticeSessionAttemptImplCopyWith<$Res>
    implements $PracticeSessionAttemptCopyWith<$Res> {
  factory _$$PracticeSessionAttemptImplCopyWith(
    _$PracticeSessionAttemptImpl value,
    $Res Function(_$PracticeSessionAttemptImpl) then,
  ) = __$$PracticeSessionAttemptImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'session_id') String sessionId,
    @JsonKey(name: 'question_id') String questionId,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'selected_answers') List<String> selectedAnswers,
    @JsonKey(name: 'correct_answers') List<String> correctAnswers,
    @JsonKey(name: 'is_correct') bool isCorrect,
    @JsonKey(name: 'time_spent') int timeSpent,
    @JsonKey(name: 'attempt_number') int attemptNumber,
    DateTime timestamp,
    @JsonKey(name: 'explanation_shown') bool explanationShown,
    @JsonKey(name: 'hint_used') bool hintUsed,
    String? notes,
  });
}

/// @nodoc
class __$$PracticeSessionAttemptImplCopyWithImpl<$Res>
    extends
        _$PracticeSessionAttemptCopyWithImpl<$Res, _$PracticeSessionAttemptImpl>
    implements _$$PracticeSessionAttemptImplCopyWith<$Res> {
  __$$PracticeSessionAttemptImplCopyWithImpl(
    _$PracticeSessionAttemptImpl _value,
    $Res Function(_$PracticeSessionAttemptImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PracticeSessionAttempt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? questionId = null,
    Object? userId = null,
    Object? selectedAnswers = null,
    Object? correctAnswers = null,
    Object? isCorrect = null,
    Object? timeSpent = null,
    Object? attemptNumber = null,
    Object? timestamp = null,
    Object? explanationShown = null,
    Object? hintUsed = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$PracticeSessionAttemptImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        sessionId: null == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                  as String,
        questionId: null == questionId
            ? _value.questionId
            : questionId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedAnswers: null == selectedAnswers
            ? _value._selectedAnswers
            : selectedAnswers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        correctAnswers: null == correctAnswers
            ? _value._correctAnswers
            : correctAnswers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isCorrect: null == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool,
        timeSpent: null == timeSpent
            ? _value.timeSpent
            : timeSpent // ignore: cast_nullable_to_non_nullable
                  as int,
        attemptNumber: null == attemptNumber
            ? _value.attemptNumber
            : attemptNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        explanationShown: null == explanationShown
            ? _value.explanationShown
            : explanationShown // ignore: cast_nullable_to_non_nullable
                  as bool,
        hintUsed: null == hintUsed
            ? _value.hintUsed
            : hintUsed // ignore: cast_nullable_to_non_nullable
                  as bool,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PracticeSessionAttemptImpl implements _PracticeSessionAttempt {
  const _$PracticeSessionAttemptImpl({
    required this.id,
    @JsonKey(name: 'session_id') required this.sessionId,
    @JsonKey(name: 'question_id') required this.questionId,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'selected_answers')
    required final List<String> selectedAnswers,
    @JsonKey(name: 'correct_answers')
    required final List<String> correctAnswers,
    @JsonKey(name: 'is_correct') required this.isCorrect,
    @JsonKey(name: 'time_spent') required this.timeSpent,
    @JsonKey(name: 'attempt_number') this.attemptNumber = 1,
    required this.timestamp,
    @JsonKey(name: 'explanation_shown') this.explanationShown = false,
    @JsonKey(name: 'hint_used') this.hintUsed = false,
    this.notes,
  }) : _selectedAnswers = selectedAnswers,
       _correctAnswers = correctAnswers;

  factory _$PracticeSessionAttemptImpl.fromJson(Map<String, dynamic> json) =>
      _$$PracticeSessionAttemptImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'session_id')
  final String sessionId;
  @override
  @JsonKey(name: 'question_id')
  final String questionId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  final List<String> _selectedAnswers;
  @override
  @JsonKey(name: 'selected_answers')
  List<String> get selectedAnswers {
    if (_selectedAnswers is EqualUnmodifiableListView) return _selectedAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedAnswers);
  }

  final List<String> _correctAnswers;
  @override
  @JsonKey(name: 'correct_answers')
  List<String> get correctAnswers {
    if (_correctAnswers is EqualUnmodifiableListView) return _correctAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_correctAnswers);
  }

  @override
  @JsonKey(name: 'is_correct')
  final bool isCorrect;
  @override
  @JsonKey(name: 'time_spent')
  final int timeSpent;
  @override
  @JsonKey(name: 'attempt_number')
  final int attemptNumber;
  @override
  final DateTime timestamp;
  @override
  @JsonKey(name: 'explanation_shown')
  final bool explanationShown;
  @override
  @JsonKey(name: 'hint_used')
  final bool hintUsed;
  @override
  final String? notes;

  @override
  String toString() {
    return 'PracticeSessionAttempt(id: $id, sessionId: $sessionId, questionId: $questionId, userId: $userId, selectedAnswers: $selectedAnswers, correctAnswers: $correctAnswers, isCorrect: $isCorrect, timeSpent: $timeSpent, attemptNumber: $attemptNumber, timestamp: $timestamp, explanationShown: $explanationShown, hintUsed: $hintUsed, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PracticeSessionAttemptImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(
              other._selectedAnswers,
              _selectedAnswers,
            ) &&
            const DeepCollectionEquality().equals(
              other._correctAnswers,
              _correctAnswers,
            ) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.timeSpent, timeSpent) ||
                other.timeSpent == timeSpent) &&
            (identical(other.attemptNumber, attemptNumber) ||
                other.attemptNumber == attemptNumber) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.explanationShown, explanationShown) ||
                other.explanationShown == explanationShown) &&
            (identical(other.hintUsed, hintUsed) ||
                other.hintUsed == hintUsed) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sessionId,
    questionId,
    userId,
    const DeepCollectionEquality().hash(_selectedAnswers),
    const DeepCollectionEquality().hash(_correctAnswers),
    isCorrect,
    timeSpent,
    attemptNumber,
    timestamp,
    explanationShown,
    hintUsed,
    notes,
  );

  /// Create a copy of PracticeSessionAttempt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PracticeSessionAttemptImplCopyWith<_$PracticeSessionAttemptImpl>
  get copyWith =>
      __$$PracticeSessionAttemptImplCopyWithImpl<_$PracticeSessionAttemptImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PracticeSessionAttemptImplToJson(this);
  }
}

abstract class _PracticeSessionAttempt implements PracticeSessionAttempt {
  const factory _PracticeSessionAttempt({
    required final String id,
    @JsonKey(name: 'session_id') required final String sessionId,
    @JsonKey(name: 'question_id') required final String questionId,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'selected_answers')
    required final List<String> selectedAnswers,
    @JsonKey(name: 'correct_answers')
    required final List<String> correctAnswers,
    @JsonKey(name: 'is_correct') required final bool isCorrect,
    @JsonKey(name: 'time_spent') required final int timeSpent,
    @JsonKey(name: 'attempt_number') final int attemptNumber,
    required final DateTime timestamp,
    @JsonKey(name: 'explanation_shown') final bool explanationShown,
    @JsonKey(name: 'hint_used') final bool hintUsed,
    final String? notes,
  }) = _$PracticeSessionAttemptImpl;

  factory _PracticeSessionAttempt.fromJson(Map<String, dynamic> json) =
      _$PracticeSessionAttemptImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'session_id')
  String get sessionId;
  @override
  @JsonKey(name: 'question_id')
  String get questionId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'selected_answers')
  List<String> get selectedAnswers;
  @override
  @JsonKey(name: 'correct_answers')
  List<String> get correctAnswers;
  @override
  @JsonKey(name: 'is_correct')
  bool get isCorrect;
  @override
  @JsonKey(name: 'time_spent')
  int get timeSpent;
  @override
  @JsonKey(name: 'attempt_number')
  int get attemptNumber;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(name: 'explanation_shown')
  bool get explanationShown;
  @override
  @JsonKey(name: 'hint_used')
  bool get hintUsed;
  @override
  String? get notes;

  /// Create a copy of PracticeSessionAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PracticeSessionAttemptImplCopyWith<_$PracticeSessionAttemptImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PracticeSessionStatistics _$PracticeSessionStatisticsFromJson(
  Map<String, dynamic> json,
) {
  return _PracticeSessionStatistics.fromJson(json);
}

/// @nodoc
mixin _$PracticeSessionStatistics {
  @JsonKey(name: 'session_id')
  String get sessionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_questions')
  int get totalQuestions => throw _privateConstructorUsedError;
  @JsonKey(name: 'answered_questions')
  int get answeredQuestions => throw _privateConstructorUsedError;
  @JsonKey(name: 'correct_answers')
  int get correctAnswers => throw _privateConstructorUsedError;
  @JsonKey(name: 'incorrect_answers')
  int get incorrectAnswers => throw _privateConstructorUsedError;
  @JsonKey(name: 'skipped_questions')
  int get skippedQuestions => throw _privateConstructorUsedError;
  @JsonKey(name: 'accuracy_percentage')
  double get accuracyPercentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_time_spent')
  int get totalTimeSpent => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_time_per_question')
  double get averageTimePerQuestion => throw _privateConstructorUsedError;
  @JsonKey(name: 'fastest_correct_time')
  int? get fastestCorrectTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'slowest_correct_time')
  int? get slowestCorrectTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'subject_breakdown')
  Map<String, dynamic> get subjectBreakdown =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'difficulty_breakdown')
  Map<String, dynamic> get difficultyBreakdown =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'time_distribution')
  Map<String, dynamic> get timeDistribution =>
      throw _privateConstructorUsedError;

  /// Serializes this PracticeSessionStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PracticeSessionStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PracticeSessionStatisticsCopyWith<PracticeSessionStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PracticeSessionStatisticsCopyWith<$Res> {
  factory $PracticeSessionStatisticsCopyWith(
    PracticeSessionStatistics value,
    $Res Function(PracticeSessionStatistics) then,
  ) = _$PracticeSessionStatisticsCopyWithImpl<$Res, PracticeSessionStatistics>;
  @useResult
  $Res call({
    @JsonKey(name: 'session_id') String sessionId,
    @JsonKey(name: 'total_questions') int totalQuestions,
    @JsonKey(name: 'answered_questions') int answeredQuestions,
    @JsonKey(name: 'correct_answers') int correctAnswers,
    @JsonKey(name: 'incorrect_answers') int incorrectAnswers,
    @JsonKey(name: 'skipped_questions') int skippedQuestions,
    @JsonKey(name: 'accuracy_percentage') double accuracyPercentage,
    @JsonKey(name: 'total_time_spent') int totalTimeSpent,
    @JsonKey(name: 'average_time_per_question') double averageTimePerQuestion,
    @JsonKey(name: 'fastest_correct_time') int? fastestCorrectTime,
    @JsonKey(name: 'slowest_correct_time') int? slowestCorrectTime,
    @JsonKey(name: 'subject_breakdown') Map<String, dynamic> subjectBreakdown,
    @JsonKey(name: 'difficulty_breakdown')
    Map<String, dynamic> difficultyBreakdown,
    @JsonKey(name: 'time_distribution') Map<String, dynamic> timeDistribution,
  });
}

/// @nodoc
class _$PracticeSessionStatisticsCopyWithImpl<
  $Res,
  $Val extends PracticeSessionStatistics
>
    implements $PracticeSessionStatisticsCopyWith<$Res> {
  _$PracticeSessionStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PracticeSessionStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? totalQuestions = null,
    Object? answeredQuestions = null,
    Object? correctAnswers = null,
    Object? incorrectAnswers = null,
    Object? skippedQuestions = null,
    Object? accuracyPercentage = null,
    Object? totalTimeSpent = null,
    Object? averageTimePerQuestion = null,
    Object? fastestCorrectTime = freezed,
    Object? slowestCorrectTime = freezed,
    Object? subjectBreakdown = null,
    Object? difficultyBreakdown = null,
    Object? timeDistribution = null,
  }) {
    return _then(
      _value.copyWith(
            sessionId: null == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                      as String,
            totalQuestions: null == totalQuestions
                ? _value.totalQuestions
                : totalQuestions // ignore: cast_nullable_to_non_nullable
                      as int,
            answeredQuestions: null == answeredQuestions
                ? _value.answeredQuestions
                : answeredQuestions // ignore: cast_nullable_to_non_nullable
                      as int,
            correctAnswers: null == correctAnswers
                ? _value.correctAnswers
                : correctAnswers // ignore: cast_nullable_to_non_nullable
                      as int,
            incorrectAnswers: null == incorrectAnswers
                ? _value.incorrectAnswers
                : incorrectAnswers // ignore: cast_nullable_to_non_nullable
                      as int,
            skippedQuestions: null == skippedQuestions
                ? _value.skippedQuestions
                : skippedQuestions // ignore: cast_nullable_to_non_nullable
                      as int,
            accuracyPercentage: null == accuracyPercentage
                ? _value.accuracyPercentage
                : accuracyPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            totalTimeSpent: null == totalTimeSpent
                ? _value.totalTimeSpent
                : totalTimeSpent // ignore: cast_nullable_to_non_nullable
                      as int,
            averageTimePerQuestion: null == averageTimePerQuestion
                ? _value.averageTimePerQuestion
                : averageTimePerQuestion // ignore: cast_nullable_to_non_nullable
                      as double,
            fastestCorrectTime: freezed == fastestCorrectTime
                ? _value.fastestCorrectTime
                : fastestCorrectTime // ignore: cast_nullable_to_non_nullable
                      as int?,
            slowestCorrectTime: freezed == slowestCorrectTime
                ? _value.slowestCorrectTime
                : slowestCorrectTime // ignore: cast_nullable_to_non_nullable
                      as int?,
            subjectBreakdown: null == subjectBreakdown
                ? _value.subjectBreakdown
                : subjectBreakdown // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            difficultyBreakdown: null == difficultyBreakdown
                ? _value.difficultyBreakdown
                : difficultyBreakdown // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            timeDistribution: null == timeDistribution
                ? _value.timeDistribution
                : timeDistribution // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PracticeSessionStatisticsImplCopyWith<$Res>
    implements $PracticeSessionStatisticsCopyWith<$Res> {
  factory _$$PracticeSessionStatisticsImplCopyWith(
    _$PracticeSessionStatisticsImpl value,
    $Res Function(_$PracticeSessionStatisticsImpl) then,
  ) = __$$PracticeSessionStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'session_id') String sessionId,
    @JsonKey(name: 'total_questions') int totalQuestions,
    @JsonKey(name: 'answered_questions') int answeredQuestions,
    @JsonKey(name: 'correct_answers') int correctAnswers,
    @JsonKey(name: 'incorrect_answers') int incorrectAnswers,
    @JsonKey(name: 'skipped_questions') int skippedQuestions,
    @JsonKey(name: 'accuracy_percentage') double accuracyPercentage,
    @JsonKey(name: 'total_time_spent') int totalTimeSpent,
    @JsonKey(name: 'average_time_per_question') double averageTimePerQuestion,
    @JsonKey(name: 'fastest_correct_time') int? fastestCorrectTime,
    @JsonKey(name: 'slowest_correct_time') int? slowestCorrectTime,
    @JsonKey(name: 'subject_breakdown') Map<String, dynamic> subjectBreakdown,
    @JsonKey(name: 'difficulty_breakdown')
    Map<String, dynamic> difficultyBreakdown,
    @JsonKey(name: 'time_distribution') Map<String, dynamic> timeDistribution,
  });
}

/// @nodoc
class __$$PracticeSessionStatisticsImplCopyWithImpl<$Res>
    extends
        _$PracticeSessionStatisticsCopyWithImpl<
          $Res,
          _$PracticeSessionStatisticsImpl
        >
    implements _$$PracticeSessionStatisticsImplCopyWith<$Res> {
  __$$PracticeSessionStatisticsImplCopyWithImpl(
    _$PracticeSessionStatisticsImpl _value,
    $Res Function(_$PracticeSessionStatisticsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PracticeSessionStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? totalQuestions = null,
    Object? answeredQuestions = null,
    Object? correctAnswers = null,
    Object? incorrectAnswers = null,
    Object? skippedQuestions = null,
    Object? accuracyPercentage = null,
    Object? totalTimeSpent = null,
    Object? averageTimePerQuestion = null,
    Object? fastestCorrectTime = freezed,
    Object? slowestCorrectTime = freezed,
    Object? subjectBreakdown = null,
    Object? difficultyBreakdown = null,
    Object? timeDistribution = null,
  }) {
    return _then(
      _$PracticeSessionStatisticsImpl(
        sessionId: null == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                  as String,
        totalQuestions: null == totalQuestions
            ? _value.totalQuestions
            : totalQuestions // ignore: cast_nullable_to_non_nullable
                  as int,
        answeredQuestions: null == answeredQuestions
            ? _value.answeredQuestions
            : answeredQuestions // ignore: cast_nullable_to_non_nullable
                  as int,
        correctAnswers: null == correctAnswers
            ? _value.correctAnswers
            : correctAnswers // ignore: cast_nullable_to_non_nullable
                  as int,
        incorrectAnswers: null == incorrectAnswers
            ? _value.incorrectAnswers
            : incorrectAnswers // ignore: cast_nullable_to_non_nullable
                  as int,
        skippedQuestions: null == skippedQuestions
            ? _value.skippedQuestions
            : skippedQuestions // ignore: cast_nullable_to_non_nullable
                  as int,
        accuracyPercentage: null == accuracyPercentage
            ? _value.accuracyPercentage
            : accuracyPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        totalTimeSpent: null == totalTimeSpent
            ? _value.totalTimeSpent
            : totalTimeSpent // ignore: cast_nullable_to_non_nullable
                  as int,
        averageTimePerQuestion: null == averageTimePerQuestion
            ? _value.averageTimePerQuestion
            : averageTimePerQuestion // ignore: cast_nullable_to_non_nullable
                  as double,
        fastestCorrectTime: freezed == fastestCorrectTime
            ? _value.fastestCorrectTime
            : fastestCorrectTime // ignore: cast_nullable_to_non_nullable
                  as int?,
        slowestCorrectTime: freezed == slowestCorrectTime
            ? _value.slowestCorrectTime
            : slowestCorrectTime // ignore: cast_nullable_to_non_nullable
                  as int?,
        subjectBreakdown: null == subjectBreakdown
            ? _value._subjectBreakdown
            : subjectBreakdown // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        difficultyBreakdown: null == difficultyBreakdown
            ? _value._difficultyBreakdown
            : difficultyBreakdown // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        timeDistribution: null == timeDistribution
            ? _value._timeDistribution
            : timeDistribution // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PracticeSessionStatisticsImpl implements _PracticeSessionStatistics {
  const _$PracticeSessionStatisticsImpl({
    @JsonKey(name: 'session_id') required this.sessionId,
    @JsonKey(name: 'total_questions') required this.totalQuestions,
    @JsonKey(name: 'answered_questions') required this.answeredQuestions,
    @JsonKey(name: 'correct_answers') required this.correctAnswers,
    @JsonKey(name: 'incorrect_answers') required this.incorrectAnswers,
    @JsonKey(name: 'skipped_questions') required this.skippedQuestions,
    @JsonKey(name: 'accuracy_percentage') required this.accuracyPercentage,
    @JsonKey(name: 'total_time_spent') required this.totalTimeSpent,
    @JsonKey(name: 'average_time_per_question')
    required this.averageTimePerQuestion,
    @JsonKey(name: 'fastest_correct_time') this.fastestCorrectTime,
    @JsonKey(name: 'slowest_correct_time') this.slowestCorrectTime,
    @JsonKey(name: 'subject_breakdown')
    required final Map<String, dynamic> subjectBreakdown,
    @JsonKey(name: 'difficulty_breakdown')
    required final Map<String, dynamic> difficultyBreakdown,
    @JsonKey(name: 'time_distribution')
    required final Map<String, dynamic> timeDistribution,
  }) : _subjectBreakdown = subjectBreakdown,
       _difficultyBreakdown = difficultyBreakdown,
       _timeDistribution = timeDistribution;

  factory _$PracticeSessionStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PracticeSessionStatisticsImplFromJson(json);

  @override
  @JsonKey(name: 'session_id')
  final String sessionId;
  @override
  @JsonKey(name: 'total_questions')
  final int totalQuestions;
  @override
  @JsonKey(name: 'answered_questions')
  final int answeredQuestions;
  @override
  @JsonKey(name: 'correct_answers')
  final int correctAnswers;
  @override
  @JsonKey(name: 'incorrect_answers')
  final int incorrectAnswers;
  @override
  @JsonKey(name: 'skipped_questions')
  final int skippedQuestions;
  @override
  @JsonKey(name: 'accuracy_percentage')
  final double accuracyPercentage;
  @override
  @JsonKey(name: 'total_time_spent')
  final int totalTimeSpent;
  @override
  @JsonKey(name: 'average_time_per_question')
  final double averageTimePerQuestion;
  @override
  @JsonKey(name: 'fastest_correct_time')
  final int? fastestCorrectTime;
  @override
  @JsonKey(name: 'slowest_correct_time')
  final int? slowestCorrectTime;
  final Map<String, dynamic> _subjectBreakdown;
  @override
  @JsonKey(name: 'subject_breakdown')
  Map<String, dynamic> get subjectBreakdown {
    if (_subjectBreakdown is EqualUnmodifiableMapView) return _subjectBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_subjectBreakdown);
  }

  final Map<String, dynamic> _difficultyBreakdown;
  @override
  @JsonKey(name: 'difficulty_breakdown')
  Map<String, dynamic> get difficultyBreakdown {
    if (_difficultyBreakdown is EqualUnmodifiableMapView)
      return _difficultyBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_difficultyBreakdown);
  }

  final Map<String, dynamic> _timeDistribution;
  @override
  @JsonKey(name: 'time_distribution')
  Map<String, dynamic> get timeDistribution {
    if (_timeDistribution is EqualUnmodifiableMapView) return _timeDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_timeDistribution);
  }

  @override
  String toString() {
    return 'PracticeSessionStatistics(sessionId: $sessionId, totalQuestions: $totalQuestions, answeredQuestions: $answeredQuestions, correctAnswers: $correctAnswers, incorrectAnswers: $incorrectAnswers, skippedQuestions: $skippedQuestions, accuracyPercentage: $accuracyPercentage, totalTimeSpent: $totalTimeSpent, averageTimePerQuestion: $averageTimePerQuestion, fastestCorrectTime: $fastestCorrectTime, slowestCorrectTime: $slowestCorrectTime, subjectBreakdown: $subjectBreakdown, difficultyBreakdown: $difficultyBreakdown, timeDistribution: $timeDistribution)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PracticeSessionStatisticsImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.answeredQuestions, answeredQuestions) ||
                other.answeredQuestions == answeredQuestions) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.incorrectAnswers, incorrectAnswers) ||
                other.incorrectAnswers == incorrectAnswers) &&
            (identical(other.skippedQuestions, skippedQuestions) ||
                other.skippedQuestions == skippedQuestions) &&
            (identical(other.accuracyPercentage, accuracyPercentage) ||
                other.accuracyPercentage == accuracyPercentage) &&
            (identical(other.totalTimeSpent, totalTimeSpent) ||
                other.totalTimeSpent == totalTimeSpent) &&
            (identical(other.averageTimePerQuestion, averageTimePerQuestion) ||
                other.averageTimePerQuestion == averageTimePerQuestion) &&
            (identical(other.fastestCorrectTime, fastestCorrectTime) ||
                other.fastestCorrectTime == fastestCorrectTime) &&
            (identical(other.slowestCorrectTime, slowestCorrectTime) ||
                other.slowestCorrectTime == slowestCorrectTime) &&
            const DeepCollectionEquality().equals(
              other._subjectBreakdown,
              _subjectBreakdown,
            ) &&
            const DeepCollectionEquality().equals(
              other._difficultyBreakdown,
              _difficultyBreakdown,
            ) &&
            const DeepCollectionEquality().equals(
              other._timeDistribution,
              _timeDistribution,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    sessionId,
    totalQuestions,
    answeredQuestions,
    correctAnswers,
    incorrectAnswers,
    skippedQuestions,
    accuracyPercentage,
    totalTimeSpent,
    averageTimePerQuestion,
    fastestCorrectTime,
    slowestCorrectTime,
    const DeepCollectionEquality().hash(_subjectBreakdown),
    const DeepCollectionEquality().hash(_difficultyBreakdown),
    const DeepCollectionEquality().hash(_timeDistribution),
  );

  /// Create a copy of PracticeSessionStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PracticeSessionStatisticsImplCopyWith<_$PracticeSessionStatisticsImpl>
  get copyWith =>
      __$$PracticeSessionStatisticsImplCopyWithImpl<
        _$PracticeSessionStatisticsImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PracticeSessionStatisticsImplToJson(this);
  }
}

abstract class _PracticeSessionStatistics implements PracticeSessionStatistics {
  const factory _PracticeSessionStatistics({
    @JsonKey(name: 'session_id') required final String sessionId,
    @JsonKey(name: 'total_questions') required final int totalQuestions,
    @JsonKey(name: 'answered_questions') required final int answeredQuestions,
    @JsonKey(name: 'correct_answers') required final int correctAnswers,
    @JsonKey(name: 'incorrect_answers') required final int incorrectAnswers,
    @JsonKey(name: 'skipped_questions') required final int skippedQuestions,
    @JsonKey(name: 'accuracy_percentage')
    required final double accuracyPercentage,
    @JsonKey(name: 'total_time_spent') required final int totalTimeSpent,
    @JsonKey(name: 'average_time_per_question')
    required final double averageTimePerQuestion,
    @JsonKey(name: 'fastest_correct_time') final int? fastestCorrectTime,
    @JsonKey(name: 'slowest_correct_time') final int? slowestCorrectTime,
    @JsonKey(name: 'subject_breakdown')
    required final Map<String, dynamic> subjectBreakdown,
    @JsonKey(name: 'difficulty_breakdown')
    required final Map<String, dynamic> difficultyBreakdown,
    @JsonKey(name: 'time_distribution')
    required final Map<String, dynamic> timeDistribution,
  }) = _$PracticeSessionStatisticsImpl;

  factory _PracticeSessionStatistics.fromJson(Map<String, dynamic> json) =
      _$PracticeSessionStatisticsImpl.fromJson;

  @override
  @JsonKey(name: 'session_id')
  String get sessionId;
  @override
  @JsonKey(name: 'total_questions')
  int get totalQuestions;
  @override
  @JsonKey(name: 'answered_questions')
  int get answeredQuestions;
  @override
  @JsonKey(name: 'correct_answers')
  int get correctAnswers;
  @override
  @JsonKey(name: 'incorrect_answers')
  int get incorrectAnswers;
  @override
  @JsonKey(name: 'skipped_questions')
  int get skippedQuestions;
  @override
  @JsonKey(name: 'accuracy_percentage')
  double get accuracyPercentage;
  @override
  @JsonKey(name: 'total_time_spent')
  int get totalTimeSpent;
  @override
  @JsonKey(name: 'average_time_per_question')
  double get averageTimePerQuestion;
  @override
  @JsonKey(name: 'fastest_correct_time')
  int? get fastestCorrectTime;
  @override
  @JsonKey(name: 'slowest_correct_time')
  int? get slowestCorrectTime;
  @override
  @JsonKey(name: 'subject_breakdown')
  Map<String, dynamic> get subjectBreakdown;
  @override
  @JsonKey(name: 'difficulty_breakdown')
  Map<String, dynamic> get difficultyBreakdown;
  @override
  @JsonKey(name: 'time_distribution')
  Map<String, dynamic> get timeDistribution;

  /// Create a copy of PracticeSessionStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PracticeSessionStatisticsImplCopyWith<_$PracticeSessionStatisticsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PracticeSessionAttemptRequest _$PracticeSessionAttemptRequestFromJson(
  Map<String, dynamic> json,
) {
  return _PracticeSessionAttemptRequest.fromJson(json);
}

/// @nodoc
mixin _$PracticeSessionAttemptRequest {
  @JsonKey(name: 'question_id')
  String get questionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'selected_answers')
  List<String> get selectedAnswers => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_spent')
  int get timeSpent => throw _privateConstructorUsedError;
  @JsonKey(name: 'attempt_number')
  int get attemptNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'explanation_shown')
  bool get explanationShown => throw _privateConstructorUsedError;
  @JsonKey(name: 'hint_used')
  bool get hintUsed => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this PracticeSessionAttemptRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PracticeSessionAttemptRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PracticeSessionAttemptRequestCopyWith<PracticeSessionAttemptRequest>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PracticeSessionAttemptRequestCopyWith<$Res> {
  factory $PracticeSessionAttemptRequestCopyWith(
    PracticeSessionAttemptRequest value,
    $Res Function(PracticeSessionAttemptRequest) then,
  ) =
      _$PracticeSessionAttemptRequestCopyWithImpl<
        $Res,
        PracticeSessionAttemptRequest
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'question_id') String questionId,
    @JsonKey(name: 'selected_answers') List<String> selectedAnswers,
    @JsonKey(name: 'time_spent') int timeSpent,
    @JsonKey(name: 'attempt_number') int attemptNumber,
    @JsonKey(name: 'explanation_shown') bool explanationShown,
    @JsonKey(name: 'hint_used') bool hintUsed,
    String? notes,
  });
}

/// @nodoc
class _$PracticeSessionAttemptRequestCopyWithImpl<
  $Res,
  $Val extends PracticeSessionAttemptRequest
>
    implements $PracticeSessionAttemptRequestCopyWith<$Res> {
  _$PracticeSessionAttemptRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PracticeSessionAttemptRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? selectedAnswers = null,
    Object? timeSpent = null,
    Object? attemptNumber = null,
    Object? explanationShown = null,
    Object? hintUsed = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            questionId: null == questionId
                ? _value.questionId
                : questionId // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedAnswers: null == selectedAnswers
                ? _value.selectedAnswers
                : selectedAnswers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            timeSpent: null == timeSpent
                ? _value.timeSpent
                : timeSpent // ignore: cast_nullable_to_non_nullable
                      as int,
            attemptNumber: null == attemptNumber
                ? _value.attemptNumber
                : attemptNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            explanationShown: null == explanationShown
                ? _value.explanationShown
                : explanationShown // ignore: cast_nullable_to_non_nullable
                      as bool,
            hintUsed: null == hintUsed
                ? _value.hintUsed
                : hintUsed // ignore: cast_nullable_to_non_nullable
                      as bool,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PracticeSessionAttemptRequestImplCopyWith<$Res>
    implements $PracticeSessionAttemptRequestCopyWith<$Res> {
  factory _$$PracticeSessionAttemptRequestImplCopyWith(
    _$PracticeSessionAttemptRequestImpl value,
    $Res Function(_$PracticeSessionAttemptRequestImpl) then,
  ) = __$$PracticeSessionAttemptRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'question_id') String questionId,
    @JsonKey(name: 'selected_answers') List<String> selectedAnswers,
    @JsonKey(name: 'time_spent') int timeSpent,
    @JsonKey(name: 'attempt_number') int attemptNumber,
    @JsonKey(name: 'explanation_shown') bool explanationShown,
    @JsonKey(name: 'hint_used') bool hintUsed,
    String? notes,
  });
}

/// @nodoc
class __$$PracticeSessionAttemptRequestImplCopyWithImpl<$Res>
    extends
        _$PracticeSessionAttemptRequestCopyWithImpl<
          $Res,
          _$PracticeSessionAttemptRequestImpl
        >
    implements _$$PracticeSessionAttemptRequestImplCopyWith<$Res> {
  __$$PracticeSessionAttemptRequestImplCopyWithImpl(
    _$PracticeSessionAttemptRequestImpl _value,
    $Res Function(_$PracticeSessionAttemptRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PracticeSessionAttemptRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? selectedAnswers = null,
    Object? timeSpent = null,
    Object? attemptNumber = null,
    Object? explanationShown = null,
    Object? hintUsed = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$PracticeSessionAttemptRequestImpl(
        questionId: null == questionId
            ? _value.questionId
            : questionId // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedAnswers: null == selectedAnswers
            ? _value._selectedAnswers
            : selectedAnswers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        timeSpent: null == timeSpent
            ? _value.timeSpent
            : timeSpent // ignore: cast_nullable_to_non_nullable
                  as int,
        attemptNumber: null == attemptNumber
            ? _value.attemptNumber
            : attemptNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        explanationShown: null == explanationShown
            ? _value.explanationShown
            : explanationShown // ignore: cast_nullable_to_non_nullable
                  as bool,
        hintUsed: null == hintUsed
            ? _value.hintUsed
            : hintUsed // ignore: cast_nullable_to_non_nullable
                  as bool,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PracticeSessionAttemptRequestImpl
    implements _PracticeSessionAttemptRequest {
  const _$PracticeSessionAttemptRequestImpl({
    @JsonKey(name: 'question_id') required this.questionId,
    @JsonKey(name: 'selected_answers')
    required final List<String> selectedAnswers,
    @JsonKey(name: 'time_spent') required this.timeSpent,
    @JsonKey(name: 'attempt_number') this.attemptNumber = 1,
    @JsonKey(name: 'explanation_shown') this.explanationShown = false,
    @JsonKey(name: 'hint_used') this.hintUsed = false,
    this.notes,
  }) : _selectedAnswers = selectedAnswers;

  factory _$PracticeSessionAttemptRequestImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$PracticeSessionAttemptRequestImplFromJson(json);

  @override
  @JsonKey(name: 'question_id')
  final String questionId;
  final List<String> _selectedAnswers;
  @override
  @JsonKey(name: 'selected_answers')
  List<String> get selectedAnswers {
    if (_selectedAnswers is EqualUnmodifiableListView) return _selectedAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedAnswers);
  }

  @override
  @JsonKey(name: 'time_spent')
  final int timeSpent;
  @override
  @JsonKey(name: 'attempt_number')
  final int attemptNumber;
  @override
  @JsonKey(name: 'explanation_shown')
  final bool explanationShown;
  @override
  @JsonKey(name: 'hint_used')
  final bool hintUsed;
  @override
  final String? notes;

  @override
  String toString() {
    return 'PracticeSessionAttemptRequest(questionId: $questionId, selectedAnswers: $selectedAnswers, timeSpent: $timeSpent, attemptNumber: $attemptNumber, explanationShown: $explanationShown, hintUsed: $hintUsed, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PracticeSessionAttemptRequestImpl &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            const DeepCollectionEquality().equals(
              other._selectedAnswers,
              _selectedAnswers,
            ) &&
            (identical(other.timeSpent, timeSpent) ||
                other.timeSpent == timeSpent) &&
            (identical(other.attemptNumber, attemptNumber) ||
                other.attemptNumber == attemptNumber) &&
            (identical(other.explanationShown, explanationShown) ||
                other.explanationShown == explanationShown) &&
            (identical(other.hintUsed, hintUsed) ||
                other.hintUsed == hintUsed) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    questionId,
    const DeepCollectionEquality().hash(_selectedAnswers),
    timeSpent,
    attemptNumber,
    explanationShown,
    hintUsed,
    notes,
  );

  /// Create a copy of PracticeSessionAttemptRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PracticeSessionAttemptRequestImplCopyWith<
    _$PracticeSessionAttemptRequestImpl
  >
  get copyWith =>
      __$$PracticeSessionAttemptRequestImplCopyWithImpl<
        _$PracticeSessionAttemptRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PracticeSessionAttemptRequestImplToJson(this);
  }
}

abstract class _PracticeSessionAttemptRequest
    implements PracticeSessionAttemptRequest {
  const factory _PracticeSessionAttemptRequest({
    @JsonKey(name: 'question_id') required final String questionId,
    @JsonKey(name: 'selected_answers')
    required final List<String> selectedAnswers,
    @JsonKey(name: 'time_spent') required final int timeSpent,
    @JsonKey(name: 'attempt_number') final int attemptNumber,
    @JsonKey(name: 'explanation_shown') final bool explanationShown,
    @JsonKey(name: 'hint_used') final bool hintUsed,
    final String? notes,
  }) = _$PracticeSessionAttemptRequestImpl;

  factory _PracticeSessionAttemptRequest.fromJson(Map<String, dynamic> json) =
      _$PracticeSessionAttemptRequestImpl.fromJson;

  @override
  @JsonKey(name: 'question_id')
  String get questionId;
  @override
  @JsonKey(name: 'selected_answers')
  List<String> get selectedAnswers;
  @override
  @JsonKey(name: 'time_spent')
  int get timeSpent;
  @override
  @JsonKey(name: 'attempt_number')
  int get attemptNumber;
  @override
  @JsonKey(name: 'explanation_shown')
  bool get explanationShown;
  @override
  @JsonKey(name: 'hint_used')
  bool get hintUsed;
  @override
  String? get notes;

  /// Create a copy of PracticeSessionAttemptRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PracticeSessionAttemptRequestImplCopyWith<
    _$PracticeSessionAttemptRequestImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

PracticeSessionProgressUpdate _$PracticeSessionProgressUpdateFromJson(
  Map<String, dynamic> json,
) {
  return _PracticeSessionProgressUpdate.fromJson(json);
}

/// @nodoc
mixin _$PracticeSessionProgressUpdate {
  @JsonKey(name: 'question_index')
  int get questionIndex => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_spent')
  int get timeSpent => throw _privateConstructorUsedError;

  /// Serializes this PracticeSessionProgressUpdate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PracticeSessionProgressUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PracticeSessionProgressUpdateCopyWith<PracticeSessionProgressUpdate>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PracticeSessionProgressUpdateCopyWith<$Res> {
  factory $PracticeSessionProgressUpdateCopyWith(
    PracticeSessionProgressUpdate value,
    $Res Function(PracticeSessionProgressUpdate) then,
  ) =
      _$PracticeSessionProgressUpdateCopyWithImpl<
        $Res,
        PracticeSessionProgressUpdate
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'question_index') int questionIndex,
    @JsonKey(name: 'time_spent') int timeSpent,
  });
}

/// @nodoc
class _$PracticeSessionProgressUpdateCopyWithImpl<
  $Res,
  $Val extends PracticeSessionProgressUpdate
>
    implements $PracticeSessionProgressUpdateCopyWith<$Res> {
  _$PracticeSessionProgressUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PracticeSessionProgressUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? questionIndex = null, Object? timeSpent = null}) {
    return _then(
      _value.copyWith(
            questionIndex: null == questionIndex
                ? _value.questionIndex
                : questionIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            timeSpent: null == timeSpent
                ? _value.timeSpent
                : timeSpent // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PracticeSessionProgressUpdateImplCopyWith<$Res>
    implements $PracticeSessionProgressUpdateCopyWith<$Res> {
  factory _$$PracticeSessionProgressUpdateImplCopyWith(
    _$PracticeSessionProgressUpdateImpl value,
    $Res Function(_$PracticeSessionProgressUpdateImpl) then,
  ) = __$$PracticeSessionProgressUpdateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'question_index') int questionIndex,
    @JsonKey(name: 'time_spent') int timeSpent,
  });
}

/// @nodoc
class __$$PracticeSessionProgressUpdateImplCopyWithImpl<$Res>
    extends
        _$PracticeSessionProgressUpdateCopyWithImpl<
          $Res,
          _$PracticeSessionProgressUpdateImpl
        >
    implements _$$PracticeSessionProgressUpdateImplCopyWith<$Res> {
  __$$PracticeSessionProgressUpdateImplCopyWithImpl(
    _$PracticeSessionProgressUpdateImpl _value,
    $Res Function(_$PracticeSessionProgressUpdateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PracticeSessionProgressUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? questionIndex = null, Object? timeSpent = null}) {
    return _then(
      _$PracticeSessionProgressUpdateImpl(
        questionIndex: null == questionIndex
            ? _value.questionIndex
            : questionIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        timeSpent: null == timeSpent
            ? _value.timeSpent
            : timeSpent // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PracticeSessionProgressUpdateImpl
    implements _PracticeSessionProgressUpdate {
  const _$PracticeSessionProgressUpdateImpl({
    @JsonKey(name: 'question_index') required this.questionIndex,
    @JsonKey(name: 'time_spent') required this.timeSpent,
  });

  factory _$PracticeSessionProgressUpdateImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$PracticeSessionProgressUpdateImplFromJson(json);

  @override
  @JsonKey(name: 'question_index')
  final int questionIndex;
  @override
  @JsonKey(name: 'time_spent')
  final int timeSpent;

  @override
  String toString() {
    return 'PracticeSessionProgressUpdate(questionIndex: $questionIndex, timeSpent: $timeSpent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PracticeSessionProgressUpdateImpl &&
            (identical(other.questionIndex, questionIndex) ||
                other.questionIndex == questionIndex) &&
            (identical(other.timeSpent, timeSpent) ||
                other.timeSpent == timeSpent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, questionIndex, timeSpent);

  /// Create a copy of PracticeSessionProgressUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PracticeSessionProgressUpdateImplCopyWith<
    _$PracticeSessionProgressUpdateImpl
  >
  get copyWith =>
      __$$PracticeSessionProgressUpdateImplCopyWithImpl<
        _$PracticeSessionProgressUpdateImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PracticeSessionProgressUpdateImplToJson(this);
  }
}

abstract class _PracticeSessionProgressUpdate
    implements PracticeSessionProgressUpdate {
  const factory _PracticeSessionProgressUpdate({
    @JsonKey(name: 'question_index') required final int questionIndex,
    @JsonKey(name: 'time_spent') required final int timeSpent,
  }) = _$PracticeSessionProgressUpdateImpl;

  factory _PracticeSessionProgressUpdate.fromJson(Map<String, dynamic> json) =
      _$PracticeSessionProgressUpdateImpl.fromJson;

  @override
  @JsonKey(name: 'question_index')
  int get questionIndex;
  @override
  @JsonKey(name: 'time_spent')
  int get timeSpent;

  /// Create a copy of PracticeSessionProgressUpdate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PracticeSessionProgressUpdateImplCopyWith<
    _$PracticeSessionProgressUpdateImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
