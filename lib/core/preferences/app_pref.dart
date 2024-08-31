import 'package:shared_preferences/shared_preferences.dart';
const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String FIRST_LOAD = "FIRST_LOAD";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  //first load
  Future<void> setFirstLoad() async {
    _sharedPreferences.setBool(FIRST_LOAD, true);
  }

  Future<bool> isFirstLoad() async {
    return _sharedPreferences.getBool(FIRST_LOAD) ?? false;
  }

  //login
  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
  }

  //Token
  Future<bool> setToken(String key, String token) async {
    return await _sharedPreferences.setString(key, token);
  }

  String? getToken(String key) {
    return _sharedPreferences.getString(key);
  }
}