// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quick_filter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuickFilterState _$QuickFilterStateFromJson(Map<String, dynamic> json) {
  return _QuickFilterState.fromJson(json);
}

/// @nodoc
mixin _$QuickFilterState {
  /// Search query for question ID
  String? get searchQuery => throw _privateConstructorUsedError;

  /// Selected sort option
  QuickSortOption get sortOption => throw _privateConstructorUsedError;

  /// Selected difficulty levels
  Set<DifficultyLevel> get selectedDifficulties =>
      throw _privateConstructorUsedError;

  /// Selected question types
  Set<QuestionType> get selectedQuestionTypes =>
      throw _privateConstructorUsedError;

  /// Selected exam categories
  Set<String> get selectedExamCategories => throw _privateConstructorUsedError;

  /// Selected subjects
  Set<String> get selectedSubjects => throw _privateConstructorUsedError;

  /// Serializes this QuickFilterState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuickFilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuickFilterStateCopyWith<QuickFilterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickFilterStateCopyWith<$Res> {
  factory $QuickFilterStateCopyWith(
    QuickFilterState value,
    $Res Function(QuickFilterState) then,
  ) = _$QuickFilterStateCopyWithImpl<$Res, QuickFilterState>;
  @useResult
  $Res call({
    String? searchQuery,
    QuickSortOption sortOption,
    Set<DifficultyLevel> selectedDifficulties,
    Set<QuestionType> selectedQuestionTypes,
    Set<String> selectedExamCategories,
    Set<String> selectedSubjects,
  });
}

