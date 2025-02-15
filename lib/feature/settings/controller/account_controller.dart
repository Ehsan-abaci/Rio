import 'package:hive/hive.dart';
import 'package:share_scooter/core/utils/constants.dart';
import 'package:share_scooter/feature/payment/model/account_model.dart';

abstract class AccountController {
  AccountModel getAccountInfo();
}

class AccountControllerImpl implements AccountController {
  final Box<AccountModel> _accountBox = Hive.box(Constant.accountBox);

  @override
  AccountModel getAccountInfo() {
    return _accountBox.values.first;
  }
}
