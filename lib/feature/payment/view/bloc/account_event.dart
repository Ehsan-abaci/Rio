part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {}

class AddCreditEvent extends AccountEvent {
  final double credit;
  AddCreditEvent(this.credit);
  @override
  List<Object?> get props => [credit];
}

class AddCouponEvent extends AccountEvent {
  final CouponDetailModel couponDetailModel;
  AddCouponEvent(this.couponDetailModel);
  @override
  List<Object?> get props => [couponDetailModel];
}

class FetchAccountDetailEvent extends AccountEvent {
  @override
  List<Object?> get props => [];
}
