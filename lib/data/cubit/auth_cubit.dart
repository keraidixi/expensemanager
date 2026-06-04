import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/auth_repository.dart';
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
  final AuthRepository repository;
  final ExpenseCubit expenseCubit;

  AuthCubit(this.repository, this.expenseCubit) : super(AuthInitial());

  Future<void> signUp(
      String email,
      String password,
      String phone,
      String address,
      ) async {
    emit(AuthLoading());

    try {
      await repository.signUp(email, password, phone, address);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      await repository.login(email, password);
      emit(AuthSuccess());
      expenseCubit.loadExpensesFromLocal();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await repository.logout();
    expenseCubit.clearExpenses();
    emit(AuthInitial());
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());

    try {
      await repository.signInWithGoogle();
      emit(AuthSuccess());
      expenseCubit.loadExpensesFromLocal();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  Future<String?> getUserEmail() {
    return repository.getUserEmail();
  }

  Future<String?> getPhone() {
    return repository.getPhone();
  }

  Future<String?> getAddress() {
    return repository.getAddress();
  }

  Future<void> checkLoginStatus() async {
    emit(AuthLoading());

    final bool isLoggedIn = await repository.localStorage.isLoggedIn();

    if (isLoggedIn) {
      emit(AuthSuccess());
    } else {
      emit(AuthInitial());
    }
  }
}