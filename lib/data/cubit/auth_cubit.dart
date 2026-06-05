import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/auth_controller.dart';
import 'expense_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  final AuthController controller;
  final ExpenseCubit expenseCubit;

  AuthCubit(this.controller, this.expenseCubit) : super(AuthInitial());

  // SIGNUP
  Future<void> signUp(
      String email,
      String password,
      String phone,
      String address,
      ) async {
    emit(AuthLoading());

    try {
      await controller.signUp(email, password, phone, address);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // LOGIN
  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      await controller.login(email, password);

      emit(AuthSuccess());

      // reload expenses after login
      expenseCubit.loadExpensesFromLocal();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await controller.logout();

    expenseCubit.clearExpenses();

    emit(AuthInitial());
  }

  // GOOGLE LOGIN
  Future<void> signInWithGoogle() async {
    emit(AuthLoading());

    try {
      await controller.signInWithGoogle();

      emit(AuthSuccess());

      expenseCubit.loadExpensesFromLocal();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // PROFILE DATA
  Future<String?> getUserEmail() => controller.getUserEmail();
  Future<String?> getPhone() => controller.getPhone();
  Future<String?> getAddress() => controller.getAddress();

  // CHECK LOGIN STATUS
  Future<void> checkLoginStatus() async {
    emit(AuthLoading());

    final isLoggedIn = await controller.isLoggedIn();

    if (isLoggedIn) {
      emit(AuthSuccess());
    } else {
      emit(AuthInitial());
    }
  }
}