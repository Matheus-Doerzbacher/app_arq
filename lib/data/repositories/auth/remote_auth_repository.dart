import 'dart:async';

import 'package:app_arq/data/repositories/auth/auth_repository.dart';
import 'package:app_arq/data/services/auth/auth_client_http.dart';
import 'package:app_arq/data/services/auth/auth_local_storage.dart';
import 'package:app_arq/domain/dtos/credentials.dart';
import 'package:app_arq/domain/model/user_model.dart';
import 'package:app_arq/domain/validators/credentials_validator.dart';
import 'package:app_arq/utils/validation/lucid_validator_extension.dart';
import 'package:result_dart/result_dart.dart';

class RemoteAuthRepository implements AuthRepository {
  RemoteAuthRepository(this._authLocalStorage, this._authClientHttp);

  final AuthLocalStorage _authLocalStorage;
  final AuthClientHttp _authClientHttp;

  final _stramController = StreamController<User>.broadcast();

  @override
  AsyncResult<LoggedUser> getUser() {
    return _authLocalStorage.getUser();
  }

  @override
  AsyncResult<LoggedUser> login(Credentials credentials) async {
    final validator = CredentialsValidator();

    return validator
        .validateResult(credentials)
        .flatMap(_authClientHttp.login)
        .flatMap(_authLocalStorage.saveUser)
        .onSuccess(_stramController.add);
  }

  @override
  AsyncResult<Unit> logout() {
    return _authLocalStorage //
        .removeUser()
        .onSuccess(
          (_) => _stramController.add(const NotLoggedUser()),
        );
  }

  @override
  Stream<User> userObserver() {
    return _stramController.stream;
  }

  @override
  void dispose() {
    _stramController.close();
  }
}
