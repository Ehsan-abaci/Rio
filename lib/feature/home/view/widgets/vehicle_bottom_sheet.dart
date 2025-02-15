import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/constants.dart';
import 'package:share_scooter/core/utils/extensions.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/widgets/custom_elevated_button.dart';
import 'package:share_scooter/feature/home/view/blocs/battery/battery_bloc.dart';
import 'package:share_scooter/feature/home/view/blocs/ride/ride_bloc.dart';
import 'package:share_scooter/feature/home/view/widgets/battery_level_widget.dart';
import 'package:share_scooter/feature/home/view/widgets/reservation_modal.dart';
import 'package:share_scooter/feature/ride_histories/model/scooter_model.dart';

class VehicleBottomSheet extends StatefulWidget {
  const VehicleBottomSheet({
    super.key,
  });

  @override
  State<VehicleBottomSheet> createState() => _VehicleBottomSheetState();
}

class _VehicleBottomSheetState extends State<VehicleBottomSheet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  @override
  void initState() {
    context.read<BatteryBloc>().add(GetBatteryLevel());
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _animation = Tween<double>(
      end: 0,
      begin: MediaQuery.sizeOf(context).height * -.3,
    ).animate(_animationController);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final Stopwatch _stopwatch = Stopwatch();
  Scooter? selectedScooter;
  double? bottomPadding;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return BlocBuilder<RideBloc, RideState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        Widget? bottomSheetButtons;
        if (state is RideReserving) {
          _animationController.forward();
          selectedScooter = state.selectedScooter;
          bottomSheetButtons = ReserveBottomSheetButtons(width: width);
        } else if (state is RideInProgress) {
          selectedScooter = state.rideDetail?.scooter;
          bottomSheetButtons = RidingBottomSheetButtons(width: width);
        } else if (state is RidePaused) {
          selectedScooter = state.rideDetail?.scooter;
          bottomSheetButtons = PausedBottomSheetButtons(width: width);
        } else if (state is RideReserved) {
          selectedScooter = state.rideDetail?.scooter;
          bottomSheetButtons =
              StartBottomSheetButtons(width: width, stopwatch: _stopwatch);
        } else if (state is RideInitial) {
          _animationController.reverse();
        }
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => Positioned(
            right: 0,
            left: 0,
            bottom: _animation.value,
            height: height * .3,
            child: Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: ColorManager.surface,
              ),
              child: Column(
                children: [
                  _getVehicleDetails(height, state),
                  const Divider(height: 0),
                  SizedBox(
                    height: height * .17,
                    child: bottomSheetButtons,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  SizedBox _getVehicleDetails(double height, RideState state) {
    return SizedBox(
      height: height * .13,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * .025, horizontal: height * .025),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        selectedScooter?.name ?? "Unknow",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "شماره دستگاه : ${selectedScooter?.id} ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ColorManager.mediumEmphasis,
                              ),
                            ),
                            if (state is RideInProgress || state is RidePaused)
                              StreamBuilder<Duration>(
                                stream: Stream.periodic(
                                  const Duration(seconds: 1),
                                  (_) => _stopwatch.elapsed,
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return FittedBox(
                                      child: RichText(
                                        text: TextSpan(
                                          text: " •  ",
                                          style: TextStyle(
                                            color: ColorManager.mediumEmphasis,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: snapshot.data!.toMs(),
                                              style: TextStyle(
                                                fontFamily: Constant.fontFamily,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: state is RideInProgress
                                                    ? ColorManager.success
                                                    : ColorManager.danger,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
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
            const BatteryLevelWidget(),
          ],
        ),
      ),
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomElevatedButton(
          onTap: () {},
          content: "اعلام خرابی",
          icon: AssetsIcon.ring,
          bgColor: ColorManager.surface,
          frColor: ColorManager.primaryDark,
          borderRadius: 12,
          borderColor: ColorManager.border,
          width: width * .4,
        ),
        CustomElevatedButton(
          onTap: () {
            showAdaptiveDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const ReservationModal(),
            );
          },
          content: "رزرو",
          icon: AssetsIcon.reservation,
          bgColor: ColorManager.primary,
          frColor: ColorManager.white,
          borderRadius: 12,
          borderColor: ColorManager.border,
          width: width * .4,
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomElevatedButton(
          onTap: () {},
          content: "بازگشت",
          bgColor: ColorManager.surface,
          frColor: ColorManager.primaryDark,
          borderRadius: 12,
          borderColor: ColorManager.border,
          width: width * .4,
        ),
        CustomElevatedButton(
          onTap: () {
            context.read<RideBloc>().add(StartRidingEvent());
            if (!stopwatch.isRunning) stopwatch.start();
          },
          content: "شروع",
          bgColor: ColorManager.primary,
          frColor: ColorManager.surface,
          borderRadius: 12,
          borderColor: ColorManager.border,
          width: width * .4,
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomElevatedButton(
          onTap: () {
            context.read<RideBloc>().add(StartRidingEvent());
          },
          content: "ادامه",
          icon: AssetsIcon.play,
          bgColor: ColorManager.surface,
          frColor: ColorManager.primaryDark,
          borderRadius: 12,
          borderColor: ColorManager.border,
          width: width * .4,
        ),
        CustomElevatedButton(
          onTap: () {
            context.read<RideBloc>().add(FinishedEvent());
          },
          content: "پایان",
          icon: AssetsIcon.locked,
          bgColor: ColorManager.primary,
          frColor: ColorManager.white,
          borderRadius: 12,
          borderColor: ColorManager.border,
          width: width * .4,
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomElevatedButton(
          onTap: () {
            context.read<RideBloc>().add(PausedEvent());
          },
          content: "توقف",
          icon: AssetsIcon.pause,
          bgColor: ColorManager.surface,
          frColor: ColorManager.primaryDark,
          borderRadius: 12,
          borderColor: ColorManager.border,
          width: width * .4,
        ),
        CustomElevatedButton(
          onTap: () {
            context.read<RideBloc>().add(FinishedEvent());
          },
          content: "پایان",
          icon: AssetsIcon.locked,
          bgColor: ColorManager.primary,
          frColor: ColorManager.white,
          borderRadius: 12,
          borderColor: ColorManager.border,
          width: width * .4,
        ),
      ],
    );
  }
}
