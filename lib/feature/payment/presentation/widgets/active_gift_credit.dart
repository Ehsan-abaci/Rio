import 'package:flutter/material.dart';
import '../../../../core/utils/resources/assets_manager.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class ActiveGiftCredit extends StatelessWidget {
  const ActiveGiftCredit({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
        margin: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorManager.lemonYellow,
          image: const DecorationImage(
            image: AssetImage(AssetsImage.bgCard),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              "AVAILABLE RIO COUPONS",
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: ColorManager.highEmphasis),
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
              content: "افزودن کد",
              fontSize: 16,
              bgColor: ColorManager.surfaceTertiary,
              frColor: ColorManager.highEmphasis,
              borderRadius: 8,
              width: width * .3,
              onTap: () {},
            ),
          ],
        ));
  }
}
