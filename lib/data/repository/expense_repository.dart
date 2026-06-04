import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/expense_model.dart';

class ExpenseRepository {

  String? get uid => FirebaseAuth.instance.currentUser?.uid;

  String get _key {
    final userId = uid;
    if (userId == null) {
      throw Exception("User not logged in");
    }
    return "expenses_$userId";
  }

  Future<List<Expense>> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);

    if (data == null) return [];

    final List decoded = jsonDecode(data);
    return decoded.map((e) => Expense.fromJson(e)).toList();
  }

  Future<void> saveExpenses(List<Expense> expenses) async {
    final prefs = await SharedPreferences.getInstance();

    final list = expenses.map((e) => e.toJson()).toList();

    await prefs.setString(_key, jsonEncode(list));
  }

  Future<void> clearUserExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}