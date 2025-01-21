import 'package:app_arq/data/services/client_http.dart';
import 'package:app_arq/domain/dtos/credentials.dart';
import 'package:app_arq/domain/model/user_model.dart';
import 'package:result_dart/result_dart.dart';

class AuthClientHttp {
  final ClientHttp _clientHttp;

  AuthClientHttp(this._clientHttp);

  AsyncResult<LoggedUser> login(Credentials credentials) async {
    final response = await _clientHttp.post('/login', {
      'email': credentials.email,
      'password': credentials.password,
    });

    return response.map((response) => LoggedUser.fromJson(response.data));
  }
}
