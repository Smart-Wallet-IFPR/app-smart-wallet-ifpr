import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/request_wallet_model.dart';
import '../../domain/usecases/send_request_usecase.dart';

class RequestWalletController extends ChangeNotifier {
  final SendRequestUseCase useCase;
  final ImagePicker _picker = ImagePicker();

  String? base64Image;
  final nameController = TextEditingController();
  final yearController = TextEditingController();
  int? selectedCourse;

  RequestWalletController(this.useCase);

  Future<void> pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await File(picked.path).readAsBytes();
      base64Image = base64Encode(bytes);
      notifyListeners();
    }
  }

  Future<void> submit() async {
    if (base64Image == null || selectedCourse == null) return;

    final model = RequestWalletModel(
      base64Image: base64Image!,
      name: nameController.text,
      yearEntry: yearController.text,
      courseOrSerie: selectedCourse!,
    );

    await useCase(model);
  }
}