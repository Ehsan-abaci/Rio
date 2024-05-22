import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';

class NotificationDialog extends StatelessWidget {
  NotificationDialog({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.greenSubtitle,
  });
  String leadingIcon;
  String title;
  String subtitle;
  String greenSubtitle;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      decoration: ShapeDecoration(
        color: ColorManager.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: ShapeDecoration(
                color: ColorManager.surfacePrimary,
                shape: const CircleBorder(),
              ),
              child: SvgPicture.asset(
                leadingIcon,
                fit: BoxFit.scaleDown,
                color: ColorManager.primary,
              ),
            ),
            SizedBox(width: width * .04),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: height * .01),
                  FittedBox(
                    child: RichText(
                      text: TextSpan(
                        text: subtitle,
                        style: TextStyle(
                          color: ColorManager.mediumEmphasis,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: greenSubtitle,
                            style: TextStyle(
                              color: ColorManager.success,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
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
