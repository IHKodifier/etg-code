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

/// @nodoc
mixin _$Question {
  // Identity & Metadata
  String get id => throw _privateConstructorUsedError;
  int get questionId =>
      throw _privateConstructorUsedError; // Changed from String to int
  String get examCategory => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get topic => throw _privateConstructorUsedError;
  String? get subTopic => throw _privateConstructorUsedError; // Content
  String get questionText => throw _privateConstructorUsedError;
  List<String>? get questionImageUrls =>
      throw _privateConstructorUsedError; // Multiple image URLs
  List<String>? get questionLatex =>
      throw _privateConstructorUsedError; // Multiple LaTeX expressions
  // Options & Answer
  List<QuestionOption> get options => throw _privateConstructorUsedError;
  List<String> get correctAnswer => throw _privateConstructorUsedError;
  QuestionType get questionType =>
      throw _privateConstructorUsedError; // Explanations & Resources
  String get explanationText => throw _privateConstructorUsedError;
  String? get explanationVideoUrl => throw _privateConstructorUsedError;
  List<String>? get explanationSteps => throw _privateConstructorUsedError;
  List<String>? get references =>
      throw _privateConstructorUsedError; // ARDE Intelligence (Core Differentiator)
  double get ardeProbability =>
      throw _privateConstructorUsedError; // Changed from ArdeLevel enum to double
  int get ardeFrequency => throw _privateConstructorUsedError;
  List<int>? get ardeAppearanceYears => throw _privateConstructorUsedError;
  String? get ardeNotes => throw _privateConstructorUsedError;
  String? get ardeContext =>
      throw _privateConstructorUsedError; // Difficulty & Performance
  DifficultyLevel get difficulty => throw _privateConstructorUsedError;
  int get estimatedTimeSeconds =>
      throw _privateConstructorUsedError; // Performance stats removed - now calculated from question_attempts collection
  // Search & Discovery
  List<String> get tags => throw _privateConstructorUsedError;
  List<String>? get relatedQuestions =>
      throw _privateConstructorUsedError; // Administrative
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  String? get createdByName => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  int? get version => throw _privateConstructorUsedError;
  String? get status =>
      throw _privateConstructorUsedError; // Approval workflow fields
  @JsonKey(name: 'approval_status')
  String get approvalStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'reviewer_id')
  String? get reviewerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'reviewer_name')
  String? get reviewerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'review_comments')
  String? get reviewComments => throw _privateConstructorUsedError;
  @JsonKey(name: 'submitted_at')
  DateTime get submittedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'reviewed_at')
  DateTime? get reviewedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'approved_at')
  DateTime? get approvedAt => throw _privateConstructorUsedError; // User-specific (populated at runtime)
  bool get isBookmarked => throw _privateConstructorUsedError;
  String? get userNotes => throw _privateConstructorUsedError;
  QuestionAttempt? get lastAttempt => throw _privateConstructorUsedError;

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
    int questionId,
    String examCategory,
    String subject,
    String topic,
    String? subTopic,
    String questionText,
    List<String>? questionImageUrls,
    List<String>? questionLatex,
    List<QuestionOption> options,
    List<String> correctAnswer,
    QuestionType questionType,
    String explanationText,
    String? explanationVideoUrl,
    List<String>? explanationSteps,
    List<String>? references,
    double ardeProbability,
    int ardeFrequency,
    List<int>? ardeAppearanceYears,
    String? ardeNotes,
    String? ardeContext,
    DifficultyLevel difficulty,
    int estimatedTimeSeconds,
    List<String> tags,
    List<String>? relatedQuestions,
    DateTime createdAt,
    DateTime updatedAt,
    String createdBy,
    String? createdByName,
    bool? isActive,
    int? version,
    String? status,
    @JsonKey(name: 'approval_status') String approvalStatus,
    @JsonKey(name: 'reviewer_id') String? reviewerId,
    @JsonKey(name: 'reviewer_name') String? reviewerName,
    @JsonKey(name: 'review_comments') String? reviewComments,
    @JsonKey(name: 'submitted_at') DateTime submittedAt,
    @JsonKey(name: 'reviewed_at') DateTime? reviewedAt,
    @JsonKey(name: 'approved_at') DateTime? approvedAt,
    bool isBookmarked,
    String? userNotes,
    QuestionAttempt? lastAttempt,
  });

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
    Object? questionImageUrls = freezed,
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
    Object? tags = null,
    Object? relatedQuestions = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? createdBy = null,
    Object? createdByName = freezed,
    Object? isActive = freezed,
    Object? version = freezed,
    Object? status = freezed,
    Object? approvalStatus = null,
    Object? reviewerId = freezed,
    Object? reviewerName = freezed,
    Object? reviewComments = freezed,
    Object? submittedAt = null,
    Object? reviewedAt = freezed,
    Object? approvedAt = freezed,
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
                      as int,
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
            questionImageUrls: freezed == questionImageUrls
                ? _value.questionImageUrls
                : questionImageUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            questionLatex: freezed == questionLatex
                ? _value.questionLatex
                : questionLatex // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
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
                      as double,
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
            createdByName: freezed == createdByName
                ? _value.createdByName
                : createdByName // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            approvalStatus: null == approvalStatus
                ? _value.approvalStatus
                : approvalStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            reviewerId: freezed == reviewerId
                ? _value.reviewerId
                : reviewerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            reviewerName: freezed == reviewerName
                ? _value.reviewerName
                : reviewerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            reviewComments: freezed == reviewComments
                ? _value.reviewComments
                : reviewComments // ignore: cast_nullable_to_non_nullable
                      as String?,
            submittedAt: null == submittedAt
                ? _value.submittedAt
                : submittedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            reviewedAt: freezed == reviewedAt
                ? _value.reviewedAt
                : reviewedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            approvedAt: freezed == approvedAt
                ? _value.approvedAt
                : approvedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
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
    int questionId,
    String examCategory,
    String subject,
    String topic,
    String? subTopic,
    String questionText,
    List<String>? questionImageUrls,
    List<String>? questionLatex,
    List<QuestionOption> options,
    List<String> correctAnswer,
    QuestionType questionType,
    String explanationText,
    String? explanationVideoUrl,
    List<String>? explanationSteps,
    List<String>? references,
    double ardeProbability,
    int ardeFrequency,
    List<int>? ardeAppearanceYears,
    String? ardeNotes,
    String? ardeContext,
    DifficultyLevel difficulty,
    int estimatedTimeSeconds,
    List<String> tags,
    List<String>? relatedQuestions,
    DateTime createdAt,
    DateTime updatedAt,
    String createdBy,
    String? createdByName,
    bool? isActive,
    int? version,
    String? status,
    @JsonKey(name: 'approval_status') String approvalStatus,
    @JsonKey(name: 'reviewer_id') String? reviewerId,
    @JsonKey(name: 'reviewer_name') String? reviewerName,
    @JsonKey(name: 'review_comments') String? reviewComments,
    @JsonKey(name: 'submitted_at') DateTime submittedAt,
    @JsonKey(name: 'reviewed_at') DateTime? reviewedAt,
    @JsonKey(name: 'approved_at') DateTime? approvedAt,
    bool isBookmarked,
    String? userNotes,
    QuestionAttempt? lastAttempt,
  });

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
    Object? questionImageUrls = freezed,
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
    Object? tags = null,
    Object? relatedQuestions = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? createdBy = null,
    Object? createdByName = freezed,
    Object? isActive = freezed,
    Object? version = freezed,
    Object? status = freezed,
    Object? approvalStatus = null,
    Object? reviewerId = freezed,
    Object? reviewerName = freezed,
    Object? reviewComments = freezed,
    Object? submittedAt = null,
    Object? reviewedAt = freezed,
    Object? approvedAt = freezed,
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
                  as int,
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
        questionImageUrls: freezed == questionImageUrls
            ? _value._questionImageUrls
            : questionImageUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        questionLatex: freezed == questionLatex
            ? _value._questionLatex
            : questionLatex // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
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
                  as double,
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
        createdByName: freezed == createdByName
            ? _value.createdByName
            : createdByName // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        approvalStatus: null == approvalStatus
            ? _value.approvalStatus
            : approvalStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        reviewerId: freezed == reviewerId
            ? _value.reviewerId
            : reviewerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        reviewerName: freezed == reviewerName
            ? _value.reviewerName
            : reviewerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        reviewComments: freezed == reviewComments
            ? _value.reviewComments
            : reviewComments // ignore: cast_nullable_to_non_nullable
                  as String?,
        submittedAt: null == submittedAt
            ? _value.submittedAt
            : submittedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        reviewedAt: freezed == reviewedAt
            ? _value.reviewedAt
            : reviewedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        approvedAt: freezed == approvedAt
            ? _value.approvedAt
            : approvedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
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

