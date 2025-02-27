import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
sealed class User with _$User {
  factory User({
    required String id,
    required String name,
    required String email,
  }) = _User;

  const factory User.notLogged() = NotLoggedUser;

  const factory User.logged({
    required String id,
    required String name,
    required String email,
    required String token,
    required String refreshToken,
  }) = LoggedUser;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
