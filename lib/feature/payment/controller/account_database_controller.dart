import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:share_scooter/core/utils/constants.dart';
import 'package:share_scooter/feature/payment/model/account_model.dart';

abstract class AccountDatabaseController {
  Future<void> addCredit(double data);
  Future<void> addCoupon(CouponDetailModel data);
  AccountModel fetchAccountDetails();
}

class AccountDatabaseControllerImpl extends AccountDatabaseController {
  static Box<AccountModel> accountBox = Hive.box(Constant.accountBox);

  @override
  Future<void> addCoupon(CouponDetailModel data) async {
    var account = accountBox.getAt(0) ?? AccountModel();
    account = account.copyWith(coupons: account.coupons?..add(data));
    await accountBox.clear();
    await accountBox.add(account);
  }

  @override
  Future<void> addCredit(double data) async {
    var account = AccountModel();
    if (accountBox.isNotEmpty) {
      account = accountBox.getAt(0)!;
    }
    account = account.copyWith(credit: account.credit + data);
    await accountBox.clear();
    await accountBox.add(account);
  }

  @override
  AccountModel fetchAccountDetails() {
    if (accountBox.isEmpty) {
      return AccountModel();
    } else {
      return accountBox.getAt(0)!;
    }
  }
}