class _$QuestionImpl extends _Question {
  const _$QuestionImpl({
    required this.id,
    required this.questionId,
    required this.examCategory,
    required this.subject,
    required this.topic,
    this.subTopic,
    required this.questionText,
    final List<String>? questionImageUrls,
    final List<String>? questionLatex,
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
    final List<String> tags = const [],
    final List<String>? relatedQuestions,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    this.createdByName,
    this.isActive = true,
    this.version = 1,
    this.status,
    @JsonKey(name: 'approval_status') this.approvalStatus = 'pending',
    @JsonKey(name: 'reviewer_id') this.reviewerId,
    @JsonKey(name: 'reviewer_name') this.reviewerName,
    @JsonKey(name: 'review_comments') this.reviewComments,
    @JsonKey(name: 'submitted_at') required this.submittedAt,
    @JsonKey(name: 'reviewed_at') this.reviewedAt,
    @JsonKey(name: 'approved_at') this.approvedAt,
    this.isBookmarked = false,
    this.userNotes,
    this.lastAttempt,
  }) : _questionImageUrls = questionImageUrls,
       _questionLatex = questionLatex,
       _options = options,
       _correctAnswer = correctAnswer,
       _explanationSteps = explanationSteps,
       _references = references,
       _ardeAppearanceYears = ardeAppearanceYears,
       _tags = tags,
       _relatedQuestions = relatedQuestions,
       super._();

