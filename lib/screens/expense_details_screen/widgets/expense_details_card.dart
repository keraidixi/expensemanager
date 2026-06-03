import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../models/expense_model.dart';

class ExpenseDetailsCard extends StatelessWidget {
  final Expense expense;

  const ExpenseDetailsCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );
    final dateFormatter = DateFormat('MMM d, yyyy');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            expense.title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Amount',
            style: TextStyle(fontSize: 22,),
          ),
          const SizedBox(height: 4),
          Text(
            currencyFormatter.format(expense.amount),
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Category',
            style: TextStyle(fontSize: 22,),
          ),
          const SizedBox(height: 4),
          Text(
            expense.category,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Date',
            style: TextStyle(fontSize: 22 ,),
          ),
          const SizedBox(height: 4),
          Text(
            dateFormatter.format(expense.date),
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
