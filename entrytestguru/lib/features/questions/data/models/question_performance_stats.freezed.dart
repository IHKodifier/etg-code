// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_performance_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuestionPerformanceStats _$QuestionPerformanceStatsFromJson(
  Map<String, dynamic> json,
) {
  return _QuestionPerformanceStats.fromJson(json);
}

/// @nodoc
mixin _$QuestionPerformanceStats {
  /// Total number of attempts on this question
  int get totalAttempts => throw _privateConstructorUsedError;

  /// Total number of correct attempts
  int get totalCorrect => throw _privateConstructorUsedError;

  /// Global accuracy rate (0.0 to 1.0)
  double get globalAccuracy => throw _privateConstructorUsedError;

  /// Average time spent on this question in seconds
  double get averageTimeSeconds => throw _privateConstructorUsedError;

  /// Median time spent on this question in seconds
  double get medianTimeSeconds => throw _privateConstructorUsedError;

  /// 95th percentile time spent on this question in seconds
  double get p95TimeSeconds => throw _privateConstructorUsedError;

  /// Calculated difficulty score based on performance (0-1)
  double get calculatedDifficulty => throw _privateConstructorUsedError;

  /// Performance statistics by user tier
  Map<String, TierPerformance>? get tierPerformance =>
      throw _privateConstructorUsedError;

  /// Common wrong answer patterns
  List<WrongAnswerPattern>? get commonMistakes =>
      throw _privateConstructorUsedError;

  /// Time distribution across different time buckets
  Map<String, double>? get timeDistribution =>
      throw _privateConstructorUsedError;

  /// Serializes this QuestionPerformanceStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuestionPerformanceStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionPerformanceStatsCopyWith<QuestionPerformanceStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionPerformanceStatsCopyWith<$Res> {
  factory $QuestionPerformanceStatsCopyWith(
    QuestionPerformanceStats value,
    $Res Function(QuestionPerformanceStats) then,
  ) = _$QuestionPerformanceStatsCopyWithImpl<$Res, QuestionPerformanceStats>;
  @useResult
  $Res call({
    int totalAttempts,
    int totalCorrect,
    double globalAccuracy,
    double averageTimeSeconds,
    double medianTimeSeconds,
    double p95TimeSeconds,
    double calculatedDifficulty,
    Map<String, TierPerformance>? tierPerformance,
    List<WrongAnswerPattern>? commonMistakes,
    Map<String, double>? timeDistribution,
  });
}

/// @nodoc
class _$QuestionPerformanceStatsCopyWithImpl<
  $Res,
  $Val extends QuestionPerformanceStats
