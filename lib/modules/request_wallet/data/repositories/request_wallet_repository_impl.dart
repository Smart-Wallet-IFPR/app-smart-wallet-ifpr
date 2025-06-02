import 'dart:convert';
import 'package:app_smart_wallet_ifpr/modules/request_wallet/data/repositories/request_wallet_repository_interface.dart';
import 'package:http/http.dart' as http;

import '../models/request_wallet_model.dart';

class RequestWalletRepositoryImpl implements IRequestWalletRepository {
  final http.Client client;

  RequestWalletRepositoryImpl(this.client);

  @override
  Future<void> submitRequest(RequestWalletModel model) async {
    final response = await client.post(
      Uri.parse('https://sua-api.com/request-wallet'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': model.name,
        'yearEntry': model.yearEntry,
        'courseOrSerie': model.courseOrSerie,
        'base64Image': model.base64Image,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao enviar solicitação');
    }
  }
}