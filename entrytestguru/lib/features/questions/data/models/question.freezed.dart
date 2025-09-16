// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return _Question.fromJson(json);
}

/// @nodoc
mixin _$Question {
  // Identity & Metadata
  String get id => throw _privateConstructorUsedError;
  String get questionId => throw _privateConstructorUsedError;
  String get examCategory => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get topic => throw _privateConstructorUsedError;
  String? get subTopic => throw _privateConstructorUsedError; // Content
  String get questionText => throw _privateConstructorUsedError;
  String? get questionImageUrl => throw _privateConstructorUsedError;
  String? get questionLatex =>
      throw _privateConstructorUsedError; // Options & Answer
  List<QuestionOption> get options => throw _privateConstructorUsedError;
  List<String> get correctAnswer => throw _privateConstructorUsedError;
  QuestionType get questionType =>
      throw _privateConstructorUsedError; // Explanations & Resources
  String get explanationText => throw _privateConstructorUsedError;
  String? get explanationVideoUrl => throw _privateConstructorUsedError;
  List<String>? get explanationSteps => throw _privateConstructorUsedError;
  List<String>? get references =>
      throw _privateConstructorUsedError; // ARDE Intelligence (Core Differentiator)
  ArdeLevel get ardeProbability => throw _privateConstructorUsedError;
  int get ardeFrequency => throw _privateConstructorUsedError;
  List<int>? get ardeAppearanceYears => throw _privateConstructorUsedError;
  String? get ardeNotes => throw _privateConstructorUsedError;
  String? get ardeContext =>
      throw _privateConstructorUsedError; // Difficulty & Performance
  DifficultyLevel get difficulty => throw _privateConstructorUsedError;
  int get estimatedTimeSeconds =>
      throw _privateConstructorUsedError; // Global Performance Analytics
  QuestionPerformanceStats get globalStats =>
      throw _privateConstructorUsedError; // Search & Discovery
  List<String> get tags => throw _privateConstructorUsedError;
  List<String>? get relatedQuestions =>
      throw _privateConstructorUsedError; // Administrative
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  int? get version => throw _privateConstructorUsedError;
  String? get status =>
      throw _privateConstructorUsedError; // User-specific (populated at runtime)
  bool get isBookmarked => throw _privateConstructorUsedError;
  String? get userNotes => throw _privateConstructorUsedError;
  QuestionAttempt? get lastAttempt => throw _privateConstructorUsedError;

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionCopyWith<Question> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionCopyWith<$Res> {
  factory $QuestionCopyWith(Question value, $Res Function(Question) then) =
      _$QuestionCopyWithImpl<$Res, Question>;
  @useResult
  $Res call({
    String id,
    String questionId,
    String examCategory,
    String subject,
    String topic,
    String? subTopic,
    String questionText,
    String? questionImageUrl,
    String? questionLatex,
    List<QuestionOption> options,
    List<String> correctAnswer,
    QuestionType questionType,
    String explanationText,
    String? explanationVideoUrl,
    List<String>? explanationSteps,
    List<String>? references,
    ArdeLevel ardeProbability,
    int ardeFrequency,
    List<int>? ardeAppearanceYears,
    String? ardeNotes,
    String? ardeContext,
    DifficultyLevel difficulty,
    int estimatedTimeSeconds,
    QuestionPerformanceStats globalStats,
    List<String> tags,
    List<String>? relatedQuestions,
    DateTime createdAt,
    DateTime updatedAt,
    String createdBy,
    bool? isActive,
    int? version,
    String? status,
    bool isBookmarked,
    String? userNotes,
    QuestionAttempt? lastAttempt,
  });

  $QuestionPerformanceStatsCopyWith<$Res> get globalStats;
  $QuestionAttemptCopyWith<$Res>? get lastAttempt;
}

/// @nodoc
class _$QuestionCopyWithImpl<$Res, $Val extends Question>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? questionId = null,
    Object? examCategory = null,
    Object? subject = null,
    Object? topic = null,
    Object? subTopic = freezed,
    Object? questionText = null,
    Object? questionImageUrl = freezed,
    Object? questionLatex = freezed,
    Object? options = null,
    Object? correctAnswer = null,
    Object? questionType = null,
    Object? explanationText = null,
    Object? explanationVideoUrl = freezed,
    Object? explanationSteps = freezed,
    Object? references = freezed,
    Object? ardeProbability = null,
    Object? ardeFrequency = null,
    Object? ardeAppearanceYears = freezed,
    Object? ardeNotes = freezed,
    Object? ardeContext = freezed,
    Object? difficulty = null,
    Object? estimatedTimeSeconds = null,
    Object? globalStats = null,
    Object? tags = null,
    Object? relatedQuestions = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? createdBy = null,
    Object? isActive = freezed,
    Object? version = freezed,
    Object? status = freezed,
    Object? isBookmarked = null,
    Object? userNotes = freezed,
    Object? lastAttempt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            questionId: null == questionId
                ? _value.questionId
                : questionId // ignore: cast_nullable_to_non_nullable
                      as String,
            examCategory: null == examCategory
                ? _value.examCategory
                : examCategory // ignore: cast_nullable_to_non_nullable
                      as String,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            topic: null == topic
                ? _value.topic
                : topic // ignore: cast_nullable_to_non_nullable
                      as String,
            subTopic: freezed == subTopic
                ? _value.subTopic
                : subTopic // ignore: cast_nullable_to_non_nullable
                      as String?,
            questionText: null == questionText
                ? _value.questionText
                : questionText // ignore: cast_nullable_to_non_nullable
                      as String,
            questionImageUrl: freezed == questionImageUrl
                ? _value.questionImageUrl
                : questionImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            questionLatex: freezed == questionLatex
                ? _value.questionLatex
                : questionLatex // ignore: cast_nullable_to_non_nullable
                      as String?,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<QuestionOption>,
            correctAnswer: null == correctAnswer
                ? _value.correctAnswer
                : correctAnswer // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            questionType: null == questionType
                ? _value.questionType
                : questionType // ignore: cast_nullable_to_non_nullable
                      as QuestionType,
            explanationText: null == explanationText
                ? _value.explanationText
                : explanationText // ignore: cast_nullable_to_non_nullable
                      as String,
            explanationVideoUrl: freezed == explanationVideoUrl
                ? _value.explanationVideoUrl
                : explanationVideoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            explanationSteps: freezed == explanationSteps
                ? _value.explanationSteps
                : explanationSteps // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            references: freezed == references
                ? _value.references
                : references // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            ardeProbability: null == ardeProbability
                ? _value.ardeProbability
                : ardeProbability // ignore: cast_nullable_to_non_nullable
                      as ArdeLevel,
            ardeFrequency: null == ardeFrequency
                ? _value.ardeFrequency
                : ardeFrequency // ignore: cast_nullable_to_non_nullable
                      as int,
            ardeAppearanceYears: freezed == ardeAppearanceYears
                ? _value.ardeAppearanceYears
                : ardeAppearanceYears // ignore: cast_nullable_to_non_nullable
                      as List<int>?,
            ardeNotes: freezed == ardeNotes
                ? _value.ardeNotes
                : ardeNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            ardeContext: freezed == ardeContext
                ? _value.ardeContext
                : ardeContext // ignore: cast_nullable_to_non_nullable
                      as String?,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as DifficultyLevel,
            estimatedTimeSeconds: null == estimatedTimeSeconds
                ? _value.estimatedTimeSeconds
                : estimatedTimeSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            globalStats: null == globalStats
                ? _value.globalStats
                : globalStats // ignore: cast_nullable_to_non_nullable
                      as QuestionPerformanceStats,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            relatedQuestions: freezed == relatedQuestions
                ? _value.relatedQuestions
                : relatedQuestions // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: freezed == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool?,
            version: freezed == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as int?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            isBookmarked: null == isBookmarked
                ? _value.isBookmarked
                : isBookmarked // ignore: cast_nullable_to_non_nullable
                      as bool,
            userNotes: freezed == userNotes
                ? _value.userNotes
                : userNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastAttempt: freezed == lastAttempt
                ? _value.lastAttempt
                : lastAttempt // ignore: cast_nullable_to_non_nullable
                      as QuestionAttempt?,
          )
          as $Val,
    );
  }

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuestionPerformanceStatsCopyWith<$Res> get globalStats {
    return $QuestionPerformanceStatsCopyWith<$Res>(_value.globalStats, (value) {
      return _then(_value.copyWith(globalStats: value) as $Val);
    });
  }

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuestionAttemptCopyWith<$Res>? get lastAttempt {
    if (_value.lastAttempt == null) {
      return null;
    }

    return $QuestionAttemptCopyWith<$Res>(_value.lastAttempt!, (value) {
      return _then(_value.copyWith(lastAttempt: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QuestionImplCopyWith<$Res>
    implements $QuestionCopyWith<$Res> {
  factory _$$QuestionImplCopyWith(
    _$QuestionImpl value,
    $Res Function(_$QuestionImpl) then,
  ) = __$$QuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String questionId,
    String examCategory,
    String subject,
    String topic,
    String? subTopic,
    String questionText,
    String? questionImageUrl,
    String? questionLatex,
    List<QuestionOption> options,
    List<String> correctAnswer,
    QuestionType questionType,
    String explanationText,
    String? explanationVideoUrl,
    List<String>? explanationSteps,
    List<String>? references,
    ArdeLevel ardeProbability,
    int ardeFrequency,
    List<int>? ardeAppearanceYears,
    String? ardeNotes,
    String? ardeContext,
    DifficultyLevel difficulty,
    int estimatedTimeSeconds,
    QuestionPerformanceStats globalStats,
    List<String> tags,
    List<String>? relatedQuestions,
    DateTime createdAt,
    DateTime updatedAt,
    String createdBy,
    bool? isActive,
    int? version,
    String? status,
    bool isBookmarked,
    String? userNotes,
    QuestionAttempt? lastAttempt,
  });

  @override
  $QuestionPerformanceStatsCopyWith<$Res> get globalStats;
  @override
  $QuestionAttemptCopyWith<$Res>? get lastAttempt;
}

/// @nodoc
class __$$QuestionImplCopyWithImpl<$Res>
    extends _$QuestionCopyWithImpl<$Res, _$QuestionImpl>
    implements _$$QuestionImplCopyWith<$Res> {
  __$$QuestionImplCopyWithImpl(
    _$QuestionImpl _value,
    $Res Function(_$QuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? questionId = null,
    Object? examCategory = null,
    Object? subject = null,
    Object? topic = null,
    Object? subTopic = freezed,
    Object? questionText = null,
    Object? questionImageUrl = freezed,
    Object? questionLatex = freezed,
    Object? options = null,
    Object? correctAnswer = null,
    Object? questionType = null,
    Object? explanationText = null,
    Object? explanationVideoUrl = freezed,
    Object? explanationSteps = freezed,
    Object? references = freezed,
    Object? ardeProbability = null,
    Object? ardeFrequency = null,
    Object? ardeAppearanceYears = freezed,
    Object? ardeNotes = freezed,
    Object? ardeContext = freezed,
    Object? difficulty = null,
    Object? estimatedTimeSeconds = null,
    Object? globalStats = null,
    Object? tags = null,
    Object? relatedQuestions = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? createdBy = null,
    Object? isActive = freezed,
    Object? version = freezed,
    Object? status = freezed,
    Object? isBookmarked = null,
    Object? userNotes = freezed,
    Object? lastAttempt = freezed,
  }) {
    return _then(
      _$QuestionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        questionId: null == questionId
            ? _value.questionId
            : questionId // ignore: cast_nullable_to_non_nullable
                  as String,
        examCategory: null == examCategory
            ? _value.examCategory
            : examCategory // ignore: cast_nullable_to_non_nullable
                  as String,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        topic: null == topic
            ? _value.topic
            : topic // ignore: cast_nullable_to_non_nullable
                  as String,
        subTopic: freezed == subTopic
            ? _value.subTopic
            : subTopic // ignore: cast_nullable_to_non_nullable
                  as String?,
        questionText: null == questionText
            ? _value.questionText
            : questionText // ignore: cast_nullable_to_non_nullable
                  as String,
        questionImageUrl: freezed == questionImageUrl
            ? _value.questionImageUrl
            : questionImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        questionLatex: freezed == questionLatex
            ? _value.questionLatex
            : questionLatex // ignore: cast_nullable_to_non_nullable
                  as String?,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<QuestionOption>,
        correctAnswer: null == correctAnswer
            ? _value._correctAnswer
            : correctAnswer // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        questionType: null == questionType
            ? _value.questionType
            : questionType // ignore: cast_nullable_to_non_nullable
                  as QuestionType,
        explanationText: null == explanationText
            ? _value.explanationText
            : explanationText // ignore: cast_nullable_to_non_nullable
                  as String,
        explanationVideoUrl: freezed == explanationVideoUrl
            ? _value.explanationVideoUrl
            : explanationVideoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        explanationSteps: freezed == explanationSteps
            ? _value._explanationSteps
            : explanationSteps // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        references: freezed == references
            ? _value._references
            : references // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        ardeProbability: null == ardeProbability
            ? _value.ardeProbability
            : ardeProbability // ignore: cast_nullable_to_non_nullable
                  as ArdeLevel,
        ardeFrequency: null == ardeFrequency
            ? _value.ardeFrequency
            : ardeFrequency // ignore: cast_nullable_to_non_nullable
                  as int,
        ardeAppearanceYears: freezed == ardeAppearanceYears
            ? _value._ardeAppearanceYears
            : ardeAppearanceYears // ignore: cast_nullable_to_non_nullable
                  as List<int>?,
        ardeNotes: freezed == ardeNotes
            ? _value.ardeNotes
            : ardeNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        ardeContext: freezed == ardeContext
            ? _value.ardeContext
            : ardeContext // ignore: cast_nullable_to_non_nullable
                  as String?,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as DifficultyLevel,
        estimatedTimeSeconds: null == estimatedTimeSeconds
            ? _value.estimatedTimeSeconds
            : estimatedTimeSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        globalStats: null == globalStats
            ? _value.globalStats
            : globalStats // ignore: cast_nullable_to_non_nullable
                  as QuestionPerformanceStats,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        relatedQuestions: freezed == relatedQuestions
            ? _value._relatedQuestions
            : relatedQuestions // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: freezed == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool?,
        version: freezed == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        isBookmarked: null == isBookmarked
            ? _value.isBookmarked
            : isBookmarked // ignore: cast_nullable_to_non_nullable
                  as bool,
        userNotes: freezed == userNotes
            ? _value.userNotes
            : userNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastAttempt: freezed == lastAttempt
            ? _value.lastAttempt
            : lastAttempt // ignore: cast_nullable_to_non_nullable
                  as QuestionAttempt?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionImpl extends _Question {
  const _$QuestionImpl({
    required this.id,
    required this.questionId,
    required this.examCategory,
    required this.subject,
    required this.topic,
    this.subTopic,
    required this.questionText,
    this.questionImageUrl,
    this.questionLatex,
    required final List<QuestionOption> options,
    required final List<String> correctAnswer,
    this.questionType = QuestionType.singleChoice,
    required this.explanationText,
    this.explanationVideoUrl,
    final List<String>? explanationSteps,
    final List<String>? references,
    required this.ardeProbability,
    this.ardeFrequency = 0,
    final List<int>? ardeAppearanceYears,
    this.ardeNotes,
    this.ardeContext,
    required this.difficulty,
    this.estimatedTimeSeconds = 60,
    required this.globalStats,
    final List<String> tags = const [],
    final List<String>? relatedQuestions,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    this.isActive = true,
    this.version = 1,
    this.status,
    this.isBookmarked = false,
    this.userNotes,
    this.lastAttempt,
  }) : _options = options,
       _correctAnswer = correctAnswer,
       _explanationSteps = explanationSteps,
       _references = references,
       _ardeAppearanceYears = ardeAppearanceYears,
       _tags = tags,
       _relatedQuestions = relatedQuestions,
       super._();

  factory _$QuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionImplFromJson(json);

  // Identity & Metadata
  @override
  final String id;
  @override
  final String questionId;
  @override
  final String examCategory;
  @override
  final String subject;
  @override
  final String topic;
  @override
  final String? subTopic;
  // Content
  @override
  final String questionText;
  @override
  final String? questionImageUrl;
  @override
  final String? questionLatex;
  // Options & Answer
  final List<QuestionOption> _options;
  // Options & Answer
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
  @JsonKey()
  final QuestionType questionType;
  // Explanations & Resources
  @override
  final String explanationText;
  @override
  final String? explanationVideoUrl;
  final List<String>? _explanationSteps;
  @override
  List<String>? get explanationSteps {
    final value = _explanationSteps;
    if (value == null) return null;
    if (_explanationSteps is EqualUnmodifiableListView)
      return _explanationSteps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _references;
  @override
  List<String>? get references {
    final value = _references;
    if (value == null) return null;
    if (_references is EqualUnmodifiableListView) return _references;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // ARDE Intelligence (Core Differentiator)
  @override
  final ArdeLevel ardeProbability;
  @override
  @JsonKey()
  final int ardeFrequency;
  final List<int>? _ardeAppearanceYears;
  @override
  List<int>? get ardeAppearanceYears {
    final value = _ardeAppearanceYears;
    if (value == null) return null;
    if (_ardeAppearanceYears is EqualUnmodifiableListView)
      return _ardeAppearanceYears;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? ardeNotes;
  @override
  final String? ardeContext;
  // Difficulty & Performance
  @override
  final DifficultyLevel difficulty;
  @override
  @JsonKey()
  final int estimatedTimeSeconds;
  // Global Performance Analytics
  @override
  final QuestionPerformanceStats globalStats;
  // Search & Discovery
  final List<String> _tags;
  // Search & Discovery
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<String>? _relatedQuestions;
  @override
  List<String>? get relatedQuestions {
    final value = _relatedQuestions;
    if (value == null) return null;
    if (_relatedQuestions is EqualUnmodifiableListView)
      return _relatedQuestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // Administrative
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String createdBy;
  @override
  @JsonKey()
  final bool? isActive;
  @override
  @JsonKey()
  final int? version;
  @override
  final String? status;
  // User-specific (populated at runtime)
  @override
  @JsonKey()
  final bool isBookmarked;
  @override
  final String? userNotes;
  @override
  final QuestionAttempt? lastAttempt;

  @override
  String toString() {
    return 'Question(id: $id, questionId: $questionId, examCategory: $examCategory, subject: $subject, topic: $topic, subTopic: $subTopic, questionText: $questionText, questionImageUrl: $questionImageUrl, questionLatex: $questionLatex, options: $options, correctAnswer: $correctAnswer, questionType: $questionType, explanationText: $explanationText, explanationVideoUrl: $explanationVideoUrl, explanationSteps: $explanationSteps, references: $references, ardeProbability: $ardeProbability, ardeFrequency: $ardeFrequency, ardeAppearanceYears: $ardeAppearanceYears, ardeNotes: $ardeNotes, ardeContext: $ardeContext, difficulty: $difficulty, estimatedTimeSeconds: $estimatedTimeSeconds, globalStats: $globalStats, tags: $tags, relatedQuestions: $relatedQuestions, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, isActive: $isActive, version: $version, status: $status, isBookmarked: $isBookmarked, userNotes: $userNotes, lastAttempt: $lastAttempt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.examCategory, examCategory) ||
                other.examCategory == examCategory) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.subTopic, subTopic) ||
                other.subTopic == subTopic) &&
            (identical(other.questionText, questionText) ||
                other.questionText == questionText) &&
            (identical(other.questionImageUrl, questionImageUrl) ||
                other.questionImageUrl == questionImageUrl) &&
            (identical(other.questionLatex, questionLatex) ||
                other.questionLatex == questionLatex) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            const DeepCollectionEquality().equals(
              other._correctAnswer,
              _correctAnswer,
            ) &&
            (identical(other.questionType, questionType) ||
                other.questionType == questionType) &&
            (identical(other.explanationText, explanationText) ||
                other.explanationText == explanationText) &&
            (identical(other.explanationVideoUrl, explanationVideoUrl) ||
                other.explanationVideoUrl == explanationVideoUrl) &&
            const DeepCollectionEquality().equals(
              other._explanationSteps,
              _explanationSteps,
            ) &&
            const DeepCollectionEquality().equals(
              other._references,
              _references,
            ) &&
            (identical(other.ardeProbability, ardeProbability) ||
                other.ardeProbability == ardeProbability) &&
            (identical(other.ardeFrequency, ardeFrequency) ||
                other.ardeFrequency == ardeFrequency) &&
            const DeepCollectionEquality().equals(
              other._ardeAppearanceYears,
              _ardeAppearanceYears,
            ) &&
            (identical(other.ardeNotes, ardeNotes) ||
                other.ardeNotes == ardeNotes) &&
            (identical(other.ardeContext, ardeContext) ||
                other.ardeContext == ardeContext) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.estimatedTimeSeconds, estimatedTimeSeconds) ||
                other.estimatedTimeSeconds == estimatedTimeSeconds) &&
            (identical(other.globalStats, globalStats) ||
                other.globalStats == globalStats) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(
              other._relatedQuestions,
              _relatedQuestions,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isBookmarked, isBookmarked) ||
                other.isBookmarked == isBookmarked) &&
            (identical(other.userNotes, userNotes) ||
                other.userNotes == userNotes) &&
            (identical(other.lastAttempt, lastAttempt) ||
                other.lastAttempt == lastAttempt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    questionId,
    examCategory,
    subject,
    topic,
    subTopic,
    questionText,
    questionImageUrl,
    questionLatex,
    const DeepCollectionEquality().hash(_options),
    const DeepCollectionEquality().hash(_correctAnswer),
    questionType,
    explanationText,
    explanationVideoUrl,
    const DeepCollectionEquality().hash(_explanationSteps),
    const DeepCollectionEquality().hash(_references),
    ardeProbability,
    ardeFrequency,
    const DeepCollectionEquality().hash(_ardeAppearanceYears),
    ardeNotes,
    ardeContext,
    difficulty,
    estimatedTimeSeconds,
    globalStats,
    const DeepCollectionEquality().hash(_tags),
    const DeepCollectionEquality().hash(_relatedQuestions),
    createdAt,
    updatedAt,
    createdBy,
    isActive,
    version,
    status,
    isBookmarked,
    userNotes,
    lastAttempt,
  ]);

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionImplCopyWith<_$QuestionImpl> get copyWith =>
      __$$QuestionImplCopyWithImpl<_$QuestionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionImplToJson(this);
  }
}

abstract class _Question extends Question {
  const factory _Question({
    required final String id,
    required final String questionId,
    required final String examCategory,
    required final String subject,
    required final String topic,
    final String? subTopic,
    required final String questionText,
    final String? questionImageUrl,
    final String? questionLatex,
    required final List<QuestionOption> options,
    required final List<String> correctAnswer,
    final QuestionType questionType,
    required final String explanationText,
    final String? explanationVideoUrl,
    final List<String>? explanationSteps,
    final List<String>? references,
    required final ArdeLevel ardeProbability,
    final int ardeFrequency,
    final List<int>? ardeAppearanceYears,
    final String? ardeNotes,
    final String? ardeContext,
    required final DifficultyLevel difficulty,
    final int estimatedTimeSeconds,
    required final QuestionPerformanceStats globalStats,
    final List<String> tags,
    final List<String>? relatedQuestions,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    required final String createdBy,
    final bool? isActive,
    final int? version,
    final String? status,
    final bool isBookmarked,
    final String? userNotes,
    final QuestionAttempt? lastAttempt,
  }) = _$QuestionImpl;
  const _Question._() : super._();

  factory _Question.fromJson(Map<String, dynamic> json) =
      _$QuestionImpl.fromJson;

  // Identity & Metadata
  @override
  String get id;
  @override
  String get questionId;
  @override
  String get examCategory;
  @override
  String get subject;
  @override
  String get topic;
  @override
  String? get subTopic; // Content
  @override
  String get questionText;
  @override
  String? get questionImageUrl;
  @override
  String? get questionLatex; // Options & Answer
  @override
  List<QuestionOption> get options;
  @override
  List<String> get correctAnswer;
  @override
  QuestionType get questionType; // Explanations & Resources
  @override
  String get explanationText;
  @override
  String? get explanationVideoUrl;
  @override
  List<String>? get explanationSteps;
  @override
  List<String>? get references; // ARDE Intelligence (Core Differentiator)
  @override
  ArdeLevel get ardeProbability;
  @override
  int get ardeFrequency;
  @override
  List<int>? get ardeAppearanceYears;
  @override
  String? get ardeNotes;
  @override
  String? get ardeContext; // Difficulty & Performance
  @override
  DifficultyLevel get difficulty;
  @override
  int get estimatedTimeSeconds; // Global Performance Analytics
  @override
  QuestionPerformanceStats get globalStats; // Search & Discovery
  @override
  List<String> get tags;
  @override
  List<String>? get relatedQuestions; // Administrative
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  String get createdBy;
  @override
  bool? get isActive;
  @override
  int? get version;
  @override
  String? get status; // User-specific (populated at runtime)
  @override
  bool get isBookmarked;
  @override
  String? get userNotes;
  @override
  QuestionAttempt? get lastAttempt;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionImplCopyWith<_$QuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
