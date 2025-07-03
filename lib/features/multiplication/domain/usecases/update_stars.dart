import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:multiplication_app/core/error/failures.dart';
import 'package:multiplication_app/core/usecases/usecase.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/user/user.dart';
import 'package:multiplication_app/features/multiplication/domain/repositories/multiplication_repository.dart';

class UpdateStars implements UseCase<User, UpdateStarsParams> {
  final MultiplicationRepository repository;

  UpdateStars(this.repository);

  @override
  Future<Either<Failure, User>> call(UpdateStarsParams params) async {
    return await repository.updateStars(params.starsToAdd);
  }
}

class UpdateStarsParams extends Equatable {
  final int starsToAdd;

  const UpdateStarsParams({required this.starsToAdd});

  @override
  List<Object?> get props => [starsToAdd];
}
