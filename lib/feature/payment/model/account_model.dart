class AccountModel {
  double credit;
  CardDetailModel? card;
  List<CouponDetailModel?> coupons;
  AccountModel({
    this.credit = 50000.0,
    required this.card,
    required this.coupons,
  });

  AccountModel copyWith({
    double? credit,
    CardDetailModel? card,
    List<CouponDetailModel?>? coupons,
  }) {
    return AccountModel(
      credit: credit ?? this.credit,
      card: card ?? this.card,
      coupons: coupons ?? this.coupons,
    );
  }
}

class CardDetailModel {
  String cardName;
  String cardNumber;
  String cardMonthDate;
  String cardYearDate;
  String cardCvv2;
  CardDetailModel({
    required this.cardName,
    required this.cardNumber,
    required this.cardMonthDate,
    required this.cardYearDate,
    required this.cardCvv2,
  });
}

class CouponDetailModel {
  String couponName;
  double credit;
  CouponDetailModel({
    required this.couponName,
    required this.credit,
  });
}
