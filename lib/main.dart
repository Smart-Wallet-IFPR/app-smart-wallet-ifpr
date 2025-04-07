import 'package:app_smart_wallet_ifpr/app/app_widget.dart';
import 'package:app_smart_wallet_ifpr/modules/auth/data/auth_repository.dart';
import 'package:app_smart_wallet_ifpr/modules/auth/domain/usecases/login_usecase.dart'
    show LoginUseCase;
import 'package:app_smart_wallet_ifpr/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:app_smart_wallet_ifpr/modules/auth/presentation/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppSmartWalletIfpr());
}

class AppSmartWalletIfpr extends StatelessWidget {
  const AppSmartWalletIfpr({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AuthRepository()),
        ProxyProvider<AuthRepository, LoginUseCase>(
          update: (_, repo, __) => LoginUseCase(repo),
        ),
        ChangeNotifierProxyProvider<LoginUseCase, LoginController>(
          create: (_) => LoginController(LoginUseCase(AuthRepository())),
          update: (_, useCase, __) => LoginController(useCase),
        ),
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: const AppWidget(),
    );
  }
}
