import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/constants.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/widgets/custom_elevated_button.dart';
import 'package:share_scooter/feature/home/view/blocs/bloc/ride_bloc.dart';
import 'package:share_scooter/feature/home/view/widgets/ring_modal.dart';

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
                          AssetsIcon.reservation,
                          height: 32,
                          color: ColorManager.primaryExtraLight,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "تاییدیه رزرو",
                          style: TextStyle(
                            color: ColorManager.highEmphasis,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      flex: 2,
                      child: RichText(
                        text: TextSpan(
                          text: "رزرو اسکوتر با هزینه ",
                          style: TextStyle(
                            color: ColorManager.mediumEmphasis,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: "500 T/min",
                              style: TextStyle(
                                fontFamily: Constant.fontFamily,
                                color: ColorManager.success,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: " را تائید نمائید.",
                              style: TextStyle(
                                color: ColorManager.mediumEmphasis,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            )
                          ],
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
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    CustomElevatedButton(
                      content: "تائید",
                      fontSize: 16,
                      bgColor: ColorManager.surfacePrimary,
                      frColor: ColorManager.primaryDark,
                      borderRadius: 8,
                      width: width * .2,
                      onTap: () {
                        context.read<RideBloc>().add(ReservedEvent());
                        Navigator.pop(context);
                        showAdaptiveDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const RingModal(),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    CustomElevatedButton(
                      content: "لغو",
                      fontSize: 16,
                      bgColor: ColorManager.surface,
                      frColor: ColorManager.primaryDark,
                      borderColor: ColorManager.border,
                      borderRadius: 8,
                      width: width * .2,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
