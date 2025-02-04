import 'package:app_arq/data/repositories/auth/auth_repository.dart';
import 'package:app_arq/data/repositories/auth/remote_auth_repository.dart';
import 'package:app_arq/data/services/auth/auth_client_http.dart';
import 'package:app_arq/data/services/auth/auth_local_storage.dart';
import 'package:app_arq/data/services/client_http.dart';
import 'package:app_arq/data/services/local_storage.dart';
import 'package:app_arq/main_viewmodel.dart';
import 'package:app_arq/ui/auth/login/viewmodels/login_viewmodel.dart';
import 'package:app_arq/ui/auth/logout/viewmodels/logout_viewmodel.dart';
import 'package:auto_injector/auto_injector.dart';
import 'package:dio/dio.dart';

final injector = AutoInjector();

void setupDependencies() {
  injector.addSingleton<AuthRepository>(RemoteAuthRepository.new);
  injector.addInstance(Dio());
  injector.addSingleton(ClientHttp.new);
  injector.addSingleton(LocalStorage.new);
  injector.addSingleton(AuthClientHttp.new);
  injector.addSingleton(AuthLocalStorage.new);

  // viewmodel
  injector.addSingleton(LoginViewModel.new);
  injector.addSingleton(LogoutViewmodel.new);
  injector.addSingleton(MainViewmodel.new);
}
