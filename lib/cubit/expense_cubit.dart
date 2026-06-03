import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/expense_model.dart';
import 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit() : super(const ExpenseState());

  void addExpense({
    required String title,
    required double amount,
    required String category,
    required DateTime date,
  }) {
    // Create new expense
    Expense expense = Expense(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      amount: amount,
      category: category,
      date: date,
    );

    // Copy old expense list
    List<Expense> expenses = List.from(state.expenses);

    // Add new expense
    expenses.add(expense);

    // Sort by latest date
    expenses.sort((a, b) => b.date.compareTo(a.date));

    // Update state
    emit(state.copyWith(expenses: expenses));
  }

  void deleteExpense(String id) {
    List<Expense> expenses = state.expenses
        .where((expense) => expense.id != id)
        .toList();

    emit(state.copyWith(expenses: expenses));
  }

  void setFilter(String category) {
    emit(state.copyWith(selectedFilter: category));
  }
}
