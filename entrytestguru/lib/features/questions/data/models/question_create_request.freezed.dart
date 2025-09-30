// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_create_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuestionCreateRequest _$QuestionCreateRequestFromJson(
  Map<String, dynamic> json,
) {
  return _QuestionCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$QuestionCreateRequest {
  String get questionText => throw _privateConstructorUsedError;
  List<QuestionOption> get options => throw _privateConstructorUsedError;
  List<String> get correctAnswer => throw _privateConstructorUsedError;
  String get examType => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get topic => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  double get ardeProbability => throw _privateConstructorUsedError;
  int get historicalFrequency => throw _privateConstructorUsedError;
  String? get explanation => throw _privateConstructorUsedError;
  String? get videoExplanationUrl => throw _privateConstructorUsedError;
  List<String> get references => throw _privateConstructorUsedError;
  String? get ardeContext => throw _privateConstructorUsedError;

  /// Serializes this QuestionCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuestionCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionCreateRequestCopyWith<QuestionCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionCreateRequestCopyWith<$Res> {
  factory $QuestionCreateRequestCopyWith(
    QuestionCreateRequest value,
    $Res Function(QuestionCreateRequest) then,
  ) = _$QuestionCreateRequestCopyWithImpl<$Res, QuestionCreateRequest>;
  @useResult
  $Res call({
    String questionText,
    List<QuestionOption> options,
    List<String> correctAnswer,
    String examType,
    String subject,
    String topic,
    String difficulty,
    double ardeProbability,
    int historicalFrequency,
    String? explanation,
    String? videoExplanationUrl,
    List<String> references,
    String? ardeContext,
  });
}

/// @nodoc
class _$QuestionCreateRequestCopyWithImpl<
  $Res,
  $Val extends QuestionCreateRequest
>
    implements $QuestionCreateRequestCopyWith<$Res> {
  _$QuestionCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionText = null,
    Object? options = null,
    Object? correctAnswer = null,
    Object? examType = null,
    Object? subject = null,
    Object? topic = null,
    Object? difficulty = null,
    Object? ardeProbability = null,
    Object? historicalFrequency = null,
    Object? explanation = freezed,
    Object? videoExplanationUrl = freezed,
    Object? references = null,
    Object? ardeContext = freezed,
  }) {
    return _then(
      _value.copyWith(
            questionText: null == questionText
                ? _value.questionText
                : questionText // ignore: cast_nullable_to_non_nullable
                      as String,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<QuestionOption>,
            correctAnswer: null == correctAnswer
                ? _value.correctAnswer
                : correctAnswer // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            examType: null == examType
                ? _value.examType
                : examType // ignore: cast_nullable_to_non_nullable
                      as String,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            topic: null == topic
                ? _value.topic
                : topic // ignore: cast_nullable_to_non_nullable
                      as String,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as String,
            ardeProbability: null == ardeProbability
                ? _value.ardeProbability
                : ardeProbability // ignore: cast_nullable_to_non_nullable
                      as double,
            historicalFrequency: null == historicalFrequency
                ? _value.historicalFrequency
                : historicalFrequency // ignore: cast_nullable_to_non_nullable
                      as int,
            explanation: freezed == explanation
                ? _value.explanation
                : explanation // ignore: cast_nullable_to_non_nullable
                      as String?,
            videoExplanationUrl: freezed == videoExplanationUrl
                ? _value.videoExplanationUrl
                : videoExplanationUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            references: null == references
                ? _value.references
                : references // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            ardeContext: freezed == ardeContext
                ? _value.ardeContext
                : ardeContext // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestionCreateRequestImplCopyWith<$Res>
    implements $QuestionCreateRequestCopyWith<$Res> {
  factory _$$QuestionCreateRequestImplCopyWith(
    _$QuestionCreateRequestImpl value,
    $Res Function(_$QuestionCreateRequestImpl) then,
  ) = __$$QuestionCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String questionText,
    List<QuestionOption> options,
    List<String> correctAnswer,
    String examType,
    String subject,
    String topic,
    String difficulty,
    double ardeProbability,
    int historicalFrequency,
    String? explanation,
    String? videoExplanationUrl,
    List<String> references,
    String? ardeContext,
  });
}

/// @nodoc
class __$$QuestionCreateRequestImplCopyWithImpl<$Res>
    extends
        _$QuestionCreateRequestCopyWithImpl<$Res, _$QuestionCreateRequestImpl>
    implements _$$QuestionCreateRequestImplCopyWith<$Res> {
  __$$QuestionCreateRequestImplCopyWithImpl(
    _$QuestionCreateRequestImpl _value,
    $Res Function(_$QuestionCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuestionCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionText = null,
    Object? options = null,
    Object? correctAnswer = null,
    Object? examType = null,
    Object? subject = null,
    Object? topic = null,
    Object? difficulty = null,
    Object? ardeProbability = null,
    Object? historicalFrequency = null,
    Object? explanation = freezed,
    Object? videoExplanationUrl = freezed,
    Object? references = null,
    Object? ardeContext = freezed,
  }) {
    return _then(
      _$QuestionCreateRequestImpl(
        questionText: null == questionText
            ? _value.questionText
            : questionText // ignore: cast_nullable_to_non_nullable
                  as String,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<QuestionOption>,
        correctAnswer: null == correctAnswer
            ? _value._correctAnswer
            : correctAnswer // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        examType: null == examType
            ? _value.examType
            : examType // ignore: cast_nullable_to_non_nullable
                  as String,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        topic: null == topic
            ? _value.topic
            : topic // ignore: cast_nullable_to_non_nullable
                  as String,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as String,
        ardeProbability: null == ardeProbability
            ? _value.ardeProbability
            : ardeProbability // ignore: cast_nullable_to_non_nullable
                  as double,
        historicalFrequency: null == historicalFrequency
            ? _value.historicalFrequency
            : historicalFrequency // ignore: cast_nullable_to_non_nullable
                  as int,
        explanation: freezed == explanation
            ? _value.explanation
            : explanation // ignore: cast_nullable_to_non_nullable
                  as String?,
        videoExplanationUrl: freezed == videoExplanationUrl
            ? _value.videoExplanationUrl
            : videoExplanationUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        references: null == references
            ? _value._references
            : references // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        ardeContext: freezed == ardeContext
            ? _value.ardeContext
            : ardeContext // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionCreateRequestImpl extends _QuestionCreateRequest {
  const _$QuestionCreateRequestImpl({
    required this.questionText,
    required final List<QuestionOption> options,
    required final List<String> correctAnswer,
    required this.examType,
    required this.subject,
    required this.topic,
    required this.difficulty,
    this.ardeProbability = 0.5,
    this.historicalFrequency = 0,
    this.explanation,
    this.videoExplanationUrl,
    final List<String> references = const [],
    this.ardeContext,
  }) : _options = options,
       _correctAnswer = correctAnswer,
       _references = references,
       super._();

  factory _$QuestionCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionCreateRequestImplFromJson(json);

  @override
  final String questionText;
  final List<QuestionOption> _options;
  @override
  List<QuestionOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  final List<String> _correctAnswer;
  @override
  List<String> get correctAnswer {
    if (_correctAnswer is EqualUnmodifiableListView) return _correctAnswer;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_correctAnswer);
  }

  @override
  final String examType;
  @override
  final String subject;
  @override
  final String topic;
  @override
  final String difficulty;
  @override
  @JsonKey()
  final double ardeProbability;
  @override
  @JsonKey()
  final int historicalFrequency;
  @override
  final String? explanation;
  @override
  final String? videoExplanationUrl;
  final List<String> _references;
  @override
  @JsonKey()
  List<String> get references {
    if (_references is EqualUnmodifiableListView) return _references;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_references);
  }

  @override
  final String? ardeContext;

  @override
  String toString() {
    return 'QuestionCreateRequest(questionText: $questionText, options: $options, correctAnswer: $correctAnswer, examType: $examType, subject: $subject, topic: $topic, difficulty: $difficulty, ardeProbability: $ardeProbability, historicalFrequency: $historicalFrequency, explanation: $explanation, videoExplanationUrl: $videoExplanationUrl, references: $references, ardeContext: $ardeContext)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionCreateRequestImpl &&
            (identical(other.questionText, questionText) ||
                other.questionText == questionText) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            const DeepCollectionEquality().equals(
              other._correctAnswer,
              _correctAnswer,
            ) &&
            (identical(other.examType, examType) ||
                other.examType == examType) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.ardeProbability, ardeProbability) ||
                other.ardeProbability == ardeProbability) &&
            (identical(other.historicalFrequency, historicalFrequency) ||
                other.historicalFrequency == historicalFrequency) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.videoExplanationUrl, videoExplanationUrl) ||
                other.videoExplanationUrl == videoExplanationUrl) &&
            const DeepCollectionEquality().equals(
              other._references,
              _references,
            ) &&
            (identical(other.ardeContext, ardeContext) ||
                other.ardeContext == ardeContext));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    questionText,
    const DeepCollectionEquality().hash(_options),
    const DeepCollectionEquality().hash(_correctAnswer),
    examType,
    subject,
    topic,
    difficulty,
    ardeProbability,
    historicalFrequency,
    explanation,
    videoExplanationUrl,
    const DeepCollectionEquality().hash(_references),
    ardeContext,
  );

  /// Create a copy of QuestionCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionCreateRequestImplCopyWith<_$QuestionCreateRequestImpl>
  get copyWith =>
      __$$QuestionCreateRequestImplCopyWithImpl<_$QuestionCreateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionCreateRequestImplToJson(this);
  }
}

