import 'package:flutter_bloc/flutter_bloc.dart';
import 'expense_state.dart';
import '../../models/expense_model.dart';
import '../repository/expense_repository.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final ExpenseRepository repository;

  ExpenseCubit(this.repository) : super(const ExpenseState()) {
    loadExpensesFromLocal();
  }

  Future<void> loadExpensesFromLocal() async {
    final expenses = await repository.loadExpenses();
    emit(state.copyWith(expenses: expenses));
  }

  Future<void> _saveExpensesToLocal() async {
    await repository.saveExpenses(state.expenses);
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
    List<Expense> expenses =
    state.expenses.where((e) => e.id != id).toList();

    emit(state.copyWith(expenses: expenses));

    _saveExpensesToLocal();
  }

  void setFilter(String category) {
    emit(state.copyWith(selectedFilter: category));
  }

  void clearExpenses() {
    emit(const ExpenseState());
  }
}