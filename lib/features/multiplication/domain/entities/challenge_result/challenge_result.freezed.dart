// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChallengeResult _$ChallengeResultFromJson(Map<String, dynamic> json) {
  return _ChallengeResult.fromJson(json);
}

/// @nodoc
mixin _$ChallengeResult {
  int get correctAnswers => throw _privateConstructorUsedError;
  int get totalProblems => throw _privateConstructorUsedError;
  int get starsEarned => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this ChallengeResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChallengeResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeResultCopyWith<ChallengeResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeResultCopyWith<$Res> {
  factory $ChallengeResultCopyWith(
    ChallengeResult value,
    $Res Function(ChallengeResult) then,
  ) = _$ChallengeResultCopyWithImpl<$Res, ChallengeResult>;
  @useResult
  $Res call({
    int correctAnswers,
    int totalProblems,
    int starsEarned,
    DateTime timestamp,
  });
}

/// @nodoc
class _$ChallengeResultCopyWithImpl<$Res, $Val extends ChallengeResult>
    implements $ChallengeResultCopyWith<$Res> {
  _$ChallengeResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChallengeResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? correctAnswers = null,
    Object? totalProblems = null,
    Object? starsEarned = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            correctAnswers: null == correctAnswers
                ? _value.correctAnswers
                : correctAnswers // ignore: cast_nullable_to_non_nullable
                      as int,
            totalProblems: null == totalProblems
                ? _value.totalProblems
                : totalProblems // ignore: cast_nullable_to_non_nullable
                      as int,
            starsEarned: null == starsEarned
                ? _value.starsEarned
                : starsEarned // ignore: cast_nullable_to_non_nullable
                      as int,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChallengeResultImplCopyWith<$Res>
    implements $ChallengeResultCopyWith<$Res> {
  factory _$$ChallengeResultImplCopyWith(
    _$ChallengeResultImpl value,
    $Res Function(_$ChallengeResultImpl) then,
  ) = __$$ChallengeResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int correctAnswers,
    int totalProblems,
    int starsEarned,
    DateTime timestamp,
  });
}

/// @nodoc
class __$$ChallengeResultImplCopyWithImpl<$Res>
    extends _$ChallengeResultCopyWithImpl<$Res, _$ChallengeResultImpl>
    implements _$$ChallengeResultImplCopyWith<$Res> {
  __$$ChallengeResultImplCopyWithImpl(
    _$ChallengeResultImpl _value,
    $Res Function(_$ChallengeResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChallengeResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? correctAnswers = null,
    Object? totalProblems = null,
    Object? starsEarned = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$ChallengeResultImpl(
        correctAnswers: null == correctAnswers
            ? _value.correctAnswers
            : correctAnswers // ignore: cast_nullable_to_non_nullable
                  as int,
        totalProblems: null == totalProblems
            ? _value.totalProblems
            : totalProblems // ignore: cast_nullable_to_non_nullable
                  as int,
        starsEarned: null == starsEarned
            ? _value.starsEarned
            : starsEarned // ignore: cast_nullable_to_non_nullable
                  as int,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeResultImpl implements _ChallengeResult {
  const _$ChallengeResultImpl({
    required this.correctAnswers,
    required this.totalProblems,
    required this.starsEarned,
    required this.timestamp,
  });

  factory _$ChallengeResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeResultImplFromJson(json);

  @override
  final int correctAnswers;
  @override
  final int totalProblems;
  @override
  final int starsEarned;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'ChallengeResult(correctAnswers: $correctAnswers, totalProblems: $totalProblems, starsEarned: $starsEarned, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeResultImpl &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.totalProblems, totalProblems) ||
                other.totalProblems == totalProblems) &&
            (identical(other.starsEarned, starsEarned) ||
                other.starsEarned == starsEarned) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    correctAnswers,
    totalProblems,
    starsEarned,
    timestamp,
  );

  /// Create a copy of ChallengeResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeResultImplCopyWith<_$ChallengeResultImpl> get copyWith =>
      __$$ChallengeResultImplCopyWithImpl<_$ChallengeResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeResultImplToJson(this);
  }
}

abstract class _ChallengeResult implements ChallengeResult {
  const factory _ChallengeResult({
    required final int correctAnswers,
    required final int totalProblems,
    required final int starsEarned,
    required final DateTime timestamp,
  }) = _$ChallengeResultImpl;

  factory _ChallengeResult.fromJson(Map<String, dynamic> json) =
      _$ChallengeResultImpl.fromJson;

  @override
  int get correctAnswers;
  @override
  int get totalProblems;
  @override
  int get starsEarned;
  @override
  DateTime get timestamp;

  /// Create a copy of ChallengeResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeResultImplCopyWith<_$ChallengeResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
