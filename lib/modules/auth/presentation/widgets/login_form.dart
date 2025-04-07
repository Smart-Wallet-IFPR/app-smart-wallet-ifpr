import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController raController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;

  const LoginForm({
    super.key,
    required this.raController,
    required this.passwordController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: raController,
          decoration: const InputDecoration(labelText: 'Registro Acadêmico'),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: 'Senha'),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: onSubmit, child: const Text('Entrar')),
      ],
    );
  }
}
