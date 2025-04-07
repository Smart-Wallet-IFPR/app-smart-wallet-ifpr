import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> checkLoginStatus() async {
    // TODO -> Deixar simulando fake a validação de token
    await Future.delayed(const Duration(seconds: 1));
    //TODO -> Aqui você validaria token salvo no SharedPreferences ou SecureStorage
    _isLoggedIn = false; // ou true se estiver logado
    notifyListeners();
  }

  Future<void> login() async {
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    notifyListeners();
  }
}
