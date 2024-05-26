import 'package:flutter/material.dart';
import 'package:share_scooter/core/utils/extensions.dart';
import '../../../../core/utils/resources/assets_manager.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class CreditCardsWidget extends StatelessWidget {
  const CreditCardsWidget({
    super.key,
    this.activeSavedCard = false,
    this.activeGiftCredit = false,
    this.walletBalance = false,
    this.giftCredit = false,
    this.savedCard = false,
  });

  final bool activeSavedCard;
  final bool activeGiftCredit;
  final bool walletBalance;
  final bool giftCredit;
  final bool savedCard;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      margin: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: savedCard == true
            ? const LinearGradient(
                colors: [Color(0xFFEC4E4E), Color(0xFFEA3A8E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: walletBalance == true
            ? ColorManager.walletBg
            : giftCredit == true
                ? ColorManager.lemonYellow
                : ColorManager.danger,
        image: DecorationImage(
          image: AssetImage(walletBalance || giftCredit == true
              ? AssetsImage.bgCard
              : AssetsImage.bgGiftCard),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: activeSavedCard == true
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomElevatedButton(
                      content: "UPDATE",
                      fontSize: 16,
                      bgColor: ColorManager.surfaceTertiary,
                      frColor: ColorManager.reversedEmphasis,
                      borderRadius: 8,
                      width: width * .3,
                      onTap: () {},
                      icon: AssetsIcon.edit,
                    ),
                    Text(
                      "SAVED CARD",
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: ColorManager.reversedEmphasis),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  "Bora Dan",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: ColorManager.reversedEmphasis),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "08/25",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: ColorManager.reversedEmphasis),
                    ),
                    Text(
                      "6104337624493415".toCardNumberHider(),
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: ColorManager.reversedEmphasis),
                    ),
                  ],
                )
              ],
            )
          : activeGiftCredit == true
              ? Column(
                  children: [
                    Text(
                      "AVAILABLE RIO COUPONS",
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: walletBalance || giftCredit == true
                              ? ColorManager.highEmphasis
                              : ColorManager.reversedEmphasis),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "کد تخفیف اولین سفر",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: ColorManager.highEmphasis),
                        ),
                        Text(
                          "10.000 T",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ColorManager.highEmphasis),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(
                      height: 20,
                      color: ColorManager.border,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "اعتبار معرفی به دوستان",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: ColorManager.highEmphasis),
                        ),
                        Text(
                          "25.000 T",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ColorManager.highEmphasis),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomElevatedButton(
                      content: walletBalance == true
                          ? "شارژ اعتبار"
                          : giftCredit == true
                              ? "افزودن کد"
                              : "ADD NEW CARD",
                      fontSize: 16,
                      bgColor: ColorManager.surfaceTertiary,
                      frColor: walletBalance || giftCredit == true
                          ? ColorManager.highEmphasis
                          : ColorManager.reversedEmphasis,
                      borderRadius: 8,
                      width: width * .3,
                      onTap: () {},
                    ),
                  ],
                )
              : Column(
                  children: [
                    Text(
                      walletBalance == true
                          ? "موجودی کیف پول"
                          : giftCredit == true
                              ? "اعتبار هدیه ریو"
                              : "SAVED CARD",
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: walletBalance || giftCredit == true
                              ? ColorManager.highEmphasis
                              : ColorManager.reversedEmphasis),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      walletBalance == true
                          ? "${50000.0.to3Dot()} T"
                          : giftCredit == true
                              ? "تاکنون هیچکدام از معرفی شدگان شما سواری نداشته اند!"
                              : "There is no any card that defined your account.  You must define one to start riding",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: savedCard || giftCredit == true ? 16 : 48,
                          fontWeight: savedCard || giftCredit == true
                              ? FontWeight.w500
                              : FontWeight.w800,
                          color: walletBalance || giftCredit == true
                              ? ColorManager.highEmphasis
                              : ColorManager.reversedEmphasis),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomElevatedButton(
                      content: walletBalance == true
                          ? "شارژ اعتبار"
                          : giftCredit == true
                              ? "افزودن کد"
                              : "ADD NEW CARD",
                      fontSize: 16,
                      bgColor: ColorManager.surfaceTertiary,
                      frColor: walletBalance || giftCredit == true
                          ? ColorManager.highEmphasis
                          : ColorManager.reversedEmphasis,
                      borderRadius: 8,
                      width: width * .3,
                      onTap: () {},
                    ),
                  ],
                ),
    );
  }
}
