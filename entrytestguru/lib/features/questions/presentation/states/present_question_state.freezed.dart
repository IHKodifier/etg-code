// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'present_question_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PresentQuestionState {
  Question? get currentQuestion => throw _privateConstructorUsedError;
  List<String> get selectedAnswers => throw _privateConstructorUsedError;
  bool get showExplanation => throw _privateConstructorUsedError;
  bool get isAnswered => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  QuestionAttempt? get lastAttempt => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  QuestionFilter? get currentFilter => throw _privateConstructorUsedError;
  int get currentQuestionIndex => throw _privateConstructorUsedError;
  List<Question> get questionQueue => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;

  /// Create a copy of PresentQuestionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PresentQuestionStateCopyWith<PresentQuestionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresentQuestionStateCopyWith<$Res> {
  factory $PresentQuestionStateCopyWith(
    PresentQuestionState value,
    $Res Function(PresentQuestionState) then,
  ) = _$PresentQuestionStateCopyWithImpl<$Res, PresentQuestionState>;
  @useResult
  $Res call({
    Question? currentQuestion,
    List<String> selectedAnswers,
    bool showExplanation,
    bool isAnswered,
    bool isCorrect,
    QuestionAttempt? lastAttempt,
    bool isLoading,
    bool isLoadingMore,
    String? errorMessage,
    QuestionFilter? currentFilter,
    int currentQuestionIndex,
    List<Question> questionQueue,
    bool hasMore,
    int totalCount,
  });

  $QuestionCopyWith<$Res>? get currentQuestion;
  $QuestionAttemptCopyWith<$Res>? get lastAttempt;
  $QuestionFilterCopyWith<$Res>? get currentFilter;
}

/// @nodoc
class _$PresentQuestionStateCopyWithImpl<
  $Res,
  $Val extends PresentQuestionState
