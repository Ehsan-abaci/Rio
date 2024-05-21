import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/widgets/custom_elevated_button.dart';
import 'package:share_scooter/feature/home/presentation/blocs/ride/ride_bloc.dart';
import 'package:share_scooter/feature/home/presentation/screens/map_page.dart';
import 'package:share_scooter/feature/home/presentation/widgets/reservation_modal.dart';

class VehicleBottomSheet extends StatefulWidget {
  VehicleBottomSheet({
    super.key,
    required this.selectedScooter,
  });
  Scooter selectedScooter;

  @override
  State<VehicleBottomSheet> createState() => _VehicleBottomSheetState();
}

class _VehicleBottomSheetState extends State<VehicleBottomSheet> {
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
                  SvgPicture.asset(
                    AssetsIcon.scooter,
                    width: 60,
                    matchTextDirection: true,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.selectedScooter.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "شماره دستگاه : ${widget.selectedScooter.id}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: ColorManager.mediumEmphasis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 0),
          SizedBox(
            height: height * .17,
            child: BlocBuilder<RideBloc, RideState>(
              builder: (context, state) {
                if (state is Reserving) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomElevatedButton(
                        onTap: () {},
                        content: "اعلام خرابی",
                        icon: AssetsIcon.ring,
                        bgColor: ColorManager.surface,
                        frColor: ColorManager.primaryDark,
                        borderRadius: 12,
                        borderColor: ColorManager.border,
                        width: width * .8,
                      ),
                      CustomElevatedButton(
                        onTap: () {
                          showAdaptiveDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => ReservationModal(),
                          );
                        },
                        content: "رزرو",
                        icon: AssetsIcon.reservation,
                        bgColor: ColorManager.primary,
                        frColor: ColorManager.white,
                        borderRadius: 12,
                        borderColor: ColorManager.border,
                        width: width * .8,
                      ),
                    ],
                  );
                } else if (state is ReadyToRide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomElevatedButton(
                        onTap: () {
                          context.read<RideBloc>().add(SetRiding());
                        },
                        content: "شروع",
                        bgColor: ColorManager.surface,
                        frColor: ColorManager.primaryDark,
                        borderRadius: 12,
                        borderColor: ColorManager.border,
                        width: width * .8,
                      ),
                      CustomElevatedButton(
                        onTap: () {},
                        content: "بازگشت",
                        bgColor: ColorManager.primary,
                        frColor: ColorManager.white,
                        borderRadius: 12,
                        borderColor: ColorManager.border,
                        width: width * .8,
                      ),
                    ],
                  );
                } else if (state is Riding) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomElevatedButton(
                        onTap: () {
                          context.read<RideBloc>().add(SetPaused());
                        },
                        content: "توقف",
                        icon: AssetsIcon.pause,
                        bgColor: ColorManager.primary,
                        frColor: ColorManager.white,
                        borderRadius: 12,
                        borderColor: ColorManager.border,
                        width: width * .8,
                      ),
                      CustomElevatedButton(
                        onTap: () {},
                        content: "پایان",
                        bgColor: ColorManager.surface,
                        frColor: ColorManager.primaryDark,
                        borderRadius: 12,
                        borderColor: ColorManager.border,
                        width: width * .8,
                      ),
                    ],
                  );
                } else if (state is Paused) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomElevatedButton(
                        onTap: () {},
                        content: "پایان",
                        icon: AssetsIcon.vehicleBox,
                        bgColor: ColorManager.surface,
                        frColor: ColorManager.primaryDark,
                        borderRadius: 12,
                        borderColor: ColorManager.border,
                        width: width * .8,
                      ),
                      CustomElevatedButton(
                        onTap: () {
                          context.read<RideBloc>().add(SetRiding());
                        },
                        content: "ادامه",
                        icon: AssetsIcon.play,
                        bgColor: ColorManager.primary,
                        frColor: ColorManager.white,
                        borderRadius: 12,
                        borderColor: ColorManager.border,
                        width: width * .8,
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
