import 'package:flutter/material.dart';
import '../../../../widgets/custom_text_field.dart';

class ExpenseTitleField extends StatelessWidget {
  final TextEditingController controller;

  const ExpenseTitleField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hint: 'Expense Title',
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a title';
        }
        return null;
      },
    );
  }
}