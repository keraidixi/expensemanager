import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/expense_cubit.dart';
import '../../cubit/expense_state.dart';
import '../add_expense_screen/add_expense_screen.dart';
import 'widgets/expense_card.dart';
import 'widgets/home_header.dart';
import 'widgets/category_filters.dart';
import 'widgets/empty_state.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpendWise',style: TextStyle(fontSize: 28),),
        centerTitle: true,
        backgroundColor: Color(0xFFC4C1CF),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }, icon: Icon(Icons.person))
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ExpenseCubit, ExpenseState>(
          builder: (context, state) {
            return Column(
              children: [
                HomeHeader(
                  totalCount: state.expenses.length,
                  totalAmount: state.totalAmount,
                ),
                CategoryFilters(selectedFilter: state.selectedFilter),
                const SizedBox(height: 16),
                Expanded(
                  child: state.filteredExpenses.isEmpty
                      ? const EmptyState()
                      : ListView.builder(
                          itemCount: state.filteredExpenses.length,
                          itemBuilder: (context, index) {
                            return ExpenseCard(
                              expense: state.filteredExpenses[index],
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
          );
        },
        backgroundColor: const Color(0xFFE5E2EC),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add, color: Colors.black87),
      ),
    );
  }
}
