import 'package:app_smart_wallet_ifpr/core/routes/app_routes.dart';
import 'package:app_smart_wallet_ifpr/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:app_smart_wallet_ifpr/modules/auth/presentation/controllers/login_controller.dart';
import 'package:app_smart_wallet_ifpr/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _raController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _raController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final loginController = Provider.of<LoginController>(
      context,
      listen: false,
    );
    final authController = Provider.of<AuthController>(context, listen: false);

    final ra = _raController.text.trim();
    final password = _passwordController.text.trim();

    await loginController.login(ra, password).then((result) {
      if (!mounted) return;

      if (!result) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('RA ou senha inválidos!')));

        setState(() {
          _isLoading = false;
        });

        return;
      }

      authController.setLoggedIn(true);
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login efetuado com sucesso!')),
      );

      Navigator.pushReplacementNamed(context, AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Registro Acadêmico',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _raController,
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Informe o RA' : null,
                cursorColor: AppColors.loginSecondary,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.loginSecondary,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Senha',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Informe a senha'
                            : null,
                cursorColor: AppColors.loginSecondary,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.loginSecondary,
                      width: 2,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(171, 26, 240, 151),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              onPressed: _isLoading ? () {} : _submitLogin,
              child:
                  _isLoading
                      ? const SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                      : const Text(
                      'Acessar',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                      ),

                  ),
            ),
          ),
        ],
      ),
    );
  }
}
