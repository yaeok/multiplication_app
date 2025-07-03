// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'multiplication_problem.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MultiplicationProblem _$MultiplicationProblemFromJson(
  Map<String, dynamic> json,
) {
  return _MultiplicationProblem.fromJson(json);
}

/// @nodoc
mixin _$MultiplicationProblem {
  int get factor1 => throw _privateConstructorUsedError;
  int get factor2 => throw _privateConstructorUsedError;
  int get answer => throw _privateConstructorUsedError;

  /// Serializes this MultiplicationProblem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MultiplicationProblem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MultiplicationProblemCopyWith<MultiplicationProblem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MultiplicationProblemCopyWith<$Res> {
  factory $MultiplicationProblemCopyWith(
    MultiplicationProblem value,
    $Res Function(MultiplicationProblem) then,
  ) = _$MultiplicationProblemCopyWithImpl<$Res, MultiplicationProblem>;
  @useResult
  $Res call({int factor1, int factor2, int answer});
}

/// @nodoc
class _$MultiplicationProblemCopyWithImpl<
  $Res,
  $Val extends MultiplicationProblem
>
    implements $MultiplicationProblemCopyWith<$Res> {
  _$MultiplicationProblemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MultiplicationProblem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? factor1 = null,
    Object? factor2 = null,
    Object? answer = null,
  }) {
    return _then(
      _value.copyWith(
            factor1: null == factor1
                ? _value.factor1
                : factor1 // ignore: cast_nullable_to_non_nullable
                      as int,
            factor2: null == factor2
                ? _value.factor2
                : factor2 // ignore: cast_nullable_to_non_nullable
                      as int,
            answer: null == answer
                ? _value.answer
                : answer // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MultiplicationProblemImplCopyWith<$Res>
    implements $MultiplicationProblemCopyWith<$Res> {
  factory _$$MultiplicationProblemImplCopyWith(
    _$MultiplicationProblemImpl value,
    $Res Function(_$MultiplicationProblemImpl) then,
  ) = __$$MultiplicationProblemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int factor1, int factor2, int answer});
}

/// @nodoc
class __$$MultiplicationProblemImplCopyWithImpl<$Res>
    extends
        _$MultiplicationProblemCopyWithImpl<$Res, _$MultiplicationProblemImpl>
    implements _$$MultiplicationProblemImplCopyWith<$Res> {
  __$$MultiplicationProblemImplCopyWithImpl(
    _$MultiplicationProblemImpl _value,
    $Res Function(_$MultiplicationProblemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MultiplicationProblem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? factor1 = null,
    Object? factor2 = null,
    Object? answer = null,
  }) {
    return _then(
      _$MultiplicationProblemImpl(
        factor1: null == factor1
            ? _value.factor1
            : factor1 // ignore: cast_nullable_to_non_nullable
                  as int,
        factor2: null == factor2
            ? _value.factor2
            : factor2 // ignore: cast_nullable_to_non_nullable
                  as int,
        answer: null == answer
            ? _value.answer
            : answer // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MultiplicationProblemImpl implements _MultiplicationProblem {
  const _$MultiplicationProblemImpl({
    required this.factor1,
    required this.factor2,
    required this.answer,
  });

  factory _$MultiplicationProblemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MultiplicationProblemImplFromJson(json);

  @override
  final int factor1;
  @override
  final int factor2;
  @override
  final int answer;

  @override
  String toString() {
    return 'MultiplicationProblem(factor1: $factor1, factor2: $factor2, answer: $answer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MultiplicationProblemImpl &&
            (identical(other.factor1, factor1) || other.factor1 == factor1) &&
            (identical(other.factor2, factor2) || other.factor2 == factor2) &&
            (identical(other.answer, answer) || other.answer == answer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, factor1, factor2, answer);

  /// Create a copy of MultiplicationProblem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MultiplicationProblemImplCopyWith<_$MultiplicationProblemImpl>
  get copyWith =>
      __$$MultiplicationProblemImplCopyWithImpl<_$MultiplicationProblemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MultiplicationProblemImplToJson(this);
  }
}

abstract class _MultiplicationProblem implements MultiplicationProblem {
  const factory _MultiplicationProblem({
    required final int factor1,
    required final int factor2,
    required final int answer,
  }) = _$MultiplicationProblemImpl;

  factory _MultiplicationProblem.fromJson(Map<String, dynamic> json) =
      _$MultiplicationProblemImpl.fromJson;

  @override
  int get factor1;
  @override
  int get factor2;
  @override
  int get answer;

  /// Create a copy of MultiplicationProblem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MultiplicationProblemImplCopyWith<_$MultiplicationProblemImpl>
  get copyWith => throw _privateConstructorUsedError;
}
