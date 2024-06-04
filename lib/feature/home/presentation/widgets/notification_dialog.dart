import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.indexOfGreenSubtitle,
  });
  final String leadingIcon;
  final String title;
  final List<String> subtitle;
  final int indexOfGreenSubtitle;
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
        padding: const EdgeInsets.all(15.0),
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
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: height * .01),
                  RichText(
                    text: TextSpan(children: [
                      for (int i = 0; i < subtitle.length; i++)
                        TextSpan(
                          spellOut: true,
                          text: subtitle[i],
                          style: TextStyle(
                            color: i == indexOfGreenSubtitle
                                ? ColorManager.success
                                : ColorManager.mediumEmphasis,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ]),
                  ),

                  // ...subtitle.map(
                  //   (sub) {
                  //     if (sub != subtitle[indexOfGreenSubtitle]) {
                  //       return RichText(
                  //         text: TextSpan(
                  //           text: sub,
                  //           style: TextStyle(
                  //             color: ColorManager.mediumEmphasis,
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //           children: [
                  //             TextSpan(
                  //               text: subtitle[indexOfGreenSubtitle],
                  //               style: TextStyle(
                  //                 color: ColorManager.success,
                  //                 fontSize: 16,
                  //                 fontWeight: FontWeight.w400,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     }
                  //     return Align();
                  //   },
                  // ),
                  // RichText(
                  //   text: TextSpan(
                  //     text: subtitle,
                  //     style: TextStyle(
                  //       color: ColorManager.mediumEmphasis,
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //     children: [
                  //       TextSpan(
                  //         text: greenSubtitle,
                  //         style: TextStyle(
                  //           color: ColorManager.success,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
