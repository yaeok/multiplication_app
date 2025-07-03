import 'package:multiplication_app/core/usecases/usecase.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/user/user.dart';
import 'package:multiplication_app/features/multiplication/domain/usecases/get_user_data.dart';
import 'package:multiplication_app/features/multiplication/domain/usecases/register_user.dart';
import 'package:multiplication_app/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  late final RegisterUser _registerUser;
  late final GetUserData _getUserData;

  @override
  FutureOr<User?> build() async {
    // ユースケースプロバイダの future を await する
    _registerUser = await ref.read(registerUserUseCaseProvider.future);
    _getUserData = await ref.read(getUserDataUseCaseProvider.future);
    return await loadUserInternal();
  }

  Future<User?> loadUserInternal() async {
    state = const AsyncLoading();
    final failureOrUser = await _getUserData(NoParams());
    return failureOrUser.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
        print('Error loading user: $failure');
        return null;
      },
      (user) {
        state = AsyncData(user);
        return user;
      },
    );
  }

  Future<void> createUser(String username) async {
    state = const AsyncLoading();
    final failureOrUser = await _registerUser(
      RegisterUserParams(username: username),
    );
    failureOrUser.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
        print('Error registering user: $failure');
      },
      (user) {
        state = AsyncData(user);
      },
    );
  }

  void updateCurrentUser(User updatedUser) {
    state = AsyncData(updatedUser);
  }
}
