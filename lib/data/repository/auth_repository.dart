import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/auth_local_store.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthLocalStorage localStorage;

  AuthRepository(this.localStorage);

  String? get currentUid {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  Future<void> signUp(
      String email,
      String password,
      String phone,
      String address,
      ) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await localStorage.saveUser(
      email: email,
      phone: phone,
      address: address,
      user: result.user,
    );
  }

  Future<void> login(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = result.user;

    if (user != null) {
      await localStorage.saveUser(
        email: email,
        phone: await localStorage.getPhone() ?? '',
        address: await localStorage.getAddress() ?? '',
        user: user,
      );
    }

    await localStorage.setLogin(true);
  }
  Future<void> logout() async {
    await _auth.signOut();
    await localStorage.clearUserData();
    await localStorage.setLogin(false);
  }

  Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw Exception("Cancelled");
    }
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final result = await _auth.signInWithCredential(credential);
    final user = result.user;

    if (user != null) {
      await localStorage.saveUser(
        email: user.email ?? '',
        phone: '',
        address: '',
        user: user,
      );

      await localStorage.setLogin(true);
    }
  }

  Future<String?> getUserEmail() {
    return localStorage.getUserEmail();
  }

  Future<String?> getPhone() {
    return localStorage.getPhone();
  }

  Future<String?> getAddress() {
    return localStorage.getAddress();
  }
}