abstract class _QuestionCreateRequest extends QuestionCreateRequest {
  const factory _QuestionCreateRequest({
    required final String questionText,
    required final List<QuestionOption> options,
    required final List<String> correctAnswer,
    required final String examType,
    required final String subject,
    required final String topic,
    required final String difficulty,
    final double ardeProbability,
    final int historicalFrequency,
    final String? explanation,
    final String? videoExplanationUrl,
    final List<String> references,
    final String? ardeContext,
  }) = _$QuestionCreateRequestImpl;
  const _QuestionCreateRequest._() : super._();

  factory _QuestionCreateRequest.fromJson(Map<String, dynamic> json) =
      _$QuestionCreateRequestImpl.fromJson;

  @override
  String get questionText;
  @override
  List<QuestionOption> get options;
  @override
  List<String> get correctAnswer;
  @override
  String get examType;
  @override
  String get subject;
  @override
  String get topic;
  @override
  String get difficulty;
  @override
  double get ardeProbability;
  @override
  int get historicalFrequency;
  @override
  String? get explanation;
  @override
  String? get videoExplanationUrl;
  @override
  List<String> get references;
  @override
  String? get ardeContext;

  /// Create a copy of QuestionCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionCreateRequestImplCopyWith<_$QuestionCreateRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