  // Identity & Metadata
  @override
  final String id;
  @override
  final int questionId;
  // Changed from String to int
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
  final List<String>? _questionImageUrls;
  @override
  List<String>? get questionImageUrls {
    final value = _questionImageUrls;
    if (value == null) return null;
    if (_questionImageUrls is EqualUnmodifiableListView)
      return _questionImageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // Multiple image URLs
  final List<String>? _questionLatex;
  // Multiple image URLs
  @override
  List<String>? get questionLatex {
    final value = _questionLatex;
    if (value == null) return null;
    if (_questionLatex is EqualUnmodifiableListView) return _questionLatex;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // Multiple LaTeX expressions
  // Options & Answer
  final List<QuestionOption> _options;
  // Multiple LaTeX expressions
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
  final double ardeProbability;
  // Changed from ArdeLevel enum to double
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
  // Performance stats removed - now calculated from question_attempts collection
  // Search & Discovery
  final List<String> _tags;
  // Performance stats removed - now calculated from question_attempts collection
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
  final String? createdByName;
  @override
  @JsonKey()
  final bool? isActive;
  @override
  @JsonKey()
  final int? version;
  @override
  final String? status;
  // Approval workflow fields
  @override
  @JsonKey(name: 'approval_status')
  final String approvalStatus;
  @override
  @JsonKey(name: 'reviewer_id')
  final String? reviewerId;
  @override
  @JsonKey(name: 'reviewer_name')
  final String? reviewerName;
  @override
  @JsonKey(name: 'review_comments')
  final String? reviewComments;
  @override
  @JsonKey(name: 'submitted_at')
  final DateTime submittedAt;
  @override
  @JsonKey(name: 'reviewed_at')
  final DateTime? reviewedAt;
  @override
  @JsonKey(name: 'approved_at')
  final DateTime? approvedAt;
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
    return 'Question(id: $id, questionId: $questionId, examCategory: $examCategory, subject: $subject, topic: $topic, subTopic: $subTopic, questionText: $questionText, questionImageUrls: $questionImageUrls, questionLatex: $questionLatex, options: $options, correctAnswer: $correctAnswer, questionType: $questionType, explanationText: $explanationText, explanationVideoUrl: $explanationVideoUrl, explanationSteps: $explanationSteps, references: $references, ardeProbability: $ardeProbability, ardeFrequency: $ardeFrequency, ardeAppearanceYears: $ardeAppearanceYears, ardeNotes: $ardeNotes, ardeContext: $ardeContext, difficulty: $difficulty, estimatedTimeSeconds: $estimatedTimeSeconds, tags: $tags, relatedQuestions: $relatedQuestions, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, createdByName: $createdByName, isActive: $isActive, version: $version, status: $status, approvalStatus: $approvalStatus, reviewerId: $reviewerId, reviewerName: $reviewerName, reviewComments: $reviewComments, submittedAt: $submittedAt, reviewedAt: $reviewedAt, approvedAt: $approvedAt, isBookmarked: $isBookmarked, userNotes: $userNotes, lastAttempt: $lastAttempt)';
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
            const DeepCollectionEquality().equals(
              other._questionImageUrls,
              _questionImageUrls,
            ) &&
            const DeepCollectionEquality().equals(
              other._questionLatex,
              _questionLatex,
            ) &&
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
            (identical(other.createdByName, createdByName) ||
                other.createdByName == createdByName) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.approvalStatus, approvalStatus) ||
                other.approvalStatus == approvalStatus) &&
            (identical(other.reviewerId, reviewerId) ||
                other.reviewerId == reviewerId) &&
            (identical(other.reviewerName, reviewerName) ||
                other.reviewerName == reviewerName) &&
            (identical(other.reviewComments, reviewComments) ||
                other.reviewComments == reviewComments) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.reviewedAt, reviewedAt) ||
                other.reviewedAt == reviewedAt) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.isBookmarked, isBookmarked) ||
                other.isBookmarked == isBookmarked) &&
            (identical(other.userNotes, userNotes) ||
                other.userNotes == userNotes) &&
            (identical(other.lastAttempt, lastAttempt) ||
                other.lastAttempt == lastAttempt));
  }

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
    const DeepCollectionEquality().hash(_questionImageUrls),
    const DeepCollectionEquality().hash(_questionLatex),
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
    const DeepCollectionEquality().hash(_tags),
    const DeepCollectionEquality().hash(_relatedQuestions),
    createdAt,
    updatedAt,
    createdBy,
    createdByName,
    isActive,
    version,
    status,
    approvalStatus,
    reviewerId,
    reviewerName,
    reviewComments,
    submittedAt,
    reviewedAt,
    approvedAt,
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
}