>
    implements $PresentQuestionStateCopyWith<$Res> {
  _$PresentQuestionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PresentQuestionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentQuestion = freezed,
    Object? selectedAnswers = null,
    Object? showExplanation = null,
    Object? isAnswered = null,
    Object? isCorrect = null,
    Object? lastAttempt = freezed,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? errorMessage = freezed,
    Object? currentFilter = freezed,
    Object? currentQuestionIndex = null,
    Object? questionQueue = null,
    Object? hasMore = null,
    Object? totalCount = null,
  }) {
    return _then(
      _value.copyWith(
            currentQuestion: freezed == currentQuestion
                ? _value.currentQuestion
                : currentQuestion // ignore: cast_nullable_to_non_nullable
                      as Question?,
            selectedAnswers: null == selectedAnswers
                ? _value.selectedAnswers
                : selectedAnswers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            showExplanation: null == showExplanation
                ? _value.showExplanation
                : showExplanation // ignore: cast_nullable_to_non_nullable
                      as bool,
            isAnswered: null == isAnswered
                ? _value.isAnswered
                : isAnswered // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCorrect: null == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastAttempt: freezed == lastAttempt
                ? _value.lastAttempt
                : lastAttempt // ignore: cast_nullable_to_non_nullable
                      as QuestionAttempt?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentFilter: freezed == currentFilter
                ? _value.currentFilter
                : currentFilter // ignore: cast_nullable_to_non_nullable
                      as QuestionFilter?,
            currentQuestionIndex: null == currentQuestionIndex
                ? _value.currentQuestionIndex
                : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            questionQueue: null == questionQueue
                ? _value.questionQueue
                : questionQueue // ignore: cast_nullable_to_non_nullable
                      as List<Question>,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of PresentQuestionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuestionCopyWith<$Res>? get currentQuestion {
    if (_value.currentQuestion == null) {
      return null;
    }

    return $QuestionCopyWith<$Res>(_value.currentQuestion!, (value) {
      return _then(_value.copyWith(currentQuestion: value) as $Val);
    });
  }

  /// Create a copy of PresentQuestionState
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

  /// Create a copy of PresentQuestionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuestionFilterCopyWith<$Res>? get currentFilter {
    if (_value.currentFilter == null) {
      return null;
    }

    return $QuestionFilterCopyWith<$Res>(_value.currentFilter!, (value) {
      return _then(_value.copyWith(currentFilter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PresentQuestionStateImplCopyWith<$Res>
    implements $PresentQuestionStateCopyWith<$Res> {
  factory _$$PresentQuestionStateImplCopyWith(
    _$PresentQuestionStateImpl value,
    $Res Function(_$PresentQuestionStateImpl) then,
  ) = __$$PresentQuestionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Question? currentQuestion,
    List<String> selectedAnswers,
    bool showExplanation,
    bool isAnswered,
    bool isCorrect,
    QuestionAttempt? lastAttempt,
    bool isLoading,
    bool isLoadingMore,
    String? errorMessage,
    QuestionFilter? currentFilter,
    int currentQuestionIndex,
    List<Question> questionQueue,
    bool hasMore,
    int totalCount,
  });

  @override
  $QuestionCopyWith<$Res>? get currentQuestion;
  @override
  $QuestionAttemptCopyWith<$Res>? get lastAttempt;
  @override
  $QuestionFilterCopyWith<$Res>? get currentFilter;
}

/// @nodoc
class __$$PresentQuestionStateImplCopyWithImpl<$Res>
    extends _$PresentQuestionStateCopyWithImpl<$Res, _$PresentQuestionStateImpl>
    implements _$$PresentQuestionStateImplCopyWith<$Res> {
  __$$PresentQuestionStateImplCopyWithImpl(
    _$PresentQuestionStateImpl _value,
    $Res Function(_$PresentQuestionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PresentQuestionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentQuestion = freezed,
    Object? selectedAnswers = null,
    Object? showExplanation = null,
    Object? isAnswered = null,
    Object? isCorrect = null,
    Object? lastAttempt = freezed,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? errorMessage = freezed,
    Object? currentFilter = freezed,
    Object? currentQuestionIndex = null,
    Object? questionQueue = null,
    Object? hasMore = null,
    Object? totalCount = null,
  }) {
    return _then(
      _$PresentQuestionStateImpl(
        currentQuestion: freezed == currentQuestion
            ? _value.currentQuestion
            : currentQuestion // ignore: cast_nullable_to_non_nullable
                  as Question?,
        selectedAnswers: null == selectedAnswers
            ? _value._selectedAnswers
            : selectedAnswers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        showExplanation: null == showExplanation
            ? _value.showExplanation
            : showExplanation // ignore: cast_nullable_to_non_nullable
                  as bool,
        isAnswered: null == isAnswered
            ? _value.isAnswered
            : isAnswered // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCorrect: null == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastAttempt: freezed == lastAttempt
            ? _value.lastAttempt
            : lastAttempt // ignore: cast_nullable_to_non_nullable
                  as QuestionAttempt?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentFilter: freezed == currentFilter
            ? _value.currentFilter
            : currentFilter // ignore: cast_nullable_to_non_nullable
                  as QuestionFilter?,
        currentQuestionIndex: null == currentQuestionIndex
            ? _value.currentQuestionIndex
            : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        questionQueue: null == questionQueue
            ? _value._questionQueue
            : questionQueue // ignore: cast_nullable_to_non_nullable
                  as List<Question>,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$PresentQuestionStateImpl extends _PresentQuestionState {
  const _$PresentQuestionStateImpl({
    this.currentQuestion,
    final List<String> selectedAnswers = const [],
    this.showExplanation = false,
    this.isAnswered = false,
    this.isCorrect = false,
    this.lastAttempt,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.currentFilter,
    this.currentQuestionIndex = 0,
    final List<Question> questionQueue = const [],
    this.hasMore = true,
    this.totalCount = 0,
  }) : _selectedAnswers = selectedAnswers,
       _questionQueue = questionQueue,
       super._();

  @override
  final Question? currentQuestion;
  final List<String> _selectedAnswers;
  @override
  @JsonKey()
  List<String> get selectedAnswers {
    if (_selectedAnswers is EqualUnmodifiableListView) return _selectedAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedAnswers);
  }

  @override
  @JsonKey()
  final bool showExplanation;
  @override
  @JsonKey()
  final bool isAnswered;
  @override
  @JsonKey()
  final bool isCorrect;
  @override
  final QuestionAttempt? lastAttempt;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  final String? errorMessage;
  @override
  final QuestionFilter? currentFilter;
  @override
  @JsonKey()
  final int currentQuestionIndex;
  final List<Question> _questionQueue;
  @override
  @JsonKey()
  List<Question> get questionQueue {
    if (_questionQueue is EqualUnmodifiableListView) return _questionQueue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questionQueue);
  }

  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final int totalCount;

  @override
  String toString() {
    return 'PresentQuestionState(currentQuestion: $currentQuestion, selectedAnswers: $selectedAnswers, showExplanation: $showExplanation, isAnswered: $isAnswered, isCorrect: $isCorrect, lastAttempt: $lastAttempt, isLoading: $isLoading, isLoadingMore: $isLoadingMore, errorMessage: $errorMessage, currentFilter: $currentFilter, currentQuestionIndex: $currentQuestionIndex, questionQueue: $questionQueue, hasMore: $hasMore, totalCount: $totalCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresentQuestionStateImpl &&
            (identical(other.currentQuestion, currentQuestion) ||
                other.currentQuestion == currentQuestion) &&
            const DeepCollectionEquality().equals(
              other._selectedAnswers,
              _selectedAnswers,
            ) &&
            (identical(other.showExplanation, showExplanation) ||
                other.showExplanation == showExplanation) &&
            (identical(other.isAnswered, isAnswered) ||
                other.isAnswered == isAnswered) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.lastAttempt, lastAttempt) ||
                other.lastAttempt == lastAttempt) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.currentFilter, currentFilter) ||
                other.currentFilter == currentFilter) &&
            (identical(other.currentQuestionIndex, currentQuestionIndex) ||
                other.currentQuestionIndex == currentQuestionIndex) &&
            const DeepCollectionEquality().equals(
              other._questionQueue,
              _questionQueue,
            ) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentQuestion,
    const DeepCollectionEquality().hash(_selectedAnswers),
    showExplanation,
    isAnswered,
    isCorrect,
    lastAttempt,
    isLoading,
    isLoadingMore,
    errorMessage,
    currentFilter,
    currentQuestionIndex,
    const DeepCollectionEquality().hash(_questionQueue),
    hasMore,
    totalCount,
  );

  /// Create a copy of PresentQuestionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PresentQuestionStateImplCopyWith<_$PresentQuestionStateImpl>
  get copyWith =>
      __$$PresentQuestionStateImplCopyWithImpl<_$PresentQuestionStateImpl>(
        this,
        _$identity,
      );
}

abstract class _PresentQuestionState extends PresentQuestionState {
  const factory _PresentQuestionState({
    final Question? currentQuestion,
    final List<String> selectedAnswers,
    final bool showExplanation,
    final bool isAnswered,
    final bool isCorrect,
    final QuestionAttempt? lastAttempt,
    final bool isLoading,
    final bool isLoadingMore,
    final String? errorMessage,
    final QuestionFilter? currentFilter,
    final int currentQuestionIndex,
    final List<Question> questionQueue,
    final bool hasMore,
    final int totalCount,
  }) = _$PresentQuestionStateImpl;
  const _PresentQuestionState._() : super._();

  @override
  Question? get currentQuestion;
  @override
  List<String> get selectedAnswers;
  @override
  bool get showExplanation;
  @override
  bool get isAnswered;
  @override
  bool get isCorrect;
  @override
  QuestionAttempt? get lastAttempt;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  String? get errorMessage;
  @override
  QuestionFilter? get currentFilter;
  @override
  int get currentQuestionIndex;
  @override
  List<Question> get questionQueue;
  @override
  bool get hasMore;
  @override
  int get totalCount;

  /// Create a copy of PresentQuestionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PresentQuestionStateImplCopyWith<_$PresentQuestionStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
