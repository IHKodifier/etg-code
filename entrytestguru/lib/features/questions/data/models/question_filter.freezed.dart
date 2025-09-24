// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuestionFilter _$QuestionFilterFromJson(Map<String, dynamic> json) {
  return _QuestionFilter.fromJson(json);
}

/// @nodoc
mixin _$QuestionFilter {
  // Basic Filters
  List<String>? get examCategories => throw _privateConstructorUsedError;
  List<String>? get subjects => throw _privateConstructorUsedError;
  List<String>? get topics => throw _privateConstructorUsedError;
  List<DifficultyLevel>? get difficulties => throw _privateConstructorUsedError;
  List<String>? get questionTypes => throw _privateConstructorUsedError;
  List<ArdeLevel>? get ardeProbabilities =>
      throw _privateConstructorUsedError; // Advanced Filters
  int? get minArdeFrequency => throw _privateConstructorUsedError;
  DateTime? get minCreatedDate => throw _privateConstructorUsedError;
  DateTime? get maxCreatedDate =>
      throw _privateConstructorUsedError; // Performance-based Filters
  bool? get showWeakAreas => throw _privateConstructorUsedError;
  bool? get showUnattempted => throw _privateConstructorUsedError;
  bool? get showIncorrect => throw _privateConstructorUsedError;
  bool? get showBookmarked => throw _privateConstructorUsedError; // Search
  String? get searchQuery => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError; // Sorting
  QuestionSortBy? get sortBy => throw _privateConstructorUsedError;
  SortDirection? get sortDirection =>
      throw _privateConstructorUsedError; // Pagination
  int? get limit => throw _privateConstructorUsedError;
  String? get lastDocumentId => throw _privateConstructorUsedError;

  /// Serializes this QuestionFilter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuestionFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionFilterCopyWith<QuestionFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionFilterCopyWith<$Res> {
  factory $QuestionFilterCopyWith(
    QuestionFilter value,
    $Res Function(QuestionFilter) then,
  ) = _$QuestionFilterCopyWithImpl<$Res, QuestionFilter>;
  @useResult
  $Res call({
    List<String>? examCategories,
    List<String>? subjects,
    List<String>? topics,
    List<DifficultyLevel>? difficulties,
    List<String>? questionTypes,
    List<ArdeLevel>? ardeProbabilities,
    int? minArdeFrequency,
    DateTime? minCreatedDate,
    DateTime? maxCreatedDate,
    bool? showWeakAreas,
    bool? showUnattempted,
    bool? showIncorrect,
    bool? showBookmarked,
    String? searchQuery,
    List<String>? tags,
    QuestionSortBy? sortBy,
    SortDirection? sortDirection,
    int? limit,
    String? lastDocumentId,
  });
}