/// @nodoc
class _$QuickFilterStateCopyWithImpl<$Res, $Val extends QuickFilterState>
    implements $QuickFilterStateCopyWith<$Res> {
  _$QuickFilterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuickFilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = freezed,
    Object? sortOption = null,
    Object? selectedDifficulties = null,
    Object? selectedQuestionTypes = null,
    Object? selectedExamCategories = null,
    Object? selectedSubjects = null,
  }) {
    return _then(
      _value.copyWith(
            searchQuery: freezed == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String?,
            sortOption: null == sortOption
                ? _value.sortOption
                : sortOption // ignore: cast_nullable_to_non_nullable
                      as QuickSortOption,
            selectedDifficulties: null == selectedDifficulties
                ? _value.selectedDifficulties
                : selectedDifficulties // ignore: cast_nullable_to_non_nullable
                      as Set<DifficultyLevel>,
            selectedQuestionTypes: null == selectedQuestionTypes
                ? _value.selectedQuestionTypes
                : selectedQuestionTypes // ignore: cast_nullable_to_non_nullable
                      as Set<QuestionType>,
            selectedExamCategories: null == selectedExamCategories
                ? _value.selectedExamCategories
                : selectedExamCategories // ignore: cast_nullable_to_non_nullable
                      as Set<String>,
            selectedSubjects: null == selectedSubjects
                ? _value.selectedSubjects
                : selectedSubjects // ignore: cast_nullable_to_non_nullable
                      as Set<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuickFilterStateImplCopyWith<$Res>
    implements $QuickFilterStateCopyWith<$Res> {
  factory _$$QuickFilterStateImplCopyWith(
    _$QuickFilterStateImpl value,
    $Res Function(_$QuickFilterStateImpl) then,
  ) = __$$QuickFilterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? searchQuery,
    QuickSortOption sortOption,
    Set<DifficultyLevel> selectedDifficulties,
    Set<QuestionType> selectedQuestionTypes,
    Set<String> selectedExamCategories,
    Set<String> selectedSubjects,
  });
}

/// @nodoc
class __$$QuickFilterStateImplCopyWithImpl<$Res>
    extends _$QuickFilterStateCopyWithImpl<$Res, _$QuickFilterStateImpl>
    implements _$$QuickFilterStateImplCopyWith<$Res> {
  __$$QuickFilterStateImplCopyWithImpl(
    _$QuickFilterStateImpl _value,
    $Res Function(_$QuickFilterStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuickFilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = freezed,
    Object? sortOption = null,
    Object? selectedDifficulties = null,
    Object? selectedQuestionTypes = null,
    Object? selectedExamCategories = null,
    Object? selectedSubjects = null,
  }) {
    return _then(
      _$QuickFilterStateImpl(
        searchQuery: freezed == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String?,
        sortOption: null == sortOption
            ? _value.sortOption
            : sortOption // ignore: cast_nullable_to_non_nullable
                  as QuickSortOption,
        selectedDifficulties: null == selectedDifficulties
            ? _value._selectedDifficulties
            : selectedDifficulties // ignore: cast_nullable_to_non_nullable
                  as Set<DifficultyLevel>,
        selectedQuestionTypes: null == selectedQuestionTypes
            ? _value._selectedQuestionTypes
            : selectedQuestionTypes // ignore: cast_nullable_to_non_nullable
                  as Set<QuestionType>,
        selectedExamCategories: null == selectedExamCategories
            ? _value._selectedExamCategories
            : selectedExamCategories // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        selectedSubjects: null == selectedSubjects
            ? _value._selectedSubjects
            : selectedSubjects // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuickFilterStateImpl extends _QuickFilterState {
  const _$QuickFilterStateImpl({
    this.searchQuery,
    this.sortOption = QuickSortOption.newestFirst,
    final Set<DifficultyLevel> selectedDifficulties = const <DifficultyLevel>{},
    final Set<QuestionType> selectedQuestionTypes = const <QuestionType>{},
    final Set<String> selectedExamCategories = const <String>{},
    final Set<String> selectedSubjects = const <String>{},
  }) : _selectedDifficulties = selectedDifficulties,
       _selectedQuestionTypes = selectedQuestionTypes,
       _selectedExamCategories = selectedExamCategories,
       _selectedSubjects = selectedSubjects,
       super._();

  factory _$QuickFilterStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuickFilterStateImplFromJson(json);

  /// Search query for question ID
  @override
  final String? searchQuery;

  /// Selected sort option
  @override
  @JsonKey()
  final QuickSortOption sortOption;

  /// Selected difficulty levels
  final Set<DifficultyLevel> _selectedDifficulties;

  /// Selected difficulty levels
  @override
  @JsonKey()
  Set<DifficultyLevel> get selectedDifficulties {
    if (_selectedDifficulties is EqualUnmodifiableSetView)
      return _selectedDifficulties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedDifficulties);
  }

  /// Selected question types
  final Set<QuestionType> _selectedQuestionTypes;

  /// Selected question types
  @override
  @JsonKey()
  Set<QuestionType> get selectedQuestionTypes {
    if (_selectedQuestionTypes is EqualUnmodifiableSetView)
      return _selectedQuestionTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedQuestionTypes);
  }

  /// Selected exam categories
  final Set<String> _selectedExamCategories;

  /// Selected exam categories
  @override
  @JsonKey()
  Set<String> get selectedExamCategories {
    if (_selectedExamCategories is EqualUnmodifiableSetView)
      return _selectedExamCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedExamCategories);
  }

  /// Selected subjects
  final Set<String> _selectedSubjects;

  /// Selected subjects
  @override
  @JsonKey()
  Set<String> get selectedSubjects {
    if (_selectedSubjects is EqualUnmodifiableSetView) return _selectedSubjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedSubjects);
  }

  @override
  String toString() {
    return 'QuickFilterState(searchQuery: $searchQuery, sortOption: $sortOption, selectedDifficulties: $selectedDifficulties, selectedQuestionTypes: $selectedQuestionTypes, selectedExamCategories: $selectedExamCategories, selectedSubjects: $selectedSubjects)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickFilterStateImpl &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.sortOption, sortOption) ||
                other.sortOption == sortOption) &&
            const DeepCollectionEquality().equals(
              other._selectedDifficulties,
              _selectedDifficulties,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedQuestionTypes,
              _selectedQuestionTypes,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedExamCategories,
              _selectedExamCategories,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedSubjects,
              _selectedSubjects,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    searchQuery,
    sortOption,
    const DeepCollectionEquality().hash(_selectedDifficulties),
    const DeepCollectionEquality().hash(_selectedQuestionTypes),
    const DeepCollectionEquality().hash(_selectedExamCategories),
    const DeepCollectionEquality().hash(_selectedSubjects),
  );

  /// Create a copy of QuickFilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickFilterStateImplCopyWith<_$QuickFilterStateImpl> get copyWith =>
      __$$QuickFilterStateImplCopyWithImpl<_$QuickFilterStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuickFilterStateImplToJson(this);
  }
}

abstract class _QuickFilterState extends QuickFilterState {
  const factory _QuickFilterState({
    final String? searchQuery,
    final QuickSortOption sortOption,
    final Set<DifficultyLevel> selectedDifficulties,
    final Set<QuestionType> selectedQuestionTypes,
    final Set<String> selectedExamCategories,
    final Set<String> selectedSubjects,
  }) = _$QuickFilterStateImpl;
  const _QuickFilterState._() : super._();

  factory _QuickFilterState.fromJson(Map<String, dynamic> json) =
      _$QuickFilterStateImpl.fromJson;

  /// Search query for question ID
  @override
  String? get searchQuery;

  /// Selected sort option
  @override
  QuickSortOption get sortOption;

  /// Selected difficulty levels
  @override
  Set<DifficultyLevel> get selectedDifficulties;

  /// Selected question types
  @override
  Set<QuestionType> get selectedQuestionTypes;

  /// Selected exam categories
  @override
  Set<String> get selectedExamCategories;

  /// Selected subjects
  @override
  Set<String> get selectedSubjects;

  /// Create a copy of QuickFilterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuickFilterStateImplCopyWith<_$QuickFilterStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
