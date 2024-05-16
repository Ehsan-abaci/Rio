
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/widgets/custom_elevated_button.dart';

class ReservationModal extends StatelessWidget {
  const ReservationModal({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Dialog(
      child: Container(
        height: height * .3,
        width: width * .75,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: ColorManager.surface,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: SvgPicture.asset(
                        AssetsIcon.reservation,
                        height: 32,
                        color: ColorManager.primaryExtraLight,
                      ),
                    ),
                    SizedBox(height: 4),
                    Expanded(
                      child: FittedBox(
                        child: Text(
                          "بیا الان رزروش کن",
                          style: TextStyle(
                              color: ColorManager.highEmphasis,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "رزروشرزروشرزروشرزروشرزروشرزروشرزروشرزروشبیا الان رزروش کن",
                        style: TextStyle(
                          color: ColorManager.mediumEmphasis,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 0,),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  CustomElevatedButton(
                    content: "رزرو کردن",
                    fontSize: 16,
                    bgColor: ColorManager.surfacePrimary,
                    frColor: ColorManager.primaryDark,
                    borderRadius: 8,
                    width: width * .6,
                    height: height * .5,
                    onTap: () {},
                  ),
                  SizedBox(width: 10),
                  CustomElevatedButton(
                    content: "لغو کردن",
                    fontSize: 16,
                    bgColor: ColorManager.surface,
                    frColor: ColorManager.primaryDark,
                    borderColor: ColorManager.border,
                    borderRadius: 8,
                    width: width * .6,
                    height: height * .5,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
