// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_attempt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuestionAttempt _$QuestionAttemptFromJson(Map<String, dynamic> json) {
  return _QuestionAttempt.fromJson(json);
}

/// @nodoc
mixin _$QuestionAttempt {
  /// Unique identifier for the question
  String get questionId => throw _privateConstructorUsedError;

  /// Session ID this attempt belongs to
  String get sessionId => throw _privateConstructorUsedError;

  /// List of selected answer IDs
  List<String> get selectedAnswers => throw _privateConstructorUsedError;

  /// Whether the attempt was correct
  bool get isCorrect => throw _privateConstructorUsedError;

  /// Attempt number for this question (1, 2, 3, etc.)
  int get attemptNumber => throw _privateConstructorUsedError;

  /// Time spent on this attempt
  Duration get timeSpent => throw _privateConstructorUsedError;

  /// When the attempt was made
  DateTime get timestamp =>
      throw _privateConstructorUsedError; // Optional tracking fields
  /// Whether hint was used
  bool? get hintUsed => throw _privateConstructorUsedError;

  /// Whether explanation was viewed
  bool? get explanationViewed => throw _privateConstructorUsedError;

  /// ID of AI interaction if any
  String? get aiInteractionId =>
      throw _privateConstructorUsedError; // Performance analysis
  /// User's percentile ranking for time spent
  double? get timePercentile => throw _privateConstructorUsedError;

  /// Assessment of difficulty for this user
  String? get difficultyAssessment => throw _privateConstructorUsedError;

  /// Serializes this QuestionAttempt to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuestionAttempt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionAttemptCopyWith<QuestionAttempt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionAttemptCopyWith<$Res> {
  factory $QuestionAttemptCopyWith(
    QuestionAttempt value,
    $Res Function(QuestionAttempt) then,
  ) = _$QuestionAttemptCopyWithImpl<$Res, QuestionAttempt>;
  @useResult
  $Res call({
    String questionId,
    String sessionId,
    List<String> selectedAnswers,
    bool isCorrect,
    int attemptNumber,
    Duration timeSpent,
    DateTime timestamp,
    bool? hintUsed,
    bool? explanationViewed,
    String? aiInteractionId,
    double? timePercentile,
    String? difficultyAssessment,
  });
}

