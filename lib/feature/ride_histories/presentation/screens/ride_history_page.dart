import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/extensions.dart';

import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/widgets/custom_appbar_widget.dart';
import 'package:share_scooter/feature/ride_histories/domain/entities/ride_detail_entity.dart';
import 'package:share_scooter/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RideHistory {
  Duration? duration;
  DateTime? startTime;
  String? distance;
  double? price;
  String? image;
  RideHistory({
    this.duration,
    this.startTime,
    this.distance,
    this.price,
    this.image,
  });
}

class RideHistoriesPage extends StatefulWidget {
  const RideHistoriesPage({super.key});

  @override
  State<RideHistoriesPage> createState() => _RideHistoriesPageState();
}

class _RideHistoriesPageState extends State<RideHistoriesPage> {
  List<RideHistory> _rideHistories = [];
  List<dynamic> rawData = [];
  List<RideDetailEntity> rideDetails = [];
  final sp = di<SharedPreferences>();
  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    final jsonString = sp.getString('RIDE_HISTORY') ?? '[]';
    rawData = jsonDecode(jsonString);
    // rideDetails = rawData.map((e) => RideDetailEntity.fromJson(e)).toList();

    _rideHistories = rideDetails
        .map(
          (e) => RideHistory(
            distance: "6",
            startTime: e.startTime,
            duration: e.duration ?? Duration.zero,
            price: e.totalCost ?? 0.0,
            image: e.img,
          ),
        )
        .toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.surface,
      appBar: const CustomAppBarWidget(title: "تاریخچه سواری"),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
        ),
        child: _rideHistories.isEmpty
            ? const Center(child: CircularProgressIndicator.adaptive())
            : ListView(
                children: [
                  ..._rideHistories.map(
                    (e) => RideHistoryItem(rideHistory: e),
                  ),
                ],
              ),
      ),
    );
  }
}

class RideHistoryItem extends StatelessWidget {
  const RideHistoryItem({
    super.key,
    required this.rideHistory,
  });

  final RideHistory rideHistory;

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
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      (rideHistory.image != null)
                          ? Image.memory(
                              Uint8List.fromList(
                                  base64Decode(rideHistory.image!).toList()),
                              fit: BoxFit.cover,
                              width: 500,
                            )
                          : const Placeholder(),
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: ColorManager.appBg,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: SvgPicture.asset(
                            AssetsIcon.scooterAlt,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                                                "   ${rideHistory.startTime?.hour}:${rideHistory.startTime?.minute}",
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
                                              "${rideHistory.duration?.inMinutes} دقیقه",
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
                                              "${rideHistory.distance}KM",
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
                                      rideHistory.price
                                          // .toStringAsFixed(0)
                                          !
                                          .to3Dot(),
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
