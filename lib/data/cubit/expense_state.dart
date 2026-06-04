import 'package:equatable/equatable.dart';
import '../../models/expense_model.dart';

class ExpenseState extends Equatable {
  final List<Expense> expenses;
  final String selectedFilter;

  const ExpenseState({
    this.expenses = const [],
    this.selectedFilter = 'All',
  });

  ExpenseState copyWith({
    List<Expense>? expenses,
    String? selectedFilter,
  }) {
    return ExpenseState(
      expenses: expenses ?? this.expenses,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }

  double get totalAmount {
    return expenses.fold(0, (sum, item) => sum + item.amount);
  }

  List<Expense> get filteredExpenses {
    if (selectedFilter == 'All') {
      return expenses;
    }
    return expenses.where((e) => e.category == selectedFilter).toList();
  }

  @override
  List<Object?> get props => [expenses, selectedFilter];
}