/// @nodoc
class _$QuestionAttemptCopyWithImpl<$Res, $Val extends QuestionAttempt>
    implements $QuestionAttemptCopyWith<$Res> {
  _$QuestionAttemptCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionAttempt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? sessionId = null,
    Object? selectedAnswers = null,
    Object? isCorrect = null,
    Object? attemptNumber = null,
    Object? timeSpent = null,
    Object? timestamp = null,
    Object? hintUsed = freezed,
    Object? explanationViewed = freezed,
    Object? aiInteractionId = freezed,
    Object? timePercentile = freezed,
    Object? difficultyAssessment = freezed,
  }) {
    return _then(
      _value.copyWith(
            questionId: null == questionId
                ? _value.questionId
                : questionId // ignore: cast_nullable_to_non_nullable
                      as String,
            sessionId: null == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedAnswers: null == selectedAnswers
                ? _value.selectedAnswers
                : selectedAnswers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isCorrect: null == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool,
            attemptNumber: null == attemptNumber
                ? _value.attemptNumber
                : attemptNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            timeSpent: null == timeSpent
                ? _value.timeSpent
                : timeSpent // ignore: cast_nullable_to_non_nullable
                      as Duration,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            hintUsed: freezed == hintUsed
                ? _value.hintUsed
                : hintUsed // ignore: cast_nullable_to_non_nullable
                      as bool?,
            explanationViewed: freezed == explanationViewed
                ? _value.explanationViewed
                : explanationViewed // ignore: cast_nullable_to_non_nullable
                      as bool?,
            aiInteractionId: freezed == aiInteractionId
                ? _value.aiInteractionId
                : aiInteractionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            timePercentile: freezed == timePercentile
                ? _value.timePercentile
                : timePercentile // ignore: cast_nullable_to_non_nullable
                      as double?,
            difficultyAssessment: freezed == difficultyAssessment
                ? _value.difficultyAssessment
                : difficultyAssessment // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestionAttemptImplCopyWith<$Res>
    implements $QuestionAttemptCopyWith<$Res> {
  factory _$$QuestionAttemptImplCopyWith(
    _$QuestionAttemptImpl value,
    $Res Function(_$QuestionAttemptImpl) then,
  ) = __$$QuestionAttemptImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String questionId,
    String sessionId,
    List<String> selectedAnswers,
    bool isCorrect,
    int attemptNumber,
    Duration timeSpent,
    DateTime timestamp,
    bool? hintUsed,
    bool? explanationViewed,
    String? aiInteractionId,
    double? timePercentile,
    String? difficultyAssessment,
  });
}

/// @nodoc
class __$$QuestionAttemptImplCopyWithImpl<$Res>
    extends _$QuestionAttemptCopyWithImpl<$Res, _$QuestionAttemptImpl>
    implements _$$QuestionAttemptImplCopyWith<$Res> {
  __$$QuestionAttemptImplCopyWithImpl(
    _$QuestionAttemptImpl _value,
    $Res Function(_$QuestionAttemptImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuestionAttempt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? sessionId = null,
    Object? selectedAnswers = null,
    Object? isCorrect = null,
    Object? attemptNumber = null,
    Object? timeSpent = null,
    Object? timestamp = null,
    Object? hintUsed = freezed,
    Object? explanationViewed = freezed,
    Object? aiInteractionId = freezed,
    Object? timePercentile = freezed,
    Object? difficultyAssessment = freezed,
  }) {
    return _then(
      _$QuestionAttemptImpl(
        questionId: null == questionId
            ? _value.questionId
            : questionId // ignore: cast_nullable_to_non_nullable
                  as String,
        sessionId: null == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedAnswers: null == selectedAnswers
            ? _value._selectedAnswers
            : selectedAnswers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isCorrect: null == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool,
        attemptNumber: null == attemptNumber
            ? _value.attemptNumber
            : attemptNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        timeSpent: null == timeSpent
            ? _value.timeSpent
            : timeSpent // ignore: cast_nullable_to_non_nullable
                  as Duration,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        hintUsed: freezed == hintUsed
            ? _value.hintUsed
            : hintUsed // ignore: cast_nullable_to_non_nullable
                  as bool?,
        explanationViewed: freezed == explanationViewed
            ? _value.explanationViewed
            : explanationViewed // ignore: cast_nullable_to_non_nullable
                  as bool?,
        aiInteractionId: freezed == aiInteractionId
            ? _value.aiInteractionId
            : aiInteractionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        timePercentile: freezed == timePercentile
            ? _value.timePercentile
            : timePercentile // ignore: cast_nullable_to_non_nullable
                  as double?,
        difficultyAssessment: freezed == difficultyAssessment
            ? _value.difficultyAssessment
            : difficultyAssessment // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionAttemptImpl extends _QuestionAttempt {
  const _$QuestionAttemptImpl({
    required this.questionId,
    required this.sessionId,
    required final List<String> selectedAnswers,
    required this.isCorrect,
    this.attemptNumber = 1,
    required this.timeSpent,
    required this.timestamp,
    this.hintUsed,
    this.explanationViewed,
    this.aiInteractionId,
    this.timePercentile,
    this.difficultyAssessment,
  }) : _selectedAnswers = selectedAnswers,
       super._();

  factory _$QuestionAttemptImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionAttemptImplFromJson(json);

  /// Unique identifier for the question
  @override
  final String questionId;

  /// Session ID this attempt belongs to
  @override
  final String sessionId;

  /// List of selected answer IDs
  final List<String> _selectedAnswers;

  /// List of selected answer IDs
  @override
  List<String> get selectedAnswers {
    if (_selectedAnswers is EqualUnmodifiableListView) return _selectedAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedAnswers);
  }

  /// Whether the attempt was correct
  @override
  final bool isCorrect;

  /// Attempt number for this question (1, 2, 3, etc.)
  @override
  @JsonKey()
  final int attemptNumber;

  /// Time spent on this attempt
  @override
  final Duration timeSpent;

  /// When the attempt was made
  @override
  final DateTime timestamp;
  // Optional tracking fields
  /// Whether hint was used
  @override
  final bool? hintUsed;

  /// Whether explanation was viewed
  @override
  final bool? explanationViewed;

  /// ID of AI interaction if any
  @override
  final String? aiInteractionId;
  // Performance analysis
  /// User's percentile ranking for time spent
  @override
  final double? timePercentile;

  /// Assessment of difficulty for this user
  @override
  final String? difficultyAssessment;

  @override
  String toString() {
    return 'QuestionAttempt(questionId: $questionId, sessionId: $sessionId, selectedAnswers: $selectedAnswers, isCorrect: $isCorrect, attemptNumber: $attemptNumber, timeSpent: $timeSpent, timestamp: $timestamp, hintUsed: $hintUsed, explanationViewed: $explanationViewed, aiInteractionId: $aiInteractionId, timePercentile: $timePercentile, difficultyAssessment: $difficultyAssessment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionAttemptImpl &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            const DeepCollectionEquality().equals(
              other._selectedAnswers,
              _selectedAnswers,
            ) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.attemptNumber, attemptNumber) ||
                other.attemptNumber == attemptNumber) &&
            (identical(other.timeSpent, timeSpent) ||
                other.timeSpent == timeSpent) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.hintUsed, hintUsed) ||
                other.hintUsed == hintUsed) &&
            (identical(other.explanationViewed, explanationViewed) ||
                other.explanationViewed == explanationViewed) &&
            (identical(other.aiInteractionId, aiInteractionId) ||
                other.aiInteractionId == aiInteractionId) &&
            (identical(other.timePercentile, timePercentile) ||
                other.timePercentile == timePercentile) &&
            (identical(other.difficultyAssessment, difficultyAssessment) ||
                other.difficultyAssessment == difficultyAssessment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    questionId,
    sessionId,
    const DeepCollectionEquality().hash(_selectedAnswers),
    isCorrect,
    attemptNumber,
    timeSpent,
    timestamp,
    hintUsed,
    explanationViewed,
    aiInteractionId,
    timePercentile,
    difficultyAssessment,
  );

  /// Create a copy of QuestionAttempt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionAttemptImplCopyWith<_$QuestionAttemptImpl> get copyWith =>
      __$$QuestionAttemptImplCopyWithImpl<_$QuestionAttemptImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionAttemptImplToJson(this);
  }
}

