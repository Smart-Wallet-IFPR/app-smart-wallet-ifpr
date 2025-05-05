import 'package:app_smart_wallet_ifpr/core/routes/app_routes.dart';
import 'package:app_smart_wallet_ifpr/core/widgets/sidebar/sidebar.dart';
import 'package:app_smart_wallet_ifpr/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:app_smart_wallet_ifpr/modules/auth/presentation/pages/login_page.dart';
import 'package:app_smart_wallet_ifpr/modules/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late Future<void> _initAuth;

  @override
  void initState() {
    super.initState();
    _initAuth =
        Provider.of<AuthController>(context, listen: false).checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return FutureBuilder(
      future: _initAuth,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        return MaterialApp(
          title: 'Smart Wallet IFPR',
          home:
              authController.isLoggedIn ? const HomePage() : const LoginPage(),
          routes: {
            AppRoutes.home: (_) => const Sidebar(child: HomePage()),
            AppRoutes.login: (_) => const LoginPage(),
          },
        );
      },
    );
  }
}