>
    implements $QuestionPerformanceStatsCopyWith<$Res> {
  _$QuestionPerformanceStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionPerformanceStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalAttempts = null,
    Object? totalCorrect = null,
    Object? globalAccuracy = null,
    Object? averageTimeSeconds = null,
    Object? medianTimeSeconds = null,
    Object? p95TimeSeconds = null,
    Object? calculatedDifficulty = null,
    Object? tierPerformance = freezed,
    Object? commonMistakes = freezed,
    Object? timeDistribution = freezed,
  }) {
    return _then(
      _value.copyWith(
            totalAttempts: null == totalAttempts
                ? _value.totalAttempts
                : totalAttempts // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCorrect: null == totalCorrect
                ? _value.totalCorrect
                : totalCorrect // ignore: cast_nullable_to_non_nullable
                      as int,
            globalAccuracy: null == globalAccuracy
                ? _value.globalAccuracy
                : globalAccuracy // ignore: cast_nullable_to_non_nullable
                      as double,
            averageTimeSeconds: null == averageTimeSeconds
                ? _value.averageTimeSeconds
                : averageTimeSeconds // ignore: cast_nullable_to_non_nullable
                      as double,
            medianTimeSeconds: null == medianTimeSeconds
                ? _value.medianTimeSeconds
                : medianTimeSeconds // ignore: cast_nullable_to_non_nullable
                      as double,
            p95TimeSeconds: null == p95TimeSeconds
                ? _value.p95TimeSeconds
                : p95TimeSeconds // ignore: cast_nullable_to_non_nullable
                      as double,
            calculatedDifficulty: null == calculatedDifficulty
                ? _value.calculatedDifficulty
                : calculatedDifficulty // ignore: cast_nullable_to_non_nullable
                      as double,
            tierPerformance: freezed == tierPerformance
                ? _value.tierPerformance
                : tierPerformance // ignore: cast_nullable_to_non_nullable
                      as Map<String, TierPerformance>?,
            commonMistakes: freezed == commonMistakes
                ? _value.commonMistakes
                : commonMistakes // ignore: cast_nullable_to_non_nullable
                      as List<WrongAnswerPattern>?,
            timeDistribution: freezed == timeDistribution
                ? _value.timeDistribution
                : timeDistribution // ignore: cast_nullable_to_non_nullable
                      as Map<String, double>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestionPerformanceStatsImplCopyWith<$Res>
    implements $QuestionPerformanceStatsCopyWith<$Res> {
  factory _$$QuestionPerformanceStatsImplCopyWith(
    _$QuestionPerformanceStatsImpl value,
    $Res Function(_$QuestionPerformanceStatsImpl) then,
  ) = __$$QuestionPerformanceStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalAttempts,
    int totalCorrect,
    double globalAccuracy,
    double averageTimeSeconds,
    double medianTimeSeconds,
    double p95TimeSeconds,
    double calculatedDifficulty,
    Map<String, TierPerformance>? tierPerformance,
    List<WrongAnswerPattern>? commonMistakes,
    Map<String, double>? timeDistribution,
  });
}

/// @nodoc
class __$$QuestionPerformanceStatsImplCopyWithImpl<$Res>
    extends
        _$QuestionPerformanceStatsCopyWithImpl<
          $Res,
          _$QuestionPerformanceStatsImpl
        >
    implements _$$QuestionPerformanceStatsImplCopyWith<$Res> {
  __$$QuestionPerformanceStatsImplCopyWithImpl(
    _$QuestionPerformanceStatsImpl _value,
    $Res Function(_$QuestionPerformanceStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuestionPerformanceStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalAttempts = null,
    Object? totalCorrect = null,
    Object? globalAccuracy = null,
    Object? averageTimeSeconds = null,
    Object? medianTimeSeconds = null,
    Object? p95TimeSeconds = null,
    Object? calculatedDifficulty = null,
    Object? tierPerformance = freezed,
    Object? commonMistakes = freezed,
    Object? timeDistribution = freezed,
  }) {
    return _then(
      _$QuestionPerformanceStatsImpl(
        totalAttempts: null == totalAttempts
            ? _value.totalAttempts
            : totalAttempts // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCorrect: null == totalCorrect
            ? _value.totalCorrect
            : totalCorrect // ignore: cast_nullable_to_non_nullable
                  as int,
        globalAccuracy: null == globalAccuracy
            ? _value.globalAccuracy
            : globalAccuracy // ignore: cast_nullable_to_non_nullable
                  as double,
        averageTimeSeconds: null == averageTimeSeconds
            ? _value.averageTimeSeconds
            : averageTimeSeconds // ignore: cast_nullable_to_non_nullable
                  as double,
        medianTimeSeconds: null == medianTimeSeconds
            ? _value.medianTimeSeconds
            : medianTimeSeconds // ignore: cast_nullable_to_non_nullable
                  as double,
        p95TimeSeconds: null == p95TimeSeconds
            ? _value.p95TimeSeconds
            : p95TimeSeconds // ignore: cast_nullable_to_non_nullable
                  as double,
        calculatedDifficulty: null == calculatedDifficulty
            ? _value.calculatedDifficulty
            : calculatedDifficulty // ignore: cast_nullable_to_non_nullable
                  as double,
        tierPerformance: freezed == tierPerformance
            ? _value._tierPerformance
            : tierPerformance // ignore: cast_nullable_to_non_nullable
                  as Map<String, TierPerformance>?,
        commonMistakes: freezed == commonMistakes
            ? _value._commonMistakes
            : commonMistakes // ignore: cast_nullable_to_non_nullable
                  as List<WrongAnswerPattern>?,
        timeDistribution: freezed == timeDistribution
            ? _value._timeDistribution
            : timeDistribution // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionPerformanceStatsImpl extends _QuestionPerformanceStats {
  const _$QuestionPerformanceStatsImpl({
    this.totalAttempts = 0,
    this.totalCorrect = 0,
    this.globalAccuracy = 0.0,
    this.averageTimeSeconds = 0.0,
    this.medianTimeSeconds = 0.0,
    this.p95TimeSeconds = 0.0,
    this.calculatedDifficulty = 0.0,
    final Map<String, TierPerformance>? tierPerformance,
    final List<WrongAnswerPattern>? commonMistakes,
    final Map<String, double>? timeDistribution,
  }) : _tierPerformance = tierPerformance,
       _commonMistakes = commonMistakes,
       _timeDistribution = timeDistribution,
       super._();

  factory _$QuestionPerformanceStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionPerformanceStatsImplFromJson(json);

  /// Total number of attempts on this question
  @override
  @JsonKey()
  final int totalAttempts;

  /// Total number of correct attempts
  @override
  @JsonKey()
  final int totalCorrect;

  /// Global accuracy rate (0.0 to 1.0)
  @override
  @JsonKey()
  final double globalAccuracy;

  /// Average time spent on this question in seconds
  @override
  @JsonKey()
  final double averageTimeSeconds;

  /// Median time spent on this question in seconds
  @override
  @JsonKey()
  final double medianTimeSeconds;

  /// 95th percentile time spent on this question in seconds
  @override
  @JsonKey()
  final double p95TimeSeconds;

  /// Calculated difficulty score based on performance (0-1)
  @override
  @JsonKey()
  final double calculatedDifficulty;

  /// Performance statistics by user tier
  final Map<String, TierPerformance>? _tierPerformance;

  /// Performance statistics by user tier
  @override
  Map<String, TierPerformance>? get tierPerformance {
    final value = _tierPerformance;
    if (value == null) return null;
    if (_tierPerformance is EqualUnmodifiableMapView) return _tierPerformance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Common wrong answer patterns
  final List<WrongAnswerPattern>? _commonMistakes;

  /// Common wrong answer patterns
  @override
  List<WrongAnswerPattern>? get commonMistakes {
    final value = _commonMistakes;
    if (value == null) return null;
    if (_commonMistakes is EqualUnmodifiableListView) return _commonMistakes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Time distribution across different time buckets
  final Map<String, double>? _timeDistribution;

  /// Time distribution across different time buckets
  @override
  Map<String, double>? get timeDistribution {
    final value = _timeDistribution;
    if (value == null) return null;
    if (_timeDistribution is EqualUnmodifiableMapView) return _timeDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'QuestionPerformanceStats(totalAttempts: $totalAttempts, totalCorrect: $totalCorrect, globalAccuracy: $globalAccuracy, averageTimeSeconds: $averageTimeSeconds, medianTimeSeconds: $medianTimeSeconds, p95TimeSeconds: $p95TimeSeconds, calculatedDifficulty: $calculatedDifficulty, tierPerformance: $tierPerformance, commonMistakes: $commonMistakes, timeDistribution: $timeDistribution)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionPerformanceStatsImpl &&
            (identical(other.totalAttempts, totalAttempts) ||
                other.totalAttempts == totalAttempts) &&
            (identical(other.totalCorrect, totalCorrect) ||
                other.totalCorrect == totalCorrect) &&
            (identical(other.globalAccuracy, globalAccuracy) ||
                other.globalAccuracy == globalAccuracy) &&
            (identical(other.averageTimeSeconds, averageTimeSeconds) ||
                other.averageTimeSeconds == averageTimeSeconds) &&
            (identical(other.medianTimeSeconds, medianTimeSeconds) ||
                other.medianTimeSeconds == medianTimeSeconds) &&
            (identical(other.p95TimeSeconds, p95TimeSeconds) ||
                other.p95TimeSeconds == p95TimeSeconds) &&
            (identical(other.calculatedDifficulty, calculatedDifficulty) ||
                other.calculatedDifficulty == calculatedDifficulty) &&
            const DeepCollectionEquality().equals(
              other._tierPerformance,
              _tierPerformance,
            ) &&
            const DeepCollectionEquality().equals(
              other._commonMistakes,
              _commonMistakes,
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
    totalAttempts,
    totalCorrect,
    globalAccuracy,
    averageTimeSeconds,
    medianTimeSeconds,
    p95TimeSeconds,
    calculatedDifficulty,
    const DeepCollectionEquality().hash(_tierPerformance),
    const DeepCollectionEquality().hash(_commonMistakes),
    const DeepCollectionEquality().hash(_timeDistribution),
  );

  /// Create a copy of QuestionPerformanceStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionPerformanceStatsImplCopyWith<_$QuestionPerformanceStatsImpl>
  get copyWith =>
      __$$QuestionPerformanceStatsImplCopyWithImpl<
        _$QuestionPerformanceStatsImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionPerformanceStatsImplToJson(this);
  }
}

abstract class _QuestionPerformanceStats extends QuestionPerformanceStats {
  const factory _QuestionPerformanceStats({
    final int totalAttempts,
    final int totalCorrect,
    final double globalAccuracy,
    final double averageTimeSeconds,
    final double medianTimeSeconds,
    final double p95TimeSeconds,
    final double calculatedDifficulty,
    final Map<String, TierPerformance>? tierPerformance,
    final List<WrongAnswerPattern>? commonMistakes,
    final Map<String, double>? timeDistribution,
  }) = _$QuestionPerformanceStatsImpl;
  const _QuestionPerformanceStats._() : super._();

  factory _QuestionPerformanceStats.fromJson(Map<String, dynamic> json) =
      _$QuestionPerformanceStatsImpl.fromJson;

  /// Total number of attempts on this question
  @override
  int get totalAttempts;

  /// Total number of correct attempts
  @override
  int get totalCorrect;

  /// Global accuracy rate (0.0 to 1.0)
  @override
  double get globalAccuracy;

  /// Average time spent on this question in seconds
  @override
  double get averageTimeSeconds;

  /// Median time spent on this question in seconds
  @override
  double get medianTimeSeconds;

  /// 95th percentile time spent on this question in seconds
  @override
  double get p95TimeSeconds;

  /// Calculated difficulty score based on performance (0-1)
  @override
  double get calculatedDifficulty;

  /// Performance statistics by user tier
  @override
  Map<String, TierPerformance>? get tierPerformance;

  /// Common wrong answer patterns
  @override
  List<WrongAnswerPattern>? get commonMistakes;

  /// Time distribution across different time buckets
  @override
  Map<String, double>? get timeDistribution;

  /// Create a copy of QuestionPerformanceStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionPerformanceStatsImplCopyWith<_$QuestionPerformanceStatsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TierPerformance _$TierPerformanceFromJson(Map<String, dynamic> json) {
  return _TierPerformance.fromJson(json);
}

/// @nodoc
mixin _$TierPerformance {
  /// User tier (anonymous, free, paid)
  String get tier => throw _privateConstructorUsedError;

  /// Number of attempts by users in this tier
  int get attempts => throw _privateConstructorUsedError;

  /// Accuracy rate for this tier (0.0 to 1.0)
  double get accuracy => throw _privateConstructorUsedError;

  /// Average time spent by users in this tier
  double get avgTimeSeconds => throw _privateConstructorUsedError;

  /// Serializes this TierPerformance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TierPerformance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TierPerformanceCopyWith<TierPerformance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TierPerformanceCopyWith<$Res> {
  factory $TierPerformanceCopyWith(
    TierPerformance value,
    $Res Function(TierPerformance) then,
  ) = _$TierPerformanceCopyWithImpl<$Res, TierPerformance>;
  @useResult
  $Res call({
    String tier,
    int attempts,
    double accuracy,
    double avgTimeSeconds,
  });
}

/// @nodoc
class _$TierPerformanceCopyWithImpl<$Res, $Val extends TierPerformance>
    implements $TierPerformanceCopyWith<$Res> {
  _$TierPerformanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TierPerformance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tier = null,
    Object? attempts = null,
    Object? accuracy = null,
    Object? avgTimeSeconds = null,
  }) {
    return _then(
      _value.copyWith(
            tier: null == tier
                ? _value.tier
                : tier // ignore: cast_nullable_to_non_nullable
                      as String,
            attempts: null == attempts
                ? _value.attempts
                : attempts // ignore: cast_nullable_to_non_nullable
                      as int,
            accuracy: null == accuracy
                ? _value.accuracy
                : accuracy // ignore: cast_nullable_to_non_nullable
                      as double,
            avgTimeSeconds: null == avgTimeSeconds
                ? _value.avgTimeSeconds
                : avgTimeSeconds // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TierPerformanceImplCopyWith<$Res>
    implements $TierPerformanceCopyWith<$Res> {
  factory _$$TierPerformanceImplCopyWith(
    _$TierPerformanceImpl value,
    $Res Function(_$TierPerformanceImpl) then,
  ) = __$$TierPerformanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String tier,
    int attempts,
    double accuracy,
    double avgTimeSeconds,
  });
}

/// @nodoc
class __$$TierPerformanceImplCopyWithImpl<$Res>
    extends _$TierPerformanceCopyWithImpl<$Res, _$TierPerformanceImpl>
    implements _$$TierPerformanceImplCopyWith<$Res> {
  __$$TierPerformanceImplCopyWithImpl(
    _$TierPerformanceImpl _value,
    $Res Function(_$TierPerformanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TierPerformance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tier = null,
    Object? attempts = null,
    Object? accuracy = null,
    Object? avgTimeSeconds = null,
  }) {
    return _then(
      _$TierPerformanceImpl(
        tier: null == tier
            ? _value.tier
            : tier // ignore: cast_nullable_to_non_nullable
                  as String,
        attempts: null == attempts
            ? _value.attempts
            : attempts // ignore: cast_nullable_to_non_nullable
                  as int,
        accuracy: null == accuracy
            ? _value.accuracy
            : accuracy // ignore: cast_nullable_to_non_nullable
                  as double,
        avgTimeSeconds: null == avgTimeSeconds
            ? _value.avgTimeSeconds
            : avgTimeSeconds // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TierPerformanceImpl extends _TierPerformance {
  const _$TierPerformanceImpl({
    required this.tier,
    this.attempts = 0,
    this.accuracy = 0.0,
    this.avgTimeSeconds = 0.0,
  }) : super._();

  factory _$TierPerformanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$TierPerformanceImplFromJson(json);

  /// User tier (anonymous, free, paid)
  @override
  final String tier;

  /// Number of attempts by users in this tier
  @override
  @JsonKey()
  final int attempts;

  /// Accuracy rate for this tier (0.0 to 1.0)
  @override
  @JsonKey()
  final double accuracy;

  /// Average time spent by users in this tier
  @override
  @JsonKey()
  final double avgTimeSeconds;

  @override
  String toString() {
    return 'TierPerformance(tier: $tier, attempts: $attempts, accuracy: $accuracy, avgTimeSeconds: $avgTimeSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TierPerformanceImpl &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.attempts, attempts) ||
                other.attempts == attempts) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.avgTimeSeconds, avgTimeSeconds) ||
                other.avgTimeSeconds == avgTimeSeconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, tier, attempts, accuracy, avgTimeSeconds);

  /// Create a copy of TierPerformance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TierPerformanceImplCopyWith<_$TierPerformanceImpl> get copyWith =>
      __$$TierPerformanceImplCopyWithImpl<_$TierPerformanceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TierPerformanceImplToJson(this);
  }
}

abstract class _TierPerformance extends TierPerformance {
  const factory _TierPerformance({
    required final String tier,
    final int attempts,
    final double accuracy,
    final double avgTimeSeconds,
  }) = _$TierPerformanceImpl;
  const _TierPerformance._() : super._();

  factory _TierPerformance.fromJson(Map<String, dynamic> json) =
      _$TierPerformanceImpl.fromJson;

  /// User tier (anonymous, free, paid)
  @override
  String get tier;

  /// Number of attempts by users in this tier
  @override
  int get attempts;

  /// Accuracy rate for this tier (0.0 to 1.0)
  @override
  double get accuracy;

  /// Average time spent by users in this tier
  @override
  double get avgTimeSeconds;

  /// Create a copy of TierPerformance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TierPerformanceImplCopyWith<_$TierPerformanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WrongAnswerPattern _$WrongAnswerPatternFromJson(Map<String, dynamic> json) {
  return _WrongAnswerPattern.fromJson(json);
}

/// @nodoc
mixin _$WrongAnswerPattern {
  /// The option ID that was incorrectly selected
  String get optionId => throw _privateConstructorUsedError;

  /// Number of times this option was selected incorrectly
  int get selectionCount => throw _privateConstructorUsedError;

  /// Percentage of wrong answers that chose this option
  double get percentage => throw _privateConstructorUsedError;

  /// Serializes this WrongAnswerPattern to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WrongAnswerPattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WrongAnswerPatternCopyWith<WrongAnswerPattern> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WrongAnswerPatternCopyWith<$Res> {
  factory $WrongAnswerPatternCopyWith(
    WrongAnswerPattern value,
    $Res Function(WrongAnswerPattern) then,
  ) = _$WrongAnswerPatternCopyWithImpl<$Res, WrongAnswerPattern>;
  @useResult
  $Res call({String optionId, int selectionCount, double percentage});
}

/// @nodoc
class _$WrongAnswerPatternCopyWithImpl<$Res, $Val extends WrongAnswerPattern>
    implements $WrongAnswerPatternCopyWith<$Res> {
  _$WrongAnswerPatternCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WrongAnswerPattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? optionId = null,
    Object? selectionCount = null,
    Object? percentage = null,
  }) {
    return _then(
      _value.copyWith(
            optionId: null == optionId
                ? _value.optionId
                : optionId // ignore: cast_nullable_to_non_nullable
                      as String,
            selectionCount: null == selectionCount
                ? _value.selectionCount
                : selectionCount // ignore: cast_nullable_to_non_nullable
                      as int,
            percentage: null == percentage
                ? _value.percentage
                : percentage // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WrongAnswerPatternImplCopyWith<$Res>
    implements $WrongAnswerPatternCopyWith<$Res> {
  factory _$$WrongAnswerPatternImplCopyWith(
    _$WrongAnswerPatternImpl value,
    $Res Function(_$WrongAnswerPatternImpl) then,
  ) = __$$WrongAnswerPatternImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String optionId, int selectionCount, double percentage});
}

/// @nodoc
class __$$WrongAnswerPatternImplCopyWithImpl<$Res>
    extends _$WrongAnswerPatternCopyWithImpl<$Res, _$WrongAnswerPatternImpl>
    implements _$$WrongAnswerPatternImplCopyWith<$Res> {
  __$$WrongAnswerPatternImplCopyWithImpl(
    _$WrongAnswerPatternImpl _value,
    $Res Function(_$WrongAnswerPatternImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WrongAnswerPattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? optionId = null,
    Object? selectionCount = null,
    Object? percentage = null,
  }) {
    return _then(
      _$WrongAnswerPatternImpl(
        optionId: null == optionId
            ? _value.optionId
            : optionId // ignore: cast_nullable_to_non_nullable
                  as String,
        selectionCount: null == selectionCount
            ? _value.selectionCount
            : selectionCount // ignore: cast_nullable_to_non_nullable
                  as int,
        percentage: null == percentage
            ? _value.percentage
            : percentage // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WrongAnswerPatternImpl extends _WrongAnswerPattern {
  const _$WrongAnswerPatternImpl({
    required this.optionId,
    this.selectionCount = 0,
    this.percentage = 0.0,
  }) : super._();

  factory _$WrongAnswerPatternImpl.fromJson(Map<String, dynamic> json) =>
      _$$WrongAnswerPatternImplFromJson(json);

  /// The option ID that was incorrectly selected
  @override
  final String optionId;

  /// Number of times this option was selected incorrectly
  @override
  @JsonKey()
  final int selectionCount;

  /// Percentage of wrong answers that chose this option
  @override
  @JsonKey()
  final double percentage;

  @override
  String toString() {
    return 'WrongAnswerPattern(optionId: $optionId, selectionCount: $selectionCount, percentage: $percentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WrongAnswerPatternImpl &&
            (identical(other.optionId, optionId) ||
                other.optionId == optionId) &&
            (identical(other.selectionCount, selectionCount) ||
                other.selectionCount == selectionCount) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, optionId, selectionCount, percentage);

  /// Create a copy of WrongAnswerPattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WrongAnswerPatternImplCopyWith<_$WrongAnswerPatternImpl> get copyWith =>
      __$$WrongAnswerPatternImplCopyWithImpl<_$WrongAnswerPatternImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WrongAnswerPatternImplToJson(this);
  }
}

abstract class _WrongAnswerPattern extends WrongAnswerPattern {
  const factory _WrongAnswerPattern({
    required final String optionId,
    final int selectionCount,
    final double percentage,
  }) = _$WrongAnswerPatternImpl;
  const _WrongAnswerPattern._() : super._();

  factory _WrongAnswerPattern.fromJson(Map<String, dynamic> json) =
      _$WrongAnswerPatternImpl.fromJson;

  /// The option ID that was incorrectly selected
  @override
  String get optionId;

  /// Number of times this option was selected incorrectly
  @override
  int get selectionCount;

  /// Percentage of wrong answers that chose this option
  @override
  double get percentage;

  /// Create a copy of WrongAnswerPattern
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WrongAnswerPatternImplCopyWith<_$WrongAnswerPatternImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
