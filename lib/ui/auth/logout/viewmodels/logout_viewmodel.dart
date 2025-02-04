import 'package:app_arq/data/repositories/auth/auth_repository.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class LogoutViewmodel {
  final AuthRepository _authRepository;

  LogoutViewmodel({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  late final logoutCommand = Command0(_logout);

  AsyncResult<Unit> _logout() {
    return _authRepository.logout();
  }
}
