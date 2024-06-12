import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/constants.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/feature/home/presentation/blocs/bloc/ride_bloc.dart';

class NotificationDialog extends StatefulWidget {
  const NotificationDialog({
    super.key,
  });

  @override
  State<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Positioned(
      right: width * .1,
      left: width * .1,
      top: height * .15,
      child: BlocBuilder<RideBloc, RideState>(
        builder: (context, state) {
          _animationController
            ..reset()
            ..forward();
          String? leadingIcon;
          String? title;
          List<String>? subtitle;
          int? indexOfGreenSubtitle;
          if (state is RideReserved) {
            leadingIcon = AssetsIcon.reservation;
            title = "یک اسکوتر رزرو کرده اید";
            subtitle = [
              "هزینه شما تا الان: ",
              "${state.rideDetail.totalCost} T"
            ];
            indexOfGreenSubtitle = 1;
          } else if (state is RideInProgress) {
            leadingIcon = AssetsIcon.navigation;
            title = "درحال سواری هستید";
            subtitle = [
              "هزینه شما تا الان: ",
              "${state.rideDetail.totalCost} T"
            ];
            indexOfGreenSubtitle = 1;
          } else if (state is RidePaused) {
            leadingIcon = AssetsIcon.pause;
            title = "سواری متوقف شده است";
            subtitle = [
              'زمانی که دستگاه متوقف است؛ به علت مصرف باتری و عدم اجاره مجدد اسکوتر، به ازای هر دقیقه هزینه ',
              "\nT 100.0",
              ' برای شما لحاظ می شود'
            ];
            indexOfGreenSubtitle = 1;
          } else {
            return const Align();
          }
          return Container(
            decoration: ShapeDecoration(
              color: ColorManager.surface,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
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
                        FadeTransition(
                          opacity: _opacityAnimation,
                          child: RichText(
                            text: TextSpan(children: [
                              for (int i = 0; i < subtitle.length; i++)
                                TextSpan(
                                  spellOut: true,
                                  text: subtitle[i],
                                  style: TextStyle(
                                    fontFamily: Constant.fontFamily,
                                    color: i == indexOfGreenSubtitle
                                        ? ColorManager.success
                                        : ColorManager.mediumEmphasis,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                            ]),
                          ),
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
        },
      ),
    );
  }
}
