import 'dart:convert';
import 'package:multiplication_app/core/error/exceptions.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/challenge_result/challenge_result.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_data_source.dart';

const CACHED_USER = 'CACHED_USER';
const CACHED_RESULTS = 'CACHED_RESULTS'; // 将来的に使う可能性

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<User?> getUser() {
    final jsonString = sharedPreferences.getString(CACHED_USER);
    if (jsonString != null) {
      return Future.value(User.fromJson(json.decode(jsonString)));
    } else {
      return Future.value(null);
    }
  }

  @override
  Future<void> saveUser(User user) {
    return sharedPreferences.setString(CACHED_USER, json.encode(user.toJson()));
  }

  @override
  Future<void> updateStars(int starsToAdd) async {
    final user = await getUser();
    if (user != null) {
      final updatedUser = user.copyWith(stars: user.stars + starsToAdd);
      await saveUser(updatedUser);
    } else {
      throw CacheException(); // ユーザーが存在しない場合のエラーハンドリング
    }
  }

  @override
  Future<void> saveChallengeResult(ChallengeResult result) {
    // 現在は結果のリストを保存するロジックは省略
    // 将来的に複数結果を保存する場合はリストとして管理する
    return Future.value();
  }
}
