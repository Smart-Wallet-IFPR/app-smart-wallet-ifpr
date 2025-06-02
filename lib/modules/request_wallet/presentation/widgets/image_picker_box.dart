import 'dart:convert';
import 'dart:typed_data';
import 'package:app_smart_wallet_ifpr/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ImagePickerBox extends StatelessWidget {
  final VoidCallback onTap;
  final String? base64Image;

  const ImagePickerBox({
    super.key,
    required this.onTap,
    this.base64Image,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes;
    if (base64Image != null && base64Image!.isNotEmpty) {
      imageBytes = base64Decode(base64Image!);
    }

    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: Container(
          width: 150,
          height: 150,
          color: Colors.white,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (imageBytes != null)
                Image.memory(
                  imageBytes,
                  fit: BoxFit.cover,
                )
              else
                const Center(
                  child: Text(
                    'Selecionar Foto',
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.loginSecondary, width: 2),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}