import 'package:dartz/dartz.dart';
import 'package:multiplication_app/core/error/exceptions.dart';
import 'package:multiplication_app/core/error/failures.dart';
import 'dart:math';
import 'package:multiplication_app/features/multiplication/data/datasources/local_data_source.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/challenge_result/challenge_result.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/multiplication_problem/multiplication_problem.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/user/user.dart';
import 'package:multiplication_app/features/multiplication/domain/repositories/multiplication_repository.dart';

class MultiplicationRepositoryImpl implements MultiplicationRepository {
  final LocalDataSource localDataSource;

  MultiplicationRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, User>> registerUser(String username) async {
    try {
      final user = User(username: username, stars: 0, completedTables: []);
      await localDataSource.saveUser(user);
      return Right(user);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final user = await localDataSource.getUser();
      if (user != null) {
        return Right(user);
      } else {
        return Left(UserNotFoundFailure());
      }
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> updateStars(
    int starsToAdd, {
    int? tableId,
    bool isTableCompleted = false,
  }) async {
    try {
      final user = await localDataSource.getUser();
      if (user != null) {
        int updatedStars = user.stars + starsToAdd;
        List<int> updatedCompletedTables = List.from(user.completedTables);

        if (isTableCompleted &&
            tableId != null &&
            !updatedCompletedTables.contains(tableId)) {
          updatedCompletedTables.add(tableId);
          updatedCompletedTables.sort();
        }

        final updatedUser = user.copyWith(
          stars: updatedStars,
          completedTables: updatedCompletedTables,
        );
        await localDataSource.saveUser(updatedUser);
        return Right(updatedUser);
      } else {
        return Left(UserNotFoundFailure());
      }
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<MultiplicationProblem>>>
  getMultiplicationProblems(int table, int count) async {
    try {
      List<MultiplicationProblem> problems = [];
      final random = Random();

      if (table > 0 && table <= 9) {
        for (int i = 1; i <= 9; i++) {
          problems.add(
            MultiplicationProblem.create(factor1: table, factor2: i),
          );
        }
      } else {
        for (int i = 0; i < count; i++) {
          problems.add(
            MultiplicationProblem.create(
              factor1: random.nextInt(9) + 1,
              factor2: random.nextInt(9) + 1,
            ),
          );
        }
      }
      return Right(problems);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ChallengeResult>> saveChallengeResult(
    ChallengeResult result,
  ) async {
    try {
      await localDataSource.saveChallengeResult(result);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
