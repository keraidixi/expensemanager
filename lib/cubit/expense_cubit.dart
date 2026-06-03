import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/expense_model.dart';
import 'expense_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit() : super(const ExpenseState()) {
    loadExpensesFromLocal();
  }

  Future<void> loadExpensesFromLocal() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString('expenses');

    if (data != null) {
      final List decoded = jsonDecode(data);

      final expenses = decoded
          .map((e) => Expense.fromJson(e))
          .toList();

      emit(state.copyWith(expenses: expenses));
    }
  }

  Future<void> _saveExpensesToLocal() async {
    final prefs = await SharedPreferences.getInstance();

    final expenseList = state.expenses
        .map((e) => e.toJson())
        .toList();

    await prefs.setString('expenses', jsonEncode(expenseList));
  }

  void addExpense({
    required String title,
    required double amount,
    required String category,
    required DateTime date,
  }) {
    Expense expense = Expense(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      amount: amount,
      category: category,
      date: date,
    );

    List<Expense> expenses = List.from(state.expenses);

    expenses.add(expense);

    expenses.sort((a, b) => b.date.compareTo(a.date));

    emit(state.copyWith(expenses: expenses));

    _saveExpensesToLocal();
  }

  void deleteExpense(String id) {
    List<Expense> expenses = state.expenses
        .where((expense) => expense.id != id)
        .toList();

    emit(state.copyWith(expenses: expenses));

    _saveExpensesToLocal();
  }

  void setFilter(String category) {
    emit(state.copyWith(selectedFilter: category));
  }
}