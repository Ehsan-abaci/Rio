import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/utils/resources/functions.dart';
import 'package:share_scooter/feature/home/view/blocs/battery/battery_bloc.dart';

class BatteryLevelWidget extends StatelessWidget {
  const BatteryLevelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double? btLevel;
    String? icon;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: ShapeDecoration(
        color: ColorManager.surfaceTertiary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: BlocConsumer<BatteryBloc, BatteryState>(
        listenWhen: (previous, current) => previous is BatteryLoading || current is BatteryLoading,
        listener: (context, state) {
          log(state.toString());
          if (state is BatteryLoading) {
            showProccessingModal(context);
          } else {
            dismissDialog(context);
          }
        },
        builder: (context, state) {
          if (state is BatteryComplete) {
            btLevel = state.batteryModel.level;
          }
          if (btLevel != null) {
            if (btLevel! > 75) {
              icon = AssetsIcon.level100;
            } else if (btLevel! > 50) {
              icon = AssetsIcon.level75;
            } else if (btLevel! > 25) {
              icon = AssetsIcon.level50;
            } else {
              icon = AssetsIcon.level25;
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icon!,
                  fit: BoxFit.scaleDown,
                ),
                Text(
                  "${btLevel!.toStringAsFixed(0)} KM",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: ColorManager.highEmphasis,
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
