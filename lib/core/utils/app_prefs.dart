import 'package:hive/hive.dart';
import 'package:share_scooter/core/utils/constants.dart';
import 'package:share_scooter/feature/payment/model/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_IS_LOGGED_IN = 'PREFS_KEY_IS_LOGGED_IN';

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  static Box<AccountModel> accountBox = Hive.box(Constant.accountBox);

  AppPreferences(this._sharedPreferences);

  Future<void> setIsLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_IS_LOGGED_IN, true);
  }

  bool isLoggedIn() {
    return _sharedPreferences.getBool(PREFS_KEY_IS_LOGGED_IN) ?? false;
  }

  Future<void> logout() async {
    await accountBox.clear();
    await _sharedPreferences.remove(PREFS_KEY_IS_LOGGED_IN);
  }
}
