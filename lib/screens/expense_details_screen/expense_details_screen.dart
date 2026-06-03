import 'package:flutter/material.dart';
import '../../models/expense_model.dart';
import 'widgets/expense_details_card.dart';
import 'widgets/expense_header_icon.dart';
import 'widgets/delete_expense_button.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  final Expense expense;

  const ExpenseDetailsScreen({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFC3C1C1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
       ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      SizedBox(height: 32),

                      ExpenseHeaderIcon(
                        category: expense.category,
                      ),

                      SizedBox(height: 48),

                      ExpenseDetailsCard(
                        expense: expense,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(24),
              child: DeleteExpenseButton(
                expenseId: expense.id,
              ),
            ),
          ],
        ),
      ),
    );
  }
}