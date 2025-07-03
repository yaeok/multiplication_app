import 'package:dartz/dartz.dart';
import 'package:multiplication_app/core/error/failures.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/challenge_result/challenge_result.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/multiplication_problem/multiplication_problem.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/user/user.dart';

abstract class MultiplicationRepository {
  Future<Either<Failure, User>> registerUser(String username);
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, User>> updateStars(
    int starsToAdd, {
    int? tableId,
    bool isTableCompleted = false,
  });
  Future<Either<Failure, List<MultiplicationProblem>>>
  getMultiplicationProblems(int table, int count);
  Future<Either<Failure, ChallengeResult>> saveChallengeResult(
    ChallengeResult result,
  );
}
