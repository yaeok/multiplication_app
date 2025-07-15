// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_problem_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChallengeProblemResult _$ChallengeProblemResultFromJson(
  Map<String, dynamic> json,
) {
  return _ChallengeProblemResult.fromJson(json);
}

/// @nodoc
mixin _$ChallengeProblemResult {
  MultiplicationProblem get problem => throw _privateConstructorUsedError;
  int get userAnswer => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;

  /// Serializes this ChallengeProblemResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChallengeProblemResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeProblemResultCopyWith<ChallengeProblemResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeProblemResultCopyWith<$Res> {
  factory $ChallengeProblemResultCopyWith(
    ChallengeProblemResult value,
    $Res Function(ChallengeProblemResult) then,
  ) = _$ChallengeProblemResultCopyWithImpl<$Res, ChallengeProblemResult>;
  @useResult
  $Res call({MultiplicationProblem problem, int userAnswer, bool isCorrect});

  $MultiplicationProblemCopyWith<$Res> get problem;
}

/// @nodoc
class _$ChallengeProblemResultCopyWithImpl<
  $Res,
  $Val extends ChallengeProblemResult
>
    implements $ChallengeProblemResultCopyWith<$Res> {
  _$ChallengeProblemResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChallengeProblemResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? problem = null,
    Object? userAnswer = null,
    Object? isCorrect = null,
  }) {
    return _then(
      _value.copyWith(
            problem: null == problem
                ? _value.problem
                : problem // ignore: cast_nullable_to_non_nullable
                      as MultiplicationProblem,
            userAnswer: null == userAnswer
                ? _value.userAnswer
                : userAnswer // ignore: cast_nullable_to_non_nullable
                      as int,
            isCorrect: null == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of ChallengeProblemResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MultiplicationProblemCopyWith<$Res> get problem {
    return $MultiplicationProblemCopyWith<$Res>(_value.problem, (value) {
      return _then(_value.copyWith(problem: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChallengeProblemResultImplCopyWith<$Res>
    implements $ChallengeProblemResultCopyWith<$Res> {
  factory _$$ChallengeProblemResultImplCopyWith(
    _$ChallengeProblemResultImpl value,
    $Res Function(_$ChallengeProblemResultImpl) then,
  ) = __$$ChallengeProblemResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MultiplicationProblem problem, int userAnswer, bool isCorrect});

  @override
  $MultiplicationProblemCopyWith<$Res> get problem;
}

/// @nodoc
class __$$ChallengeProblemResultImplCopyWithImpl<$Res>
    extends
        _$ChallengeProblemResultCopyWithImpl<$Res, _$ChallengeProblemResultImpl>
    implements _$$ChallengeProblemResultImplCopyWith<$Res> {
  __$$ChallengeProblemResultImplCopyWithImpl(
    _$ChallengeProblemResultImpl _value,
    $Res Function(_$ChallengeProblemResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChallengeProblemResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? problem = null,
    Object? userAnswer = null,
    Object? isCorrect = null,
  }) {
    return _then(
      _$ChallengeProblemResultImpl(
        problem: null == problem
            ? _value.problem
            : problem // ignore: cast_nullable_to_non_nullable
                  as MultiplicationProblem,
        userAnswer: null == userAnswer
            ? _value.userAnswer
            : userAnswer // ignore: cast_nullable_to_non_nullable
                  as int,
        isCorrect: null == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeProblemResultImpl implements _ChallengeProblemResult {
  const _$ChallengeProblemResultImpl({
    required this.problem,
    required this.userAnswer,
    required this.isCorrect,
  });

  factory _$ChallengeProblemResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeProblemResultImplFromJson(json);

  @override
  final MultiplicationProblem problem;
  @override
  final int userAnswer;
  @override
  final bool isCorrect;

  @override
  String toString() {
    return 'ChallengeProblemResult(problem: $problem, userAnswer: $userAnswer, isCorrect: $isCorrect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeProblemResultImpl &&
            (identical(other.problem, problem) || other.problem == problem) &&
            (identical(other.userAnswer, userAnswer) ||
                other.userAnswer == userAnswer) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, problem, userAnswer, isCorrect);

  /// Create a copy of ChallengeProblemResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeProblemResultImplCopyWith<_$ChallengeProblemResultImpl>
  get copyWith =>
      __$$ChallengeProblemResultImplCopyWithImpl<_$ChallengeProblemResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeProblemResultImplToJson(this);
  }
}

abstract class _ChallengeProblemResult implements ChallengeProblemResult {
  const factory _ChallengeProblemResult({
    required final MultiplicationProblem problem,
    required final int userAnswer,
    required final bool isCorrect,
  }) = _$ChallengeProblemResultImpl;

  factory _ChallengeProblemResult.fromJson(Map<String, dynamic> json) =
      _$ChallengeProblemResultImpl.fromJson;

  @override
  MultiplicationProblem get problem;
  @override
  int get userAnswer;
  @override
  bool get isCorrect;

  /// Create a copy of ChallengeProblemResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeProblemResultImplCopyWith<_$ChallengeProblemResultImpl>
  get copyWith => throw _privateConstructorUsedError;
}
