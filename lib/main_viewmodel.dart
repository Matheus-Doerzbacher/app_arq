import 'dart:async';

import 'package:app_arq/data/repositories/auth/auth_repository.dart';
import 'package:app_arq/domain/model/user_model.dart';
import 'package:flutter/foundation.dart';

class MainViewmodel extends ChangeNotifier {
  final AuthRepository _authRepository;

  User _user = NotLoggedUser();
  User get user => _user;

  late final StreamSubscription _userSubscription;

  MainViewmodel(this._authRepository) {
    _userSubscription = _authRepository.userObserver().listen(
      (user) {
        _user = user;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }
}
