import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:share_scooter/core/utils/app_prefs.dart';
import 'package:share_scooter/core/utils/constants.dart';
import 'package:share_scooter/feature/payment/model/account_model.dart';

abstract class LoginController {
  Future<void> loginByPhoneNumber(AccountModel data);
}

class LoginControllerImpl extends LoginController {
  final AppPreferences _appPreferences;
  final Box<AccountModel> _accountBox = Hive.box(Constant.accountBox);

  LoginControllerImpl(this._appPreferences);
  @override
  Future<void> loginByPhoneNumber(AccountModel data) async {
    try {
      await _accountBox.add(data);
      await _appPreferences.setIsLoggedIn();
    } catch (e) {
      log(e.toString());
    }
  }
}
