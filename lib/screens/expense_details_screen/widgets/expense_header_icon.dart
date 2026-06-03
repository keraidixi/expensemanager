import 'package:flutter/material.dart';
import '../../../../widgets/category_icon.dart';

class ExpenseHeaderIcon extends StatelessWidget {
  final String category;

  const ExpenseHeaderIcon({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return CategoryIcon(
      category: category,
      size: 200,
      color: const Color(0xFF958DAA),
    );
  }
}