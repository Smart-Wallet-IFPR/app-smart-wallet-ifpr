import 'package:flutter/material.dart';
import '../../domain/usecases/login_usecase.dart';

class LoginController extends ChangeNotifier {
  final LoginUseCase loginUseCase;

  LoginController(this.loginUseCase);

  bool isLoading = false;
  String? errorMessage;

  Future<bool> login(String ra, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await loginUseCase.execute(ra, password);
      return result;
    } catch (e) {
      errorMessage = 'Erro ao fazer login';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
