class AuthRepository {
  Future<bool> login(String ra, String password) async {
    // TODO -> Alterar durante integração - Simulando API
    await Future.delayed(const Duration(seconds: 2));
    return ra == '20210002150' && password == '123456';
  }
}
