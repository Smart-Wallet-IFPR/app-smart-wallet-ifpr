import 'dart:convert';

class AuthRequestModel {
  final String email;
  final String ra;
  final String senha;

  AuthRequestModel({
    required this.email,
    required this.ra,
    required this.senha,
  });

  factory AuthRequestModel.fromJson(String json) {
    final data = jsonDecode(json);

    return AuthRequestModel(
      email: data['email'],
      ra: data['ra'],
      senha: data['senha'],

    );
  }

  String toJson() {
    return jsonEncode({
      'email': email,
      'ra': ra,
      'senha': senha,
    });
  }
}