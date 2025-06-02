import '../../data/models/request_wallet_model.dart';
import '../../data/repositories/request_wallet_repository_interface.dart';

class SendRequestUseCase {
  final IRequestWalletRepository repository;

  SendRequestUseCase(this.repository);

  Future<void> call(RequestWalletModel model) {
    return repository.submitRequest(model);
  }
}