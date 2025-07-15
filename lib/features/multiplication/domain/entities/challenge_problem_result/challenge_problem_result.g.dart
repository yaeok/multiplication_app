// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_problem_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeProblemResultImpl _$$ChallengeProblemResultImplFromJson(
  Map<String, dynamic> json,
) => _$ChallengeProblemResultImpl(
  problem: MultiplicationProblem.fromJson(
    json['problem'] as Map<String, dynamic>,
  ),
  userAnswer: (json['userAnswer'] as num).toInt(),
  isCorrect: json['isCorrect'] as bool,
);

Map<String, dynamic> _$$ChallengeProblemResultImplToJson(
  _$ChallengeProblemResultImpl instance,
) => <String, dynamic>{
  'problem': instance.problem,
  'userAnswer': instance.userAnswer,
  'isCorrect': instance.isCorrect,
};
