import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../widgets/custom_text_field.dart';

class AmountField extends StatelessWidget {
  final TextEditingController controller;

  const AmountField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hint: 'Amount',
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d*\.?\d*'),
        ),
      ],
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter amount';
        }

        final amount = double.tryParse(value);

        if (amount == null || amount <= 0) {
          return 'Amount must be greater than 0';
        }

        return null;
      },
    );
  }
}