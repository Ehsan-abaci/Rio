import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:share_scooter/core/utils/constants.dart';
import 'package:share_scooter/feature/payment/model/account_model.dart';

abstract class LoginController {
  Future<void> loginByPhoneNumber(AccountModel data);
}

class LoginControllerImpl extends LoginController {
  final Box<AccountModel> _accountBox = Hive.box(Constant.accountBox);

  LoginControllerImpl();
  @override
  Future<void> loginByPhoneNumber(AccountModel data) async {
    try {
      await _accountBox.add(data);
    } catch (e) {
      log(e.toString());
    }
  }
}
