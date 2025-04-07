import '../../data/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<bool> execute(String ra, String password) {
    return repository.login(ra, password);
  }
}
