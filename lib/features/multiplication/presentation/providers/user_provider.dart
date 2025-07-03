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
    _registerUser = ref.read(registerUserUseCaseProvider);
    _getUserData = ref.read(getUserDataUseCaseProvider);
    // Providerが初期化されるときにユーザーデータをロードする
    // これで go_router の redirect 内で await する必要がなくなる
    return await loadUserInternal(); // build メソッドから呼ぶプライベートなロード関数
  }

  // 外部からの呼び出しは不要になるため、プライベートなメソッドにするか、
  // loadUser() 自体もbuildメソッド内でしか呼ばれないようにする
  // 今回は loadUser() を build() 内で呼ぶ形に調整
  Future<User?> loadUserInternal() async {
    // メソッド名を変更
    state = const AsyncLoading(); // ロード中状態に設定
    final failureOrUser = await _getUserData(NoParams());
    return failureOrUser.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current); // エラー状態に設定
        print('Error loading user: $failure');
        return null; // ユーザーが見つからない場合
      },
      (user) {
        state = AsyncData(user); // 成功データを設定
        return user;
      },
    );
  }

  Future<void> createUser(String username) async {
    state = const AsyncLoading(); // ロード中状態に設定
    final failureOrUser = await _registerUser(
      RegisterUserParams(username: username),
    );
    failureOrUser.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current); // エラー状態に設定
        print('Error registering user: $failure');
      },
      (user) {
        state = AsyncData(user); // 成功データを設定
      },
    );
  }

  void updateCurrentUser(User updatedUser) {
    state = AsyncData(updatedUser); // ユーザー情報を直接更新
  }
}