/// @nodoc
class _$QuestionFilterCopyWithImpl<$Res, $Val extends QuestionFilter>
    implements $QuestionFilterCopyWith<$Res> {
  _$QuestionFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? examCategories = freezed,
    Object? subjects = freezed,
    Object? topics = freezed,
    Object? difficulties = freezed,
    Object? questionTypes = freezed,
    Object? ardeProbabilities = freezed,
    Object? minArdeFrequency = freezed,
    Object? minCreatedDate = freezed,
    Object? maxCreatedDate = freezed,
    Object? showWeakAreas = freezed,
    Object? showUnattempted = freezed,
    Object? showIncorrect = freezed,
    Object? showBookmarked = freezed,
    Object? searchQuery = freezed,
    Object? tags = freezed,
    Object? sortBy = freezed,
    Object? sortDirection = freezed,
    Object? limit = freezed,
    Object? lastDocumentId = freezed,
  }) {
    return _then(
      _value.copyWith(
            examCategories: freezed == examCategories
                ? _value.examCategories
                : examCategories // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            subjects: freezed == subjects
                ? _value.subjects
                : subjects // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            topics: freezed == topics
                ? _value.topics
                : topics // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            difficulties: freezed == difficulties
                ? _value.difficulties
                : difficulties // ignore: cast_nullable_to_non_nullable
                      as List<DifficultyLevel>?,
            questionTypes: freezed == questionTypes
                ? _value.questionTypes
                : questionTypes // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            ardeProbabilities: freezed == ardeProbabilities
                ? _value.ardeProbabilities
                : ardeProbabilities // ignore: cast_nullable_to_non_nullable
                      as List<ArdeLevel>?,
            minArdeFrequency: freezed == minArdeFrequency
                ? _value.minArdeFrequency
                : minArdeFrequency // ignore: cast_nullable_to_non_nullable
                      as int?,
            minCreatedDate: freezed == minCreatedDate
                ? _value.minCreatedDate
                : minCreatedDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            maxCreatedDate: freezed == maxCreatedDate
                ? _value.maxCreatedDate
                : maxCreatedDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            showWeakAreas: freezed == showWeakAreas
                ? _value.showWeakAreas
                : showWeakAreas // ignore: cast_nullable_to_non_nullable
                      as bool?,
            showUnattempted: freezed == showUnattempted
                ? _value.showUnattempted
                : showUnattempted // ignore: cast_nullable_to_non_nullable
                      as bool?,
            showIncorrect: freezed == showIncorrect
                ? _value.showIncorrect
                : showIncorrect // ignore: cast_nullable_to_non_nullable
                      as bool?,
            showBookmarked: freezed == showBookmarked
                ? _value.showBookmarked
                : showBookmarked // ignore: cast_nullable_to_non_nullable
                      as bool?,
            searchQuery: freezed == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String?,
            tags: freezed == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            sortBy: freezed == sortBy
                ? _value.sortBy
                : sortBy // ignore: cast_nullable_to_non_nullable
                      as QuestionSortBy?,
            sortDirection: freezed == sortDirection
                ? _value.sortDirection
                : sortDirection // ignore: cast_nullable_to_non_nullable
                      as SortDirection?,
            limit: freezed == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                      as int?,
            lastDocumentId: freezed == lastDocumentId
                ? _value.lastDocumentId
                : lastDocumentId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestionFilterImplCopyWith<$Res>
    implements $QuestionFilterCopyWith<$Res> {
  factory _$$QuestionFilterImplCopyWith(
    _$QuestionFilterImpl value,
    $Res Function(_$QuestionFilterImpl) then,
  ) = __$$QuestionFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<String>? examCategories,
    List<String>? subjects,
    List<String>? topics,
    List<DifficultyLevel>? difficulties,
    List<String>? questionTypes,
    List<ArdeLevel>? ardeProbabilities,
    int? minArdeFrequency,
    DateTime? minCreatedDate,
    DateTime? maxCreatedDate,
    bool? showWeakAreas,
    bool? showUnattempted,
    bool? showIncorrect,
    bool? showBookmarked,
    String? searchQuery,
    List<String>? tags,
    QuestionSortBy? sortBy,
    SortDirection? sortDirection,
    int? limit,
    String? lastDocumentId,
  });
}

/// @nodoc
class __$$QuestionFilterImplCopyWithImpl<$Res>
    extends _$QuestionFilterCopyWithImpl<$Res, _$QuestionFilterImpl>
    implements _$$QuestionFilterImplCopyWith<$Res> {
  __$$QuestionFilterImplCopyWithImpl(
    _$QuestionFilterImpl _value,
    $Res Function(_$QuestionFilterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuestionFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? examCategories = freezed,
    Object? subjects = freezed,
    Object? topics = freezed,
    Object? difficulties = freezed,
    Object? questionTypes = freezed,
    Object? ardeProbabilities = freezed,
    Object? minArdeFrequency = freezed,
    Object? minCreatedDate = freezed,
    Object? maxCreatedDate = freezed,
    Object? showWeakAreas = freezed,
    Object? showUnattempted = freezed,
    Object? showIncorrect = freezed,
    Object? showBookmarked = freezed,
    Object? searchQuery = freezed,
    Object? tags = freezed,
    Object? sortBy = freezed,
    Object? sortDirection = freezed,
    Object? limit = freezed,
    Object? lastDocumentId = freezed,
  }) {
    return _then(
      _$QuestionFilterImpl(
        examCategories: freezed == examCategories
            ? _value._examCategories
            : examCategories // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        subjects: freezed == subjects
            ? _value._subjects
            : subjects // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        topics: freezed == topics
            ? _value._topics
            : topics // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        difficulties: freezed == difficulties
            ? _value._difficulties
            : difficulties // ignore: cast_nullable_to_non_nullable
                  as List<DifficultyLevel>?,
        questionTypes: freezed == questionTypes
            ? _value._questionTypes
            : questionTypes // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        ardeProbabilities: freezed == ardeProbabilities
            ? _value._ardeProbabilities
            : ardeProbabilities // ignore: cast_nullable_to_non_nullable
                  as List<ArdeLevel>?,
        minArdeFrequency: freezed == minArdeFrequency
            ? _value.minArdeFrequency
            : minArdeFrequency // ignore: cast_nullable_to_non_nullable
                  as int?,
        minCreatedDate: freezed == minCreatedDate
            ? _value.minCreatedDate
            : minCreatedDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        maxCreatedDate: freezed == maxCreatedDate
            ? _value.maxCreatedDate
            : maxCreatedDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        showWeakAreas: freezed == showWeakAreas
            ? _value.showWeakAreas
            : showWeakAreas // ignore: cast_nullable_to_non_nullable
                  as bool?,
        showUnattempted: freezed == showUnattempted
            ? _value.showUnattempted
            : showUnattempted // ignore: cast_nullable_to_non_nullable
                  as bool?,
        showIncorrect: freezed == showIncorrect
            ? _value.showIncorrect
            : showIncorrect // ignore: cast_nullable_to_non_nullable
                  as bool?,
        showBookmarked: freezed == showBookmarked
            ? _value.showBookmarked
            : showBookmarked // ignore: cast_nullable_to_non_nullable
                  as bool?,
        searchQuery: freezed == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String?,
        tags: freezed == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        sortBy: freezed == sortBy
            ? _value.sortBy
            : sortBy // ignore: cast_nullable_to_non_nullable
                  as QuestionSortBy?,
        sortDirection: freezed == sortDirection
            ? _value.sortDirection
            : sortDirection // ignore: cast_nullable_to_non_nullable
                  as SortDirection?,
        limit: freezed == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int?,
        lastDocumentId: freezed == lastDocumentId
            ? _value.lastDocumentId
            : lastDocumentId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionFilterImpl extends _QuestionFilter {
  const _$QuestionFilterImpl({
    final List<String>? examCategories,
    final List<String>? subjects,
    final List<String>? topics,
    final List<DifficultyLevel>? difficulties,
    final List<String>? questionTypes,
    final List<ArdeLevel>? ardeProbabilities,
    this.minArdeFrequency,
    this.minCreatedDate,
    this.maxCreatedDate,
    this.showWeakAreas,
    this.showUnattempted,
    this.showIncorrect,
    this.showBookmarked,
    this.searchQuery,
    final List<String>? tags,
    this.sortBy,
    this.sortDirection = SortDirection.descending,
    this.limit = 20,
    this.lastDocumentId,
  }) : _examCategories = examCategories,
       _subjects = subjects,
       _topics = topics,
       _difficulties = difficulties,
       _questionTypes = questionTypes,
       _ardeProbabilities = ardeProbabilities,
       _tags = tags,
       super._();

  factory _$QuestionFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionFilterImplFromJson(json);

  // Basic Filters
  final List<String>? _examCategories;
  // Basic Filters
  @override
  List<String>? get examCategories {
    final value = _examCategories;
    if (value == null) return null;
    if (_examCategories is EqualUnmodifiableListView) return _examCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _subjects;
  @override
  List<String>? get subjects {
    final value = _subjects;
    if (value == null) return null;
    if (_subjects is EqualUnmodifiableListView) return _subjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _topics;
  @override
  List<String>? get topics {
    final value = _topics;
    if (value == null) return null;
    if (_topics is EqualUnmodifiableListView) return _topics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<DifficultyLevel>? _difficulties;
  @override
  List<DifficultyLevel>? get difficulties {
    final value = _difficulties;
    if (value == null) return null;
    if (_difficulties is EqualUnmodifiableListView) return _difficulties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _questionTypes;
  @override
  List<String>? get questionTypes {
    final value = _questionTypes;
    if (value == null) return null;
    if (_questionTypes is EqualUnmodifiableListView) return _questionTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ArdeLevel>? _ardeProbabilities;
  @override
  List<ArdeLevel>? get ardeProbabilities {
    final value = _ardeProbabilities;
    if (value == null) return null;
    if (_ardeProbabilities is EqualUnmodifiableListView)
      return _ardeProbabilities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // Advanced Filters
  @override
  final int? minArdeFrequency;
  @override
  final DateTime? minCreatedDate;
  @override
  final DateTime? maxCreatedDate;
  // Performance-based Filters
  @override
  final bool? showWeakAreas;
  @override
  final bool? showUnattempted;
  @override
  final bool? showIncorrect;
  @override
  final bool? showBookmarked;
  // Search
  @override
  final String? searchQuery;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // Sorting
  @override
  final QuestionSortBy? sortBy;
  @override
  @JsonKey()
  final SortDirection? sortDirection;
  // Pagination
  @override
  @JsonKey()
  final int? limit;
  @override
  final String? lastDocumentId;

  @override
  String toString() {
    return 'QuestionFilter(examCategories: $examCategories, subjects: $subjects, topics: $topics, difficulties: $difficulties, questionTypes: $questionTypes, ardeProbabilities: $ardeProbabilities, minArdeFrequency: $minArdeFrequency, minCreatedDate: $minCreatedDate, maxCreatedDate: $maxCreatedDate, showWeakAreas: $showWeakAreas, showUnattempted: $showUnattempted, showIncorrect: $showIncorrect, showBookmarked: $showBookmarked, searchQuery: $searchQuery, tags: $tags, sortBy: $sortBy, sortDirection: $sortDirection, limit: $limit, lastDocumentId: $lastDocumentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionFilterImpl &&
            const DeepCollectionEquality().equals(
              other._examCategories,
              _examCategories,
            ) &&
            const DeepCollectionEquality().equals(other._subjects, _subjects) &&
            const DeepCollectionEquality().equals(other._topics, _topics) &&
            const DeepCollectionEquality().equals(
              other._difficulties,
              _difficulties,
            ) &&
            const DeepCollectionEquality().equals(
              other._questionTypes,
              _questionTypes,
            ) &&
            const DeepCollectionEquality().equals(
              other._ardeProbabilities,
              _ardeProbabilities,
            ) &&
            (identical(other.minArdeFrequency, minArdeFrequency) ||
                other.minArdeFrequency == minArdeFrequency) &&
            (identical(other.minCreatedDate, minCreatedDate) ||
                other.minCreatedDate == minCreatedDate) &&
            (identical(other.maxCreatedDate, maxCreatedDate) ||
                other.maxCreatedDate == maxCreatedDate) &&
            (identical(other.showWeakAreas, showWeakAreas) ||
                other.showWeakAreas == showWeakAreas) &&
            (identical(other.showUnattempted, showUnattempted) ||
                other.showUnattempted == showUnattempted) &&
            (identical(other.showIncorrect, showIncorrect) ||
                other.showIncorrect == showIncorrect) &&
            (identical(other.showBookmarked, showBookmarked) ||
                other.showBookmarked == showBookmarked) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.sortDirection, sortDirection) ||
                other.sortDirection == sortDirection) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.lastDocumentId, lastDocumentId) ||
                other.lastDocumentId == lastDocumentId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    const DeepCollectionEquality().hash(_examCategories),
    const DeepCollectionEquality().hash(_subjects),
    const DeepCollectionEquality().hash(_topics),
    const DeepCollectionEquality().hash(_difficulties),
    const DeepCollectionEquality().hash(_questionTypes),
    const DeepCollectionEquality().hash(_ardeProbabilities),
    minArdeFrequency,
    minCreatedDate,
    maxCreatedDate,
    showWeakAreas,
    showUnattempted,
    showIncorrect,
    showBookmarked,
    searchQuery,
    const DeepCollectionEquality().hash(_tags),
    sortBy,
    sortDirection,
    limit,
    lastDocumentId,
  ]);

  /// Create a copy of QuestionFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionFilterImplCopyWith<_$QuestionFilterImpl> get copyWith =>
      __$$QuestionFilterImplCopyWithImpl<_$QuestionFilterImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionFilterImplToJson(this);
  }
}

abstract class _QuestionFilter extends QuestionFilter {
  const factory _QuestionFilter({
    final List<String>? examCategories,
    final List<String>? subjects,
    final List<String>? topics,
    final List<DifficultyLevel>? difficulties,
    final List<String>? questionTypes,
    final List<ArdeLevel>? ardeProbabilities,
    final int? minArdeFrequency,
    final DateTime? minCreatedDate,
    final DateTime? maxCreatedDate,
    final bool? showWeakAreas,
    final bool? showUnattempted,
    final bool? showIncorrect,
    final bool? showBookmarked,
    final String? searchQuery,
    final List<String>? tags,
    final QuestionSortBy? sortBy,
    final SortDirection? sortDirection,
    final int? limit,
    final String? lastDocumentId,
  }) = _$QuestionFilterImpl;
  const _QuestionFilter._() : super._();

  factory _QuestionFilter.fromJson(Map<String, dynamic> json) =
      _$QuestionFilterImpl.fromJson;

  // Basic Filters
  @override
  List<String>? get examCategories;
  @override
  List<String>? get subjects;
  @override
  List<String>? get topics;
  @override
  List<DifficultyLevel>? get difficulties;
  @override
  List<String>? get questionTypes;
  @override
  List<ArdeLevel>? get ardeProbabilities; // Advanced Filters
  @override
  int? get minArdeFrequency;
  @override
  DateTime? get minCreatedDate;
  @override
  DateTime? get maxCreatedDate; // Performance-based Filters
  @override
  bool? get showWeakAreas;
  @override
  bool? get showUnattempted;
  @override
  bool? get showIncorrect;
  @override
  bool? get showBookmarked; // Search
  @override
  String? get searchQuery;
  @override
  List<String>? get tags; // Sorting
  @override
  QuestionSortBy? get sortBy;
  @override
  SortDirection? get sortDirection; // Pagination
  @override
  int? get limit;
  @override
  String? get lastDocumentId;

  /// Create a copy of QuestionFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionFilterImplCopyWith<_$QuestionFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
