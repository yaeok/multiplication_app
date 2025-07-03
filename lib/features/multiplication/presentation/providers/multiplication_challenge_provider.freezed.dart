// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'multiplication_challenge_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MultiplicationChallengeState {
  List<MultiplicationProblem> get problems =>
      throw _privateConstructorUsedError;
  int get currentProblemIndex => throw _privateConstructorUsedError;
  int get correctAnswers => throw _privateConstructorUsedError;
  bool get isChallengeComplete => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of MultiplicationChallengeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MultiplicationChallengeStateCopyWith<MultiplicationChallengeState>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MultiplicationChallengeStateCopyWith<$Res> {
  factory $MultiplicationChallengeStateCopyWith(
    MultiplicationChallengeState value,
    $Res Function(MultiplicationChallengeState) then,
  ) =
      _$MultiplicationChallengeStateCopyWithImpl<
        $Res,
        MultiplicationChallengeState
      >;
  @useResult
  $Res call({
    List<MultiplicationProblem> problems,
    int currentProblemIndex,
    int correctAnswers,
    bool isChallengeComplete,
    String? errorMessage,
    bool isLoading,
  });
}

/// @nodoc
class _$MultiplicationChallengeStateCopyWithImpl<
  $Res,
  $Val extends MultiplicationChallengeState
>
    implements $MultiplicationChallengeStateCopyWith<$Res> {
  _$MultiplicationChallengeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MultiplicationChallengeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? problems = null,
    Object? currentProblemIndex = null,
    Object? correctAnswers = null,
    Object? isChallengeComplete = null,
    Object? errorMessage = freezed,
    Object? isLoading = null,
  }) {
    return _then(
      _value.copyWith(
            problems: null == problems
                ? _value.problems
                : problems // ignore: cast_nullable_to_non_nullable
                      as List<MultiplicationProblem>,
            currentProblemIndex: null == currentProblemIndex
                ? _value.currentProblemIndex
                : currentProblemIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            correctAnswers: null == correctAnswers
                ? _value.correctAnswers
                : correctAnswers // ignore: cast_nullable_to_non_nullable
                      as int,
            isChallengeComplete: null == isChallengeComplete
                ? _value.isChallengeComplete
                : isChallengeComplete // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MultiplicationChallengeStateImplCopyWith<$Res>
    implements $MultiplicationChallengeStateCopyWith<$Res> {
  factory _$$MultiplicationChallengeStateImplCopyWith(
    _$MultiplicationChallengeStateImpl value,
    $Res Function(_$MultiplicationChallengeStateImpl) then,
  ) = __$$MultiplicationChallengeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<MultiplicationProblem> problems,
    int currentProblemIndex,
    int correctAnswers,
    bool isChallengeComplete,
    String? errorMessage,
    bool isLoading,
  });
}

/// @nodoc
class __$$MultiplicationChallengeStateImplCopyWithImpl<$Res>
    extends
        _$MultiplicationChallengeStateCopyWithImpl<
          $Res,
          _$MultiplicationChallengeStateImpl
        >
    implements _$$MultiplicationChallengeStateImplCopyWith<$Res> {
  __$$MultiplicationChallengeStateImplCopyWithImpl(
    _$MultiplicationChallengeStateImpl _value,
    $Res Function(_$MultiplicationChallengeStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MultiplicationChallengeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? problems = null,
    Object? currentProblemIndex = null,
    Object? correctAnswers = null,
    Object? isChallengeComplete = null,
    Object? errorMessage = freezed,
    Object? isLoading = null,
  }) {
    return _then(
      _$MultiplicationChallengeStateImpl(
        problems: null == problems
            ? _value._problems
            : problems // ignore: cast_nullable_to_non_nullable
                  as List<MultiplicationProblem>,
        currentProblemIndex: null == currentProblemIndex
            ? _value.currentProblemIndex
            : currentProblemIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        correctAnswers: null == correctAnswers
            ? _value.correctAnswers
            : correctAnswers // ignore: cast_nullable_to_non_nullable
                  as int,
        isChallengeComplete: null == isChallengeComplete
            ? _value.isChallengeComplete
            : isChallengeComplete // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$MultiplicationChallengeStateImpl extends _MultiplicationChallengeState {
  const _$MultiplicationChallengeStateImpl({
    final List<MultiplicationProblem> problems = const [],
    this.currentProblemIndex = 0,
    this.correctAnswers = 0,
    this.isChallengeComplete = false,
    this.errorMessage,
    this.isLoading = false,
  }) : _problems = problems,
       super._();

  final List<MultiplicationProblem> _problems;
  @override
  @JsonKey()
  List<MultiplicationProblem> get problems {
    if (_problems is EqualUnmodifiableListView) return _problems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_problems);
  }

  @override
  @JsonKey()
  final int currentProblemIndex;
  @override
  @JsonKey()
  final int correctAnswers;
  @override
  @JsonKey()
  final bool isChallengeComplete;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'MultiplicationChallengeState(problems: $problems, currentProblemIndex: $currentProblemIndex, correctAnswers: $correctAnswers, isChallengeComplete: $isChallengeComplete, errorMessage: $errorMessage, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MultiplicationChallengeStateImpl &&
            const DeepCollectionEquality().equals(other._problems, _problems) &&
            (identical(other.currentProblemIndex, currentProblemIndex) ||
                other.currentProblemIndex == currentProblemIndex) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.isChallengeComplete, isChallengeComplete) ||
                other.isChallengeComplete == isChallengeComplete) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_problems),
    currentProblemIndex,
    correctAnswers,
    isChallengeComplete,
    errorMessage,
    isLoading,
  );

  /// Create a copy of MultiplicationChallengeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MultiplicationChallengeStateImplCopyWith<
    _$MultiplicationChallengeStateImpl
  >
  get copyWith =>
      __$$MultiplicationChallengeStateImplCopyWithImpl<
        _$MultiplicationChallengeStateImpl
      >(this, _$identity);
}

abstract class _MultiplicationChallengeState
    extends MultiplicationChallengeState {
  const factory _MultiplicationChallengeState({
    final List<MultiplicationProblem> problems,
    final int currentProblemIndex,
    final int correctAnswers,
    final bool isChallengeComplete,
    final String? errorMessage,
    final bool isLoading,
  }) = _$MultiplicationChallengeStateImpl;
  const _MultiplicationChallengeState._() : super._();

  @override
  List<MultiplicationProblem> get problems;
  @override
  int get currentProblemIndex;
  @override
  int get correctAnswers;
  @override
  bool get isChallengeComplete;
  @override
  String? get errorMessage;
  @override
  bool get isLoading;

  /// Create a copy of MultiplicationChallengeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MultiplicationChallengeStateImplCopyWith<
    _$MultiplicationChallengeStateImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
