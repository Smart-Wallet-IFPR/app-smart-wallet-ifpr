import 'package:app_smart_wallet_ifpr/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:app_smart_wallet_ifpr/modules/auth/presentation/controllers/login_controller.dart';
import 'package:app_smart_wallet_ifpr/modules/auth/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController raController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    raController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    raController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);
    final authController = Provider.of<AuthController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            loginController.isLoading
                ? const Center(child: CircularProgressIndicator())
                : LoginForm(
                  raController: raController,
                  passwordController: passwordController,
                  onSubmit: () async {
                    final success = await loginController.login(
                      raController.text,
                      passwordController.text,
                    );

                    if (!mounted) return;

                    if (success) {
                      await authController.login();
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Falha no login')),
                    );
                  },
                ),
      ),
    );
  }
}
