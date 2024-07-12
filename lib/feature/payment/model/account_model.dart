// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

part 'account_model.g.dart';

@HiveType(typeId: 2)
class AccountModel {
  @HiveField(0)
  double credit;
  @HiveField(1)
  CardDetailModel? card;
  @HiveField(2)
  List<CouponDetailModel>? coupons;
  AccountModel({
    this.credit = 0.0,
    this.card,
    this.coupons,
  });

  AccountModel copyWith({
    double? credit,
    CardDetailModel? card,
    List<CouponDetailModel>? coupons,
  }) {
    return AccountModel(
      credit: credit ?? this.credit,
      card: card ?? this.card,
      coupons: coupons ?? this.coupons,
    );
  }
}

@HiveType(typeId: 3)
class CardDetailModel {
  @HiveField(0)
  String cardName;
  @HiveField(1)
  String cardNumber;
  @HiveField(2)
  String cardMonthDate;
  @HiveField(3)
  String cardYearDate;
  @HiveField(4)
  String cardCvv2;
  CardDetailModel({
    required this.cardName,
    required this.cardNumber,
    required this.cardMonthDate,
    required this.cardYearDate,
    required this.cardCvv2,
  });

  CardDetailModel copyWith({
    String? cardName,
    String? cardNumber,
    String? cardMonthDate,
    String? cardYearDate,
    String? cardCvv2,
  }) {
    return CardDetailModel(
      cardName: cardName ?? this.cardName,
      cardNumber: cardNumber ?? this.cardNumber,
      cardMonthDate: cardMonthDate ?? this.cardMonthDate,
      cardYearDate: cardYearDate ?? this.cardYearDate,
      cardCvv2: cardCvv2 ?? this.cardCvv2,
    );
  }
}

@HiveType(typeId: 4)
class CouponDetailModel {
  @HiveField(0)
  String couponName;
  @HiveField(1)
  double credit;
  CouponDetailModel({
    required this.couponName,
    required this.credit,
  });

  CouponDetailModel copyWith({
    String? couponName,
    double? credit,
  }) {
    return CouponDetailModel(
      couponName: couponName ?? this.couponName,
      credit: credit ?? this.credit,
    );
  }
}
