import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/expense_cubit.dart';
import '../../../widgets/custom_button.dart';
import 'amount_field.dart';
import 'category_field.dart';
import 'expense_title_field.dart';

class AddExpenseForm extends StatefulWidget {
  const AddExpenseForm({super.key});

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedCategory;
  final List<String> _categories = [
    'Food',
    'Travel',
    'Shopping',
    'Bills',
    'Entertainment',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _saveExpense() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a category')),
        );
        return;
      }
      final title = _titleController.text;
      final amount = double.tryParse(_amountController.text) ?? 0;

      // Send data to Cubit
      context.read<ExpenseCubit>().addExpense(
        title: title,
        amount: amount,
        category: _selectedCategory!,
        date: DateTime.now(),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ExpenseTitleField(controller: _titleController),

                  const SizedBox(height: 16),

                  AmountField(controller: _amountController),

                  const SizedBox(height: 16),

                  CategoryField(
                    selectedCategory: _selectedCategory,
                    categories: _categories,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          CustomButton(
            text: 'Save Expense',
            onPressed: _saveExpense,
            backgroundColor: const Color(0xFF867F98),
          ),
        ],
      ),
    );
  }
}
