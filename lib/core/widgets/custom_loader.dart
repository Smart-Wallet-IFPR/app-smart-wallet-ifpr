import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final double size;

  const CustomLoader({super.key, this.size = 32});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white],
          ).createShader(bounds);
        },
        child: const CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
