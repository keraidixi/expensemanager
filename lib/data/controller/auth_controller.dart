import '../repository/auth_repository.dart';

class AuthController {
  final AuthRepository repository;

  AuthController(this.repository);

  // Signup
  Future<void> signUp(
      String email,
      String password,
      String phone,
      String address,
      ) async {
    await repository.signUp(email, password, phone, address);
  }

  // Login
  Future<void> login(String email, String password) async {
    await repository.login(email, password);
  }

  // Logout
  Future<void> logout() async {
    await repository.logout();
  }

  // Google Login
  Future<void> signInWithGoogle() async {
    await repository.signInWithGoogle();
  }

  // Profile data
  Future<String?> getUserEmail() => repository.getUserEmail();
  Future<String?> getPhone() => repository.getPhone();
  Future<String?> getAddress() => repository.getAddress();

  // expose storage for login check
  Future<bool> isLoggedIn() => repository.localStorage.isLoggedIn();
}