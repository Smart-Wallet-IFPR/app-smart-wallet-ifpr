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
    const url = ApiConstants.urlLoginSuap;

    final payload = AuthRequestModel(username: ra, password: senha).toJson();

    final response = await client.post(Uri.parse(url), body: payload);

    if (response.statusCode != 200) {
      return false;
    }

    final Map<String, dynamic> body = json.decode(response.body);
    var accessToken = body["access"];

    final responseAux = await client.get(
      Uri.parse(
        "https://suap.ifpr.edu.br/api/edu/dados-aluno-matriculado/?matricula=20210002150",
      ),
      headers: {
        'User-Agent':
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36",
        'Authorization': 'Bearer $accessToken',
        'accept': 'application/json',
      },
    );

    if (responseAux.statusCode != 200) {
      return false;
    }

    // final Map<String, dynamic> decodedJson = json.decode(response.body);
    // final authResponse = AuthResponseModel.fromJson(decodedJson);
    //
    // await storage.write(
    //   key: 'authentication',
    //   value: json.encode(authResponse.toJson()),
    // );

    return true;
  }

  Future<void> logout() async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');
  }
}
