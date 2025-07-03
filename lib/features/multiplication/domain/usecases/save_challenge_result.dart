import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:multiplication_app/core/error/failures.dart';
import 'package:multiplication_app/core/usecases/usecase.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/challenge_result/challenge_result.dart';
import 'package:multiplication_app/features/multiplication/domain/repositories/multiplication_repository.dart';

class SaveChallengeResult
    implements UseCase<ChallengeResult, SaveChallengeResultParams> {
  final MultiplicationRepository repository;

  SaveChallengeResult(this.repository);

  @override
  Future<Either<Failure, ChallengeResult>> call(
    SaveChallengeResultParams params,
  ) async {
    return await repository.saveChallengeResult(params.result);
  }
}

class SaveChallengeResultParams extends Equatable {
  final ChallengeResult result;

  const SaveChallengeResultParams({required this.result});

  @override
  List<Object?> get props => [result];
}
