part of 'account_bloc.dart';

abstract class AccountState extends Equatable {}

class AccountInitial extends AccountState {
  @override
  List<Object?> get props => [];
}

class AccountLoading extends AccountState {
  @override
  List<Object?> get props => [];
}

class AccountComplete extends AccountState {
  final AccountModel accountModel;
  AccountComplete(this.accountModel);
  @override
  List<Object?> get props => [accountModel];
}

class AccountError extends AccountState {
  @override
  List<Object?> get props => [];
}
