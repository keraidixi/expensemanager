import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalStorage {

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<String?> _getUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = await _getUid();
    return prefs.getString('email_$uid');
  }

  Future<String?> getPhone() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = await _getUid();
    return prefs.getString('phone_$uid');
  }

  Future<String?> getAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = await _getUid();
    return prefs.getString('address_$uid');
  }

  Future<void> setLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
  }

  Future<bool> isEmailRegistered(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getKeys();

    for (String key in allKeys) {
      if (key.startsWith('email_')) {
        final savedEmail = prefs.getString(key);
        if (savedEmail == email) {
          return true;
        }
      }
    }
    return false;
  }

  Future<void> saveUser({
    required String email,
    required String phone,
    required String address,
    required user,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('uid', user.uid);
    await prefs.setString('email_${user.uid}', email);
    await prefs.setString('phone_${user.uid}', phone);
    await prefs.setString('address_${user.uid}', address);

    await prefs.setBool('isLoggedIn', true);
  }

  Future<void> setCurrentUid(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
  }

  Future<bool> userExists(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('email_$uid');
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }
}