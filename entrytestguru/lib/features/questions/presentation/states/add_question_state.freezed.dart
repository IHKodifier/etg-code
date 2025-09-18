// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_question_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AddQuestionState {
  String get questionText => throw _privateConstructorUsedError;
  List<String>? get questionImageUrls =>
      throw _privateConstructorUsedError; // Multiple image URLs
  List<String>? get questionLatex =>
      throw _privateConstructorUsedError; // Multiple LaTeX expressions
  List<QuestionOption> get options => throw _privateConstructorUsedError;
  List<String> get correctAnswers => throw _privateConstructorUsedError;
  QuestionType get questionType => throw _privateConstructorUsedError;
  String get examCategory => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get topic => throw _privateConstructorUsedError;
  String? get subTopic => throw _privateConstructorUsedError;
  DifficultyLevel get difficulty => throw _privateConstructorUsedError;
  int get estimatedTimeSeconds => throw _privateConstructorUsedError;
  String? get explanationText => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;

  /// Create a copy of AddQuestionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddQuestionStateCopyWith<AddQuestionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddQuestionStateCopyWith<$Res> {
  factory $AddQuestionStateCopyWith(
    AddQuestionState value,
    $Res Function(AddQuestionState) then,
  ) = _$AddQuestionStateCopyWithImpl<$Res, AddQuestionState>;
  @useResult
  $Res call({
    String questionText,
    List<String>? questionImageUrls,
    List<String>? questionLatex,
    List<QuestionOption> options,
    List<String> correctAnswers,
    QuestionType questionType,
    String examCategory,
    String subject,
    String topic,
    String? subTopic,
    DifficultyLevel difficulty,
    int estimatedTimeSeconds,
    String? explanationText,
    List<String> tags,
    bool isLoading,
    String? errorMessage,
    bool isSuccess,
  });
}

