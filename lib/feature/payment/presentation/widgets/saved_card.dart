import 'package:flutter/material.dart';
import '../../../../core/utils/resources/assets_manager.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class SavedCard extends StatelessWidget {
  const SavedCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Container(
      margin: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFFEC4E4E), Color(0xFFEA3A8E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        image: const DecorationImage(
          image: AssetImage(AssetsImage.bgGiftCard),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            "SAVED CARD",
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: ColorManager.reversedEmphasis),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "There is no any card that defined your account.  You must define one to start riding",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorManager.reversedEmphasis),
          ),
          const SizedBox(
            height: 16,
          ),
          CustomElevatedButton(
            content: "ADD NEW CARD",
            fontSize: 16,
            bgColor: ColorManager.surfaceTertiary,
            frColor: ColorManager.reversedEmphasis,
            borderRadius: 8,
            width: width * .3,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
