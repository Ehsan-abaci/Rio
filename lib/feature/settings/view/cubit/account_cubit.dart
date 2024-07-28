import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_scooter/feature/payment/model/account_model.dart';
import 'package:share_scooter/feature/settings/controller/account_controller.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AccountController _accountController;

  AccountCubit(this._accountController) : super(AccountState());

  getAccountInfo() {
    final data = _accountController.getAccountInfo();
    emit(state.copyWith(account: data));
  }
}
