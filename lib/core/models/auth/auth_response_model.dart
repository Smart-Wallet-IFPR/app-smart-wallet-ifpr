import 'dart:convert';

class AuthResponseModel {
  final String username;
  final String access;
  final String refresh;

  AuthResponseModel({
    required this.username,
    required this.access,
    required this.refresh,
  });

  factory AuthResponseModel.fromJson(String json) {
    final data = jsonDecode(json);

    return AuthResponseModel(
      username: data['username'],
      access: data['access'],
      refresh: data['refresh'],
    );
  }
}