// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'account_cubit.dart';



class AccountState extends Equatable {
  AccountModel? account;
  AccountState({
    this.account,
  });
  @override
  List<Object?> get props => [account];

  AccountState copyWith({
    AccountModel? account,
  }) {
    return AccountState(
      account: account ?? this.account,
    );
  }
}
