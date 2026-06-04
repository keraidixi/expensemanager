import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> _saveUserData(
      String email,
      String phone,
      String address,
      ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('email', email);
    await prefs.setString('phone', phone);
    await prefs.setString('address', address);

    if (FirebaseAuth.instance.currentUser != null) {
      await prefs.setString(
        'uid',
        FirebaseAuth.instance.currentUser!.uid,
      );
    }

    await prefs.setBool('isLoggedIn', true);
  }

  Future<void> signUp(
      String email,
      String password,
      String phone,
      String address,
      ) async {
    emit(AuthLoading());

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _saveUserData(email, phone, address);

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Signup Failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login(
      String email,
      String password,
      ) async {
    emit(AuthLoading());

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Login Failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', false);

    emit(AuthInitial());
  }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<String?> getPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('phone');
  }

  Future<String?> getAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('address');
  }

  Future<String?> getUserUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleUser =
      await googleSignIn.signIn();

      if (googleUser == null) {
        emit(AuthInitial());
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final user = userCredential.user;

      if (user != null) {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('email', user.email ?? '');
        await prefs.setString('uid', user.uid);
        await prefs.setBool('isLoggedIn', true);

        emit(AuthSuccess());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}