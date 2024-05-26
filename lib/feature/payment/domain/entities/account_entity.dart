
class AccountEntity {
  double credit;
  CardDetailEntity? card;
  List<CouponDetailEntity?> coupons;
  AccountEntity({
    this.credit = 50000.0,
    required this.card,
    required this.coupons,
  });

  AccountEntity copyWith({
    double? credit,
    CardDetailEntity? card,
    List<CouponDetailEntity?>? coupons,
  }) {
    return AccountEntity(
      credit: credit ?? this.credit,
      card: card ?? this.card,
      coupons: coupons ?? this.coupons,
    );
  }
}

class CardDetailEntity {
  String cardName;
  String cardNumber;
  String cardMonthDate;
  String cardYearDate;
  String cardCvv2;
  CardDetailEntity({
    required this.cardName,
    required this.cardNumber,
    required this.cardMonthDate,
    required this.cardYearDate,
    required this.cardCvv2,
  });
}

class CouponDetailEntity {
  String couponName;
  double credit;
  CouponDetailEntity({
    required this.couponName,
    required this.credit,
  });
}
