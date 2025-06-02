import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/models/auth/auth_request_model.dart';
import '../../../../core/models/auth/auth_response_model.dart';
import '../../../../shared/constants/api_constants.dart';

class AuthRepository {
  final http.Client client;
  final storage = FlutterSecureStorage();

  AuthRepository({required this.client});

  Future<bool> login(String ra, String senha) async {
    const url = ApiConstants.urlLoginCronos;

    final payload = AuthRequestModel(
        email: "lucasrachid@hotmail.com",
        ra: ra,
        senha: senha
    ).toJson();
    // XPT
    final response = await client.post(
      Uri.parse(url),
      body: payload,
    );

    if (response.statusCode != 200) {
      return false;
    }

    final Map<String, dynamic> decodedJson = json.decode(response.body);
    final authResponse = AuthResponseModel.fromJson(decodedJson);

    await storage.write(
      key: 'authentication',
      value: json.encode(authResponse.toJson()),
    );

    return true;
  }

  Future<void> logout() async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');
  }
}