import 'package:multiplication_app/features/multiplication/domain/entities/challenge_result/challenge_result.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/user/user.dart';

abstract class LocalDataSource {
  Future<User?> getUser();
  Future<void> saveUser(User user);
  Future<void> updateStars(int stars);
  Future<void> saveChallengeResult(ChallengeResult result);
}
