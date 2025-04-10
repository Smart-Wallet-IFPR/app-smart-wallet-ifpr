import '../../data/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<bool> execute(String ra, String password) async {
    return await repository.login(ra, password);
  }
}
