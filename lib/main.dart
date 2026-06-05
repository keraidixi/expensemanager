import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'data/controller/auth_controller.dart';
import 'data/cubit/auth_cubit.dart';
import 'data/cubit/expense_cubit.dart';

import 'data/repository/auth_repository.dart';
import 'data/repository/expense_repository.dart';

import 'data/services/auth_local_store.dart';


import 'screens/splash_screen/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SpendWiseApp());
}

class SpendWiseApp extends StatelessWidget {
  const SpendWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // EXPENSE CUBIT
        BlocProvider(
          create: (_) => ExpenseCubit(
            ExpenseRepository(),
          ),
        ),

        // AUTH CUBIT (WITH CONTROLLER)
        BlocProvider(
          create: (context) {
            final authRepository = AuthRepository(AuthLocalStorage());

            final authController = AuthController(authRepository);

            final authCubit = AuthCubit(
              authController,
              context.read<ExpenseCubit>(),
            );

            authCubit.checkLoginStatus();

            return authCubit;
          },
        ),
      ],
      child: MaterialApp(
        title: 'SpendWise',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6750A4),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}