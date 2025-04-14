import 'package:app_smart_wallet_ifpr/app/app_widget.dart';
import 'package:app_smart_wallet_ifpr/modules/auth/data/auth_repository.dart';
import 'package:app_smart_wallet_ifpr/modules/auth/domain/usecases/login_usecase.dart'
    show LoginUseCase;
import 'package:app_smart_wallet_ifpr/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:app_smart_wallet_ifpr/modules/auth/presentation/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:provider/provider.dart';
import 'core/network/interceptors/custom_interceptor.dart';

void main() {
  runApp(const AppSmartWalletIfpr());
}

class AppSmartWalletIfpr extends StatelessWidget {
  const AppSmartWalletIfpr({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = InterceptedClient.build(
      interceptors: [CustomInterceptor()],
    );

    return MultiProvider(
      providers: [
        Provider(create: (_) => httpClient),
        Provider<AuthRepository>(
          create: (context) => AuthRepository(client: context.read<http.Client>()),
        ),
        ProxyProvider<AuthRepository, LoginUseCase>(
          update: (_, repo, __) => LoginUseCase(repo),
        ),
        ChangeNotifierProxyProvider<LoginUseCase, LoginController>(
          create: (context) => LoginController(
            LoginUseCase(context.read<AuthRepository>()),
          ),
          update: (_, useCase, __) => LoginController(useCase),
        ),
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: const AppWidget(),
    );
  }
}
