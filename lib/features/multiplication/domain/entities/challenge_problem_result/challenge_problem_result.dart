import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/multiplication_problem/multiplication_problem.dart';

part 'challenge_problem_result.freezed.dart';
part 'challenge_problem_result.g.dart';

@freezed
class ChallengeProblemResult with _$ChallengeProblemResult {
  const factory ChallengeProblemResult({
    required MultiplicationProblem problem,
    required int userAnswer,
    required bool isCorrect,
  }) = _ChallengeProblemResult;

  factory ChallengeProblemResult.fromJson(Map<String, dynamic> json) =>
      _$ChallengeProblemResultFromJson(json);
}
