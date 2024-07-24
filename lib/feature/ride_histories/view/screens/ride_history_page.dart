import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/extensions.dart';

import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/utils/resources/routes_manager.dart';
import 'package:share_scooter/core/widgets/animate_in_effect.dart';
import 'package:share_scooter/core/widgets/custom_appbar_widget.dart';
import 'package:share_scooter/feature/ride_histories/model/ride_history_model.dart';
import 'package:share_scooter/feature/ride_histories/view/bloc/ride_history_bloc.dart';
import 'package:share_scooter/feature/ride_histories/view/screens/ride_details_page.dart';
import 'package:share_scooter/feature/ride_histories/view/widgets/ride_image.dart';

class RideHistoriesPage extends StatelessWidget {
  const RideHistoriesPage({super.key});

  void loadData(BuildContext context) {
    context.read<RideHistoryBloc>().add(FetchRideHisyoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.appBg,
      appBar: const CustomAppBarWidget(title: "تاریخچه سواری"),
      body: BlocBuilder<RideHistoryBloc, RideHistoryState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is CompleteState) {
            if (state.rideHistories.isEmpty) {
              return const Center(
                child: Text("There is no ride"),
              );
            } else {
              return RioRideHistoryScrollView(
                rideHistories: state.rideHistories,
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class RioRideHistoryScrollView extends StatelessWidget {
  RioRideHistoryScrollView({
    super.key,
    required this.rideHistories,
  });
  List<RideHistoryModel> rideHistories;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: rideHistories.length,
          itemBuilder: (context, i) => AnimateInEffect(
            intervalStart: (i / rideHistories.length),
            keepAlive: true,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                Routes.rideDetailRoute,
                arguments: rideHistories[i],
              ),
              child: RideHistoryItem(
                rideHistory: rideHistories[i],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RideHistoryItem extends StatelessWidget {
  const RideHistoryItem({
    super.key,
    required this.rideHistory,
  });

  final RideHistoryModel rideHistory;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Center(
      child: SizedBox(
        width: width * .85,
        height: height * .3,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * .02,
          ),
          child: Card(
            elevation: 5,
            surfaceTintColor: ColorManager.surface,
            color: ColorManager.surface,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                getRideImage(rideHistory.img),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: width * .02,
                      left: width * .02,
                      top: height * .01,
                      bottom: height * .01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: height * .1,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "28 شهریور 1403",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                          TextSpan(
                                            text:
                                                rideHistory.startTime.toTime(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: height * .02),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              AssetsIcon.clock,
                                              color: ColorManager.placeholder,
                                              width: 14,
                                            ),
                                            SizedBox(width: 2),
                                            Text(
                                              "${Duration(milliseconds: rideHistory.durationInMilliSeconds!).inMinutes} دقیقه",
                                              style: TextStyle(
                                                  color:
                                                      ColorManager.placeholder,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                        SizedBox(width: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SvgPicture.asset(
                                              AssetsIcon.distance,
                                              color: ColorManager.placeholder,
                                              width: 14,
                                            ),
                                            SizedBox(width: 2),
                                            Text(
                                              "${6}KM",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: ColorManager.placeholder,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      textDirection: TextDirection.ltr,
                                      rideHistory.totalCost!.to3Dot(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        overflow: TextOverflow.ellipsis,
                                        color: ColorManager.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    " تومان",
                                    style: TextStyle(
                                        color: ColorManager.primary,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                              SvgPicture.asset(
                                AssetsIcon.right,
                                matchTextDirection: true,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
