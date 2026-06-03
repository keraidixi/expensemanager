import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/expense_cubit.dart';

class CategoryFilters extends StatelessWidget {
  final String selectedFilter;

  const CategoryFilters({super.key, required this.selectedFilter});

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Food', 'Travel', 'Shopping', 'Bills', 'Entertainment', 'Other'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: categories.map((category) {
          final isSelected = category == selectedFilter;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(category,style: TextStyle(fontSize: 18),),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  context.read<ExpenseCubit>().setFilter(category);
                }
              },
              backgroundColor: const Color(0xFFC4C1CF),
              selectedColor: const Color(0xFF4F4861).withValues(alpha: 0.6),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.transparent),
              ),
              showCheckmark: false,
            ),
          );
        }).toList(),
      ),
    );
  }
}
