import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:multiplication_app/core/error/failures.dart';
import 'package:multiplication_app/core/usecases/usecase.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/multiplication_problem/multiplication_problem.dart';
import 'package:multiplication_app/features/multiplication/domain/repositories/multiplication_repository.dart';

class GetMultiplicationProblems
    implements
        UseCase<List<MultiplicationProblem>, GetMultiplicationProblemsParams> {
  final MultiplicationRepository repository;

  GetMultiplicationProblems(this.repository);

  @override
  Future<Either<Failure, List<MultiplicationProblem>>> call(
    GetMultiplicationProblemsParams params,
  ) async {
    return await repository.getMultiplicationProblems(
      params.table,
      params.count,
    );
  }
}

class GetMultiplicationProblemsParams extends Equatable {
  final int table; // 1-9の段、または0でランダム
  final int count;

  const GetMultiplicationProblemsParams({
    required this.table,
    required this.count,
  });

  @override
  List<Object?> get props => [table, count];
}