abstract class _QuestionAttempt extends QuestionAttempt {
  const factory _QuestionAttempt({
    required final String questionId,
    required final String sessionId,
    required final List<String> selectedAnswers,
    required final bool isCorrect,
    final int attemptNumber,
    required final Duration timeSpent,
    required final DateTime timestamp,
    final bool? hintUsed,
    final bool? explanationViewed,
    final String? aiInteractionId,
    final double? timePercentile,
    final String? difficultyAssessment,
  }) = _$QuestionAttemptImpl;
  const _QuestionAttempt._() : super._();

  factory _QuestionAttempt.fromJson(Map<String, dynamic> json) =
      _$QuestionAttemptImpl.fromJson;

  /// Unique identifier for the question
  @override
  String get questionId;

  /// Session ID this attempt belongs to
  @override
  String get sessionId;

  /// List of selected answer IDs
  @override
  List<String> get selectedAnswers;

  /// Whether the attempt was correct
  @override
  bool get isCorrect;

  /// Attempt number for this question (1, 2, 3, etc.)
  @override
  int get attemptNumber;

  /// Time spent on this attempt
  @override
  Duration get timeSpent;

  /// When the attempt was made
  @override
  DateTime get timestamp; // Optional tracking fields
  /// Whether hint was used
  @override
  bool? get hintUsed;

  /// Whether explanation was viewed
  @override
  bool? get explanationViewed;

  /// ID of AI interaction if any
  @override
  String? get aiInteractionId; // Performance analysis
  /// User's percentile ranking for time spent
  @override
  double? get timePercentile;

  /// Assessment of difficulty for this user
  @override
  String? get difficultyAssessment;

  /// Create a copy of QuestionAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionAttemptImplCopyWith<_$QuestionAttemptImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
