import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_scooter/feature/payment/controller/account_database_controller.dart';
import 'package:share_scooter/feature/payment/model/account_model.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountDatabaseController _databaseController;
  AccountBloc(this._databaseController) : super(AccountInitial()) {
    on<FetchAccountDetailEvent>((event, emit) async {
      emit(AccountLoading());
      try {
        final accountModel = _databaseController.fetchAccountDetails();
        emit(AccountComplete(accountModel));
      } catch (e) {
        log(e.toString());
        emit(AccountError());
      }
    });

    on<AddCreditEvent>((event, emit) async {
      emit(AccountLoading());
      try {
        await _databaseController.addCredit(event.credit);
        final accountModel = _databaseController.fetchAccountDetails();
        emit(AccountComplete(accountModel));
      } catch (e) {
        log(e.toString());

        emit(AccountError());
      }
    });
    on<AddCouponEvent>((event, emit) async {
      emit(AccountLoading());
      try {
        await _databaseController.addCoupon(event.couponDetailModel);
        add(AddCreditEvent(event.couponDetailModel.credit));
        final accountModel = _databaseController.fetchAccountDetails();
        emit(AccountComplete(accountModel));
      } catch (e) {
        log(e.toString());

        emit(AccountError());
      }
    });
  }
}
