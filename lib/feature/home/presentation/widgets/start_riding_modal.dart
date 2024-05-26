import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/widgets/custom_elevated_button.dart';

class StartRidingModal extends StatelessWidget {
  const StartRidingModal({super.key});

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
                padding: EdgeInsets.symmetric(
                    vertical: height * .01, horizontal: width * .04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset(
                          AssetsIcon.start,
                          height: 32,
                          color: ColorManager.primaryExtraLight,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "بزن بریم !",
                          style: TextStyle(
                            color: ColorManager.highEmphasis,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "قفل الکترونیکی دستگاه باز شده و همین حالا میتونی از سواری لذت ببری.",
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
           const Divider(height: 0),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 const SizedBox(width: 10),
                  CustomElevatedButton(
                    content: "شروع سواری",
                    fontSize: 16,
                    bgColor: ColorManager.surfacePrimary,
                    frColor: ColorManager.primaryDark,
                    borderRadius: 8,
                    width: width * .35,
                    onTap: () {
                      Navigator.pop(context);
                    },
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
