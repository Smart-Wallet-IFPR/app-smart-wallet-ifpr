import 'package:flutter/material.dart';
import '../../domain/usecases/authentication_usecase.dart';

class LoginController extends ChangeNotifier {
  final AuthenticationUseCase authUseCase;

  LoginController(this.authUseCase);

  bool isLoading = false;
  String? errorMessage;

  Future<bool> login(String ra, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await authUseCase.execute(ra, password);
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
