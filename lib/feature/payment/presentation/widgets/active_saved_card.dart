import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share_scooter/core/utils/extensions.dart';
import '../../../../core/utils/resources/assets_manager.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class ActiveSavedCard extends StatelessWidget {
  const ActiveSavedCard({super.key});

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
                Expanded(
                  child: Text(
                    "08/25",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: ColorManager.reversedEmphasis),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 3,
                  child: Text(
                    "6104337624493415".toCardNumberHider(),
                    maxLines: 1,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: ColorManager.reversedEmphasis),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