/// @nodoc
class _$AddQuestionStateCopyWithImpl<$Res, $Val extends AddQuestionState>
    implements $AddQuestionStateCopyWith<$Res> {
  _$AddQuestionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddQuestionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionText = null,
    Object? questionImageUrls = freezed,
    Object? questionLatex = freezed,
    Object? options = null,
    Object? correctAnswers = null,
    Object? questionType = null,
    Object? examCategory = null,
    Object? subject = null,
    Object? topic = null,
    Object? subTopic = freezed,
    Object? difficulty = null,
    Object? estimatedTimeSeconds = null,
    Object? explanationText = freezed,
    Object? tags = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? isSuccess = null,
  }) {
    return _then(
      _value.copyWith(
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
            correctAnswers: null == correctAnswers
                ? _value.correctAnswers
                : correctAnswers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            questionType: null == questionType
                ? _value.questionType
                : questionType // ignore: cast_nullable_to_non_nullable
                      as QuestionType,
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
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as DifficultyLevel,
            estimatedTimeSeconds: null == estimatedTimeSeconds
                ? _value.estimatedTimeSeconds
                : estimatedTimeSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            explanationText: freezed == explanationText
                ? _value.explanationText
                : explanationText // ignore: cast_nullable_to_non_nullable
                      as String?,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            isSuccess: null == isSuccess
                ? _value.isSuccess
                : isSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddQuestionStateImplCopyWith<$Res>
    implements $AddQuestionStateCopyWith<$Res> {
  factory _$$AddQuestionStateImplCopyWith(
    _$AddQuestionStateImpl value,
    $Res Function(_$AddQuestionStateImpl) then,
  ) = __$$AddQuestionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String questionText,
    List<String>? questionImageUrls,
    List<String>? questionLatex,
    List<QuestionOption> options,
    List<String> correctAnswers,
    QuestionType questionType,
    String examCategory,
    String subject,
    String topic,
    String? subTopic,
    DifficultyLevel difficulty,
    int estimatedTimeSeconds,
    String? explanationText,
    List<String> tags,
    bool isLoading,
    String? errorMessage,
    bool isSuccess,
  });
}

/// @nodoc
class __$$AddQuestionStateImplCopyWithImpl<$Res>
    extends _$AddQuestionStateCopyWithImpl<$Res, _$AddQuestionStateImpl>
    implements _$$AddQuestionStateImplCopyWith<$Res> {
  __$$AddQuestionStateImplCopyWithImpl(
    _$AddQuestionStateImpl _value,
    $Res Function(_$AddQuestionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddQuestionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionText = null,
    Object? questionImageUrls = freezed,
    Object? questionLatex = freezed,
    Object? options = null,
    Object? correctAnswers = null,
    Object? questionType = null,
    Object? examCategory = null,
    Object? subject = null,
    Object? topic = null,
    Object? subTopic = freezed,
    Object? difficulty = null,
    Object? estimatedTimeSeconds = null,
    Object? explanationText = freezed,
    Object? tags = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? isSuccess = null,
  }) {
    return _then(
      _$AddQuestionStateImpl(
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
        correctAnswers: null == correctAnswers
            ? _value._correctAnswers
            : correctAnswers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        questionType: null == questionType
            ? _value.questionType
            : questionType // ignore: cast_nullable_to_non_nullable
                  as QuestionType,
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
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as DifficultyLevel,
        estimatedTimeSeconds: null == estimatedTimeSeconds
            ? _value.estimatedTimeSeconds
            : estimatedTimeSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        explanationText: freezed == explanationText
            ? _value.explanationText
            : explanationText // ignore: cast_nullable_to_non_nullable
                  as String?,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        isSuccess: null == isSuccess
            ? _value.isSuccess
            : isSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$AddQuestionStateImpl extends _AddQuestionState {
  const _$AddQuestionStateImpl({
    this.questionText = '',
    final List<String>? questionImageUrls,
    final List<String>? questionLatex,
    final List<QuestionOption> options = const [],
    final List<String> correctAnswers = const [],
    this.questionType = QuestionType.singleChoice,
    this.examCategory = '',
    this.subject = '',
    this.topic = '',
    this.subTopic,
    this.difficulty = DifficultyLevel.medium,
    this.estimatedTimeSeconds = 60,
    this.explanationText,
    final List<String> tags = const [],
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  }) : _questionImageUrls = questionImageUrls,
       _questionLatex = questionLatex,
       _options = options,
       _correctAnswers = correctAnswers,
       _tags = tags,
       super._();

  @override
  @JsonKey()
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
  final List<QuestionOption> _options;
  // Multiple LaTeX expressions
  @override
  @JsonKey()
  List<QuestionOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  final List<String> _correctAnswers;
  @override
  @JsonKey()
  List<String> get correctAnswers {
    if (_correctAnswers is EqualUnmodifiableListView) return _correctAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_correctAnswers);
  }

  @override
  @JsonKey()
  final QuestionType questionType;
  @override
  @JsonKey()
  final String examCategory;
  @override
  @JsonKey()
  final String subject;
  @override
  @JsonKey()
  final String topic;
  @override
  final String? subTopic;
  @override
  @JsonKey()
  final DifficultyLevel difficulty;
  @override
  @JsonKey()
  final int estimatedTimeSeconds;
  @override
  final String? explanationText;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isSuccess;

  @override
  String toString() {
    return 'AddQuestionState(questionText: $questionText, questionImageUrls: $questionImageUrls, questionLatex: $questionLatex, options: $options, correctAnswers: $correctAnswers, questionType: $questionType, examCategory: $examCategory, subject: $subject, topic: $topic, subTopic: $subTopic, difficulty: $difficulty, estimatedTimeSeconds: $estimatedTimeSeconds, explanationText: $explanationText, tags: $tags, isLoading: $isLoading, errorMessage: $errorMessage, isSuccess: $isSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddQuestionStateImpl &&
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
              other._correctAnswers,
              _correctAnswers,
            ) &&
            (identical(other.questionType, questionType) ||
                other.questionType == questionType) &&
            (identical(other.examCategory, examCategory) ||
                other.examCategory == examCategory) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.subTopic, subTopic) ||
                other.subTopic == subTopic) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.estimatedTimeSeconds, estimatedTimeSeconds) ||
                other.estimatedTimeSeconds == estimatedTimeSeconds) &&
            (identical(other.explanationText, explanationText) ||
                other.explanationText == explanationText) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    questionText,
    const DeepCollectionEquality().hash(_questionImageUrls),
    const DeepCollectionEquality().hash(_questionLatex),
    const DeepCollectionEquality().hash(_options),
    const DeepCollectionEquality().hash(_correctAnswers),
    questionType,
    examCategory,
    subject,
    topic,
    subTopic,
    difficulty,
    estimatedTimeSeconds,
    explanationText,
    const DeepCollectionEquality().hash(_tags),
    isLoading,
    errorMessage,
    isSuccess,
  );

  /// Create a copy of AddQuestionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddQuestionStateImplCopyWith<_$AddQuestionStateImpl> get copyWith =>
      __$$AddQuestionStateImplCopyWithImpl<_$AddQuestionStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AddQuestionState extends AddQuestionState {
  const factory _AddQuestionState({
    final String questionText,
    final List<String>? questionImageUrls,
    final List<String>? questionLatex,
    final List<QuestionOption> options,
    final List<String> correctAnswers,
    final QuestionType questionType,
    final String examCategory,
    final String subject,
    final String topic,
    final String? subTopic,
    final DifficultyLevel difficulty,
    final int estimatedTimeSeconds,
    final String? explanationText,
    final List<String> tags,
    final bool isLoading,
    final String? errorMessage,
    final bool isSuccess,
  }) = _$AddQuestionStateImpl;
  const _AddQuestionState._() : super._();

  @override
  String get questionText;
  @override
  List<String>? get questionImageUrls; // Multiple image URLs
  @override
  List<String>? get questionLatex; // Multiple LaTeX expressions
  @override
  List<QuestionOption> get options;
  @override
  List<String> get correctAnswers;
  @override
  QuestionType get questionType;
  @override
  String get examCategory;
  @override
  String get subject;
  @override
  String get topic;
  @override
  String? get subTopic;
  @override
  DifficultyLevel get difficulty;
  @override
  int get estimatedTimeSeconds;
  @override
  String? get explanationText;
  @override
  List<String> get tags;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  bool get isSuccess;

  /// Create a copy of AddQuestionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddQuestionStateImplCopyWith<_$AddQuestionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
