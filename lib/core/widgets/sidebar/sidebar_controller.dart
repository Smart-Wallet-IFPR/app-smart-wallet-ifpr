import 'package:flutter/material.dart';

import '../../../modules/auth/domain/usecases/authentication_usecase.dart';

class SidebarController extends ChangeNotifier {
  final AuthenticationUseCase authUseCase;

  SidebarController(this.authUseCase);

  Future<void> logout() async {
    notifyListeners();
    await authUseCase.logout();
    notifyListeners();
  }
}
