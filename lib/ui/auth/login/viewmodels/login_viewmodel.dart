import 'package:app_arq/data/repositories/auth/auth_repository.dart';
import 'package:app_arq/domain/dtos/credentials.dart';
import 'package:app_arq/domain/model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginViewModel({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  late final loginCommand = Command1(_login);

  AsyncResult<LoggedUser> _login(Credentials credentials) {
    return _authRepository.login(credentials);
  }
}
