import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share_scooter/core/utils/extensions.dart';
import 'package:share_scooter/feature/payment/presentation/screens/recharge_the_wallet_page.dart';
import '../../../../core/utils/resources/assets_manager.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class WalletBalance extends StatelessWidget {
  const WalletBalance({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      margin: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorManager.walletBg,
        image: const DecorationImage(
          image: AssetImage(AssetsImage.bgCard),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            "موجودی کیف پول",
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: ColorManager.highEmphasis),
          ),
          const SizedBox(
            height: 8,
          ),
          FittedBox(
            child: Text(
              "${50000.0.to3Dot()} T",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w800,
                  color: ColorManager.highEmphasis),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          CustomElevatedButton(
            content: "شارژ اعتبار",
            fontSize: 16,
            bgColor: ColorManager.surfaceTertiary,
            frColor: ColorManager.highEmphasis,
            borderRadius: 8,
            width: width * .3,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RechargeTheWalletPage(),
                )),
          ),
        ],
      ),
    );
  }
}
