import 'dart:convert';

class AuthRequestModel {
  final String ra;
  final String password;

  AuthRequestModel({
    required this.ra,
    required this.password,
  });

  factory AuthRequestModel.fromJson(String json) {
    final data = jsonDecode(json);

    return AuthRequestModel(
      ra: data['username'],
      password: data['password'],
    );
  }

  String toJson() {
    return jsonEncode({
      'username': ra,
      'password': password,
    });
  }
}