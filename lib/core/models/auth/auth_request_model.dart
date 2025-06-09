import 'dart:convert';

class AuthRequestModel {
  final String username;
  final String password;

  AuthRequestModel({
    required this.username,
    required this.password,
  });

  factory AuthRequestModel.fromJson(String json) {
    final data = jsonDecode(json);

    return AuthRequestModel(
      username: data['username'],
      password: data['password'],

    );
  }

  String toJson() {
    return jsonEncode({
      'username': username,
      'password': password,
    });
  }
}