import '../models/request_wallet_model.dart';

abstract class IRequestWalletRepository {
  Future<void> submitRequest(RequestWalletModel model);
}