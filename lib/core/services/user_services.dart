import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  final _sharedPref = SharedPreferencesAsync();

  ///Check user login, true if already login other wise false
  Future<bool> checkLoginStatus() async {
    if (await _sharedPref.getBool('login') ?? false) {
      return true;
    }
    return false;
  }

  ///Update login status
  Future<void> updateLoginStatus(bool isVerified) async {
    await _sharedPref.setBool('login', isVerified);
  }

  ///Function to check user authenticate and update login status
  Future<bool> login(String email, String password) async {
    if (email == 'user@gmail.com' && password == '123456') {
      await updateLoginStatus(true);
      return true;
    }
    return false;
  }
}
