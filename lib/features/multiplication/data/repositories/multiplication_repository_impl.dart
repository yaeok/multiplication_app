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
      final user = User(username: username, stars: 0);
      await localDataSource.saveUser(user);
      return Right(user);
    } on CacheException {
      // キャッシュに関する既知の例外を処理
      return Left(CacheFailure());
    } catch (e, stackTrace) {
      // 予期せぬ、より広範な例外を捕捉し、ログに記録
      print('Unexpected error during user registration: $e\n$stackTrace');
      // より汎用的な失敗タイプを返す
      return Left(
        ServerFailure(),
      ); // または新しいFailureタイプ (例: UnexpectedFailure()) を定義することもできます
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
  Future<Either<Failure, User>> updateStars(int starsToAdd) async {
    try {
      await localDataSource.updateStars(starsToAdd);
      final updatedUser = await localDataSource.getUser();
      if (updatedUser != null) {
        return Right(updatedUser);
      } else {
        return Left(UserNotFoundFailure()); // 更新後にユーザーが見つからない場合
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
        // 特定の段
        for (int i = 0; i < count; i++) {
          problems.add(
            MultiplicationProblem.create(
              factor1: table,
              factor2: random.nextInt(9) + 1,
            ),
          );
        }
      } else {
        // ランダム10問 (1の段から9の段まで)
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
      // 問題生成ロジック自体でのエラーは稀だが、念のため
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
