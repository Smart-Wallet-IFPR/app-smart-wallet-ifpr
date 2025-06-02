import 'package:flutter/material.dart';

import '../../data/models/dropdown_items.dart';

class CustomDropdownMenu extends StatelessWidget {
  final int? value;
  final void Function(int?) onChanged;

  const CustomDropdownMenu({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: value,
      onChanged: onChanged,
      items: DropdownItems.values.map((item) {
        return DropdownMenuItem<int>(
          value: item.index,
          child: Text(item.label),
        );
      }).toList(),
      decoration: const InputDecoration(
        labelText: 'Curso / Série',
        border: OutlineInputBorder(),
      ),
    );
  }
}