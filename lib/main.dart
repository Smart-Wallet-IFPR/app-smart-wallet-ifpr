import 'package:app_smart_wallet_ifpr/app/app_widget.dart';
import 'package:app_smart_wallet_ifpr/modules/auth/data/repositories/auth_repository.dart';
import 'package:app_smart_wallet_ifpr/modules/auth/domain/usecases/authentication_usecase.dart'
    show AuthenticationUseCase;
import 'package:app_smart_wallet_ifpr/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:app_smart_wallet_ifpr/modules/auth/presentation/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:provider/provider.dart';
import 'core/network/interceptors/custom_interceptor.dart';
import 'core/widgets/sidebar/sidebar_controller.dart';
import 'modules/request_wallet/data/repositories/request_wallet_repository_impl.dart';
import 'modules/request_wallet/domain/usecases/send_request_usecase.dart';
import 'modules/request_wallet/presentation/controllers/request_wallet_controller.dart';

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
        ProxyProvider<AuthRepository, AuthenticationUseCase>(
          update: (_, repo, __) => AuthenticationUseCase(repo),
        ),
        ChangeNotifierProxyProvider<AuthenticationUseCase, LoginController>(
          create: (context) => LoginController(
            AuthenticationUseCase(context.read<AuthRepository>()),
          ),
          update: (_, useCase, __) => LoginController(useCase),
        ),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProxyProvider<AuthenticationUseCase, SidebarController>(
          create: (context) => SidebarController(
            context.read<AuthenticationUseCase>(),
          ),
          update: (_, useCase, __) => SidebarController(useCase),
        ),
        Provider<RequestWalletRepositoryImpl>(
          create: (context) => RequestWalletRepositoryImpl(context.read<http.Client>()),
        ),
        ProxyProvider<RequestWalletRepositoryImpl, SendRequestUseCase>(
          update: (_, repo, __) => SendRequestUseCase(repo),
        ),
        ChangeNotifierProxyProvider<SendRequestUseCase, RequestWalletController>(
          create: (context) => RequestWalletController(
            context.read<SendRequestUseCase>(),
          ),
          update: (_, useCase, __) => RequestWalletController(useCase),
        ),
      ],
      child: const AppWidget(),
    );
  }
}