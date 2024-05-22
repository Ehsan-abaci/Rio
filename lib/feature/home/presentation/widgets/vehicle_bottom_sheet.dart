import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/extensions.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/widgets/custom_elevated_button.dart';
import 'package:share_scooter/feature/home/presentation/blocs/bloc/ride_bloc.dart';
import 'package:share_scooter/feature/home/presentation/screens/map_page.dart';
import 'package:share_scooter/feature/home/presentation/widgets/reservation_modal.dart';

class VehicleBottomSheet extends StatefulWidget {
  VehicleBottomSheet({
    super.key,
    // required this.selectedScooter,
  });

  @override
  State<VehicleBottomSheet> createState() => _VehicleBottomSheetState();
}

class _VehicleBottomSheetState extends State<VehicleBottomSheet> {
  final Stopwatch _stopwatch = Stopwatch();
  late Scooter selectedScooter;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<RideBloc, RideState>(
      builder: (context, state) {
        Widget? bottomSheetButtons;
        if (state is RideReserving) {
          selectedScooter = state.selectedScooter;
          bottomSheetButtons = ReserveBottomSheetButtons(width: width);
        } else if (state is RideInProgress) {
          selectedScooter = state.rideDetail.scooter;
          bottomSheetButtons = RidingBottomSheetButtons(width: width);
        } else if (state is RidePaused) {
          selectedScooter = state.rideDetail.scooter;
          bottomSheetButtons = PausedBottomSheetButtons(width: width);
        } else if (state is RideReserved) {
          selectedScooter = state.rideDetail.scooter;
          bottomSheetButtons = StartBottomSheetButtons(
            width: width,
            stopwatch: _stopwatch,
          );
        } else
          return SizedBox();
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
                                  selectedScooter.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      Text(
                                        "شماره دستگاه : ${selectedScooter.id} ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: ColorManager.mediumEmphasis,
                                        ),
                                      ),
                                      if (state is RideInProgress ||
                                          state is RidePaused)
                                        StreamBuilder<Duration>(
                                          stream: Stream.periodic(
                                            const Duration(seconds: 1),
                                            (_) => _stopwatch.elapsed,
                                          ),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData)
                                              return SizedBox();
                                            return Text(
                                              snapshot.data!.toMs(),
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: state is RideInProgress
                                                    ? ColorManager.success
                                                    : ColorManager.danger,
                                              ),
                                            );
                                          },
                                        ),
                                    ],
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
                child: bottomSheetButtons,
              ),
            ],
          ),
        );
      },
    );
  }
}

class ReserveBottomSheetButtons extends StatelessWidget {
  const ReserveBottomSheetButtons({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
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
  }
}

class StartBottomSheetButtons extends StatelessWidget {
  const StartBottomSheetButtons({
    super.key,
    required this.width,
    required this.stopwatch,
  });

  final double width;
  final Stopwatch stopwatch;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomElevatedButton(
          onTap: () {},
          content: "بازگشت",
          bgColor: ColorManager.primary,
          frColor: ColorManager.white,
          borderRadius: 12,
          borderColor: ColorManager.border,
          width: width * .8,
        ),
        CustomElevatedButton(
          onTap: () {
            context.read<RideBloc>().add(StartRidingEvent());
            if (!stopwatch.isRunning) stopwatch.start();
          },
          content: "شروع",
          bgColor: ColorManager.surface,
          frColor: ColorManager.primaryDark,
          borderRadius: 12,
          borderColor: ColorManager.border,
          width: width * .8,
        ),
      ],
    );
  }
}

class PausedBottomSheetButtons extends StatelessWidget {
  const PausedBottomSheetButtons({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomElevatedButton(
          onTap: () {
            context.read<RideBloc>().add(StartRidingEvent());
          },
          content: "ادامه",
          icon: AssetsIcon.play,
          bgColor: ColorManager.primary,
          frColor: ColorManager.white,
          borderRadius: 12,
          borderColor: ColorManager.border,
          width: width * .8,
        ),
        CustomElevatedButton(
          onTap: () {
            context.read<RideBloc>().add(FinishedEvent());
          },
          content: "پایان",
          bgColor: ColorManager.surface,
          frColor: ColorManager.primaryDark,
          borderRadius: 12,
          borderColor: ColorManager.border,
          width: width * .8,
        ),
      ],
    );
  }
}

class RidingBottomSheetButtons extends StatelessWidget {
  const RidingBottomSheetButtons({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomElevatedButton(
          onTap: () {
            context.read<RideBloc>().add(PausedEvent());
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
  }
}
