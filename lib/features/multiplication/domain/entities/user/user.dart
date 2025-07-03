import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({required String username, @Default(0) int stars}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
