import 'package:app_smart_wallet_ifpr/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(135 * 3.1416 / 180),
            colors: [AppColors.loginSecondary, AppColors.loginBlack],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 48,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/reitoria-horizontal-4-logocolorida-letrabranca.png',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(20, 255, 255, 255),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Acesse ao Smart Wallet IFPR:',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            const SizedBox(height: 24),
                            const LoginForm(),
                            const SizedBox(height: 12),
                            TextButton(
                              onPressed: () {
                                // TODO - Recuperar senha
                              },
                              child: const Text(
                                'Esqueceu ou deseja alterar sua senha?',
                                style: TextStyle(color: Colors.white60),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