abstract class _Question extends Question {
  const factory _Question({
    required final String id,
    required final int questionId,
    required final String examCategory,
    required final String subject,
    required final String topic,
    final String? subTopic,
    required final String questionText,
    final List<String>? questionImageUrls,
    final List<String>? questionLatex,
    required final List<QuestionOption> options,
    required final List<String> correctAnswer,
    final QuestionType questionType,
    required final String explanationText,
    final String? explanationVideoUrl,
    final List<String>? explanationSteps,
    final List<String>? references,
    required final double ardeProbability,
    final int ardeFrequency,
    final List<int>? ardeAppearanceYears,
    final String? ardeNotes,
    final String? ardeContext,
    required final DifficultyLevel difficulty,
    final int estimatedTimeSeconds,
    final List<String> tags,
    final List<String>? relatedQuestions,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    required final String createdBy,
    final String? createdByName,
    final bool? isActive,
    final int? version,
    final String? status,
    @JsonKey(name: 'approval_status') final String approvalStatus,
    @JsonKey(name: 'reviewer_id') final String? reviewerId,
    @JsonKey(name: 'reviewer_name') final String? reviewerName,
    @JsonKey(name: 'review_comments') final String? reviewComments,
    @JsonKey(name: 'submitted_at') required final DateTime submittedAt,
    @JsonKey(name: 'reviewed_at') final DateTime? reviewedAt,
    @JsonKey(name: 'approved_at') final DateTime? approvedAt,
    final bool isBookmarked,
    final String? userNotes,
    final QuestionAttempt? lastAttempt,
  }) = _$QuestionImpl;
  const _Question._() : super._();

  // Identity & Metadata
  @override
  String get id;
  @override
  int get questionId; // Changed from String to int
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
  List<String>? get questionImageUrls; // Multiple image URLs
  @override
  List<String>? get questionLatex; // Multiple LaTeX expressions
  // Options & Answer
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
  double get ardeProbability; // Changed from ArdeLevel enum to double
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
  int get estimatedTimeSeconds; // Performance stats removed - now calculated from question_attempts collection
  // Search & Discovery
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
  String? get createdByName;
  @override
  bool? get isActive;
  @override
  int? get version;
  @override
  String? get status; // Approval workflow fields
  @override
  @JsonKey(name: 'approval_status')
  String get approvalStatus;
  @override
  @JsonKey(name: 'reviewer_id')
  String? get reviewerId;
  @override
  @JsonKey(name: 'reviewer_name')
  String? get reviewerName;
  @override
  @JsonKey(name: 'review_comments')
  String? get reviewComments;
  @override
  @JsonKey(name: 'submitted_at')
  DateTime get submittedAt;
  @override
  @JsonKey(name: 'reviewed_at')
  DateTime? get reviewedAt;
  @override
  @JsonKey(name: 'approved_at')
  DateTime? get approvedAt; // User-specific (populated at runtime)
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
