import '../../data/repositories/auth_repository.dart';

class AuthenticationUseCase {
  final AuthRepository repository;

  AuthenticationUseCase(this.repository);

  Future<bool> execute(String ra, String password) async {
    return await repository.login(ra, password);
  }

  Future<void> logout() async {
    return await repository.logout();
  }
}
