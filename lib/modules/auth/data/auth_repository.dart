import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<bool> login(String ra, String password) async {
    const url = 'https://suap.ifpr.edu.br/api/token/pair';

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'User-Agent': 'Mozilla/5.0 (compatible; FlutterApp/1.0)',
    };

    final body = jsonEncode({
      'username': ra,
      'password': password,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final access = json['access'];
        final refresh = json['refresh'];

        // TODO -> Realizando testes, será removido.
        // print('Access Token: $access');
        // print('Refresh Token: $refresh');

        return true;
      } else {
        // TODO -> Realizando testes, será removido.
        // print('Erro de login: ${response.statusCode}');
        // print(response.body);
        return false;
      }
    } catch (e) {
      // TODO -> Realizando testes, será removido.
      // print('Erro de requisição: $e');
      return false;
    }
  }
}