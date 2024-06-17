import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';

class BatteryLevelWidget extends StatelessWidget {
  const BatteryLevelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: ShapeDecoration(
        color: ColorManager.surfaceTertiary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetsIcon.level75,
            fit: BoxFit.scaleDown,
          ),
          Text(
            "19 KM",
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: ColorManager.highEmphasis,
            ),
          ),
        ],
      ),
    );
  }
}
