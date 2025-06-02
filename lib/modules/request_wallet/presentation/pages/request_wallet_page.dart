import 'package:app_smart_wallet_ifpr/modules/request_wallet/presentation/controllers/request_wallet_controller.dart';
import 'package:app_smart_wallet_ifpr/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/image_picker_box.dart';
import '../widgets/text_input.dart';
import '../widgets/custom_dropdown_menu.dart';

class RequestWalletPage extends StatelessWidget {
  const RequestWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RequestWalletController>();

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            ImagePickerBox(
              onTap: controller.pickImage,
              base64Image: controller.base64Image,
            ),
            const SizedBox(height: 16),
            TextInputField(
              label: 'Nome',
              controller: controller.nameController,
            ),
            const SizedBox(height: 16),
            TextInputField(
              label: 'Ano de Ingresso',
              controller: controller.yearController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            CustomDropdownMenu(
              value: controller.selectedCourse,
              onChanged: (value) {
                controller.selectedCourse = value;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: controller.submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.loginSecondary,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                  'Enviar Solicitação',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}