import 'package:dartz/dartz.dart';
import 'package:multiplication_app/core/error/failures.dart';
import 'package:multiplication_app/core/usecases/usecase.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/user/user.dart';
import 'package:equatable/equatable.dart';
import 'package:multiplication_app/features/multiplication/domain/repositories/multiplication_repository.dart';

class RegisterUser implements UseCase<User, RegisterUserParams> {
  final MultiplicationRepository repository;

  RegisterUser(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterUserParams params) async {
    return await repository.registerUser(params.username);
  }
}

class RegisterUserParams extends Equatable {
  final String username;

  const RegisterUserParams({required this.username});

  @override
  List<Object?> get props => [username];
}
