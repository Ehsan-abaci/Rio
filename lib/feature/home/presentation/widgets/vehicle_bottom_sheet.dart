import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/widgets/custom_elevated_button.dart';
import 'package:share_scooter/feature/home/presentation/screens/map_page.dart';

class VehicleBottomSheet extends StatelessWidget {
  VehicleBottomSheet({
    super.key,
    required this.selectedScooter,
  });

  Scooter selectedScooter;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      height: height * .3,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: ColorManager.surface,
      ),
      child: Column(
        children: [
          SizedBox(
            height: height * .13,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * .02, horizontal: height * .02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              selectedScooter.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(selectedScooter.id,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: ColorManager.mediumEmphasis,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SvgPicture.asset(AssetsIcon.scooter, width: 60),
                ],
              ),
            ),
          ),
          Divider(height: 0),
          SizedBox(
            height: height * .17,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomElevatedButton(
                  onTap: () {},
                  content: "رزرو کن",
                  icon: AssetsIcon.reservation,
                  bgColor: ColorManager.primary,
                  frColor: ColorManager.white,
                  borderRadius: 12,
                  borderColor: ColorManager.border,
                  width: width,
                  height: height,
                ),
                CustomElevatedButton(
                  onTap: () {},

                  content: "زنگ بزن",
                  icon: AssetsIcon.ring,
                  bgColor: ColorManager.surface,
                  frColor: ColorManager.primaryDark,
                  borderRadius: 12,
                  borderColor: ColorManager.border,
                  width: width,
                  height: height,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
