import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/cubit/expense_cubit.dart';
import '../../../../widgets/custom_button.dart';

class DeleteExpenseButton extends StatelessWidget {
  final String expenseId;

  const DeleteExpenseButton({
    super.key,
    required this.expenseId,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Delete Expense',
      backgroundColor: const Color(0xFFFFDAD6),
      textColor: const Color(0xFFBA1A1A),
      onPressed: () {
        context.read<ExpenseCubit>().deleteExpense(expenseId);
        Navigator.pop(context);
      },
    );
  }
}