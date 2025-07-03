import 'package:dartz/dartz.dart';
import 'package:multiplication_app/core/error/failures.dart';
import 'package:multiplication_app/core/usecases/usecase.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/user/user.dart';
import 'package:multiplication_app/features/multiplication/domain/repositories/multiplication_repository.dart';

class GetUserData implements UseCase<User, NoParams> {
  final MultiplicationRepository repository;

  GetUserData(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getUser();
  }
}
