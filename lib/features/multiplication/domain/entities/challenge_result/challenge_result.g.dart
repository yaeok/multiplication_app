// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeResultImpl _$$ChallengeResultImplFromJson(
  Map<String, dynamic> json,
) => _$ChallengeResultImpl(
  correctAnswers: (json['correctAnswers'] as num).toInt(),
  totalProblems: (json['totalProblems'] as num).toInt(),
  starsEarned: (json['starsEarned'] as num).toInt(),
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$$ChallengeResultImplToJson(
  _$ChallengeResultImpl instance,
) => <String, dynamic>{
  'correctAnswers': instance.correctAnswers,
  'totalProblems': instance.totalProblems,
  'starsEarned': instance.starsEarned,
  'timestamp': instance.timestamp.toIso8601String(),
};
