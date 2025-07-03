import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_result.freezed.dart';
part 'challenge_result.g.dart';

@freezed
class ChallengeResult with _$ChallengeResult {
  const factory ChallengeResult({
    required int correctAnswers,
    required int totalProblems,
    required int starsEarned,
    required DateTime timestamp,
  }) = _ChallengeResult;

  factory ChallengeResult.fromJson(Map<String, dynamic> json) =>
      _$ChallengeResultFromJson(json);
}
