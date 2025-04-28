import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../core/models/auth/auth_request_model.dart';
import '../../../core/models/auth/auth_response_model.dart';
import '../../../shared/constants/api_constants.dart';

class AuthRepository {
  final http.Client client;
  final storage = FlutterSecureStorage();

  AuthRepository({required this.client});

  Future<bool> login(String ra, String password) async {
    const url = ApiConstants.urlLoginSuap;

    final payload = AuthRequestModel(ra: ra, password: password).toJson();

    final response = await client.post(
      Uri.parse(url),
      body: payload,
    );

    if (response.statusCode != 200) {
      return false;
    }

    final authResponse = AuthResponseModel.fromJson(response.body);

    await storage.write(key: 'access_token', value: authResponse.access);
    await storage.write(key: 'refresh_token', value: authResponse.refresh);

    return true;
  }
}