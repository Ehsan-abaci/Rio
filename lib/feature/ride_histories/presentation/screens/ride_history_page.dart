import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/extensions.dart';

import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RideHistory {
  Duration duration;
  String distance;
  double price;
  Uint8List? image;
  RideHistory({
    required this.duration,
    required this.distance,
    required this.price,
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
  final sp = di<SharedPreferences>();
  @override
  void initState() {
    List<dynamic> rawData = jsonDecode(sp.getString('ride_image') ?? '[]');

    _rideHistories = rawData.map(
      (e) {
        return RideHistory(
          distance: "6",
          duration: const Duration(minutes: 18),
          price: 4000,
          image: Uint8List.fromList(List<int>.from(e)),
        );
      },
    ).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.surface,
      appBar: AppBar(
        backgroundColor: ColorManager.surface,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20, bottom: 5),
              child: Text(
                "تاریخچه سواری",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
        leading: SvgPicture.asset(
          AssetsIcon.back,
          color: ColorManager.primaryDark,
          matchTextDirection: true,
          fit: BoxFit.scaleDown,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
        ),
        child: ListView(
          children: [
            ..._rideHistories.map(
              (e) => RideHistoryItem(
                duration: e.duration,
                distance: e.distance,
                price: e.price,
                image: e.image,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RideHistoryItem extends StatelessWidget {
  RideHistoryItem({
    super.key,
    // required this.date,
    required this.duration,
    required this.distance,
    required this.price,
    required this.image,
  });

  // DateTime date;
  Duration duration;
  String distance;
  double price;
  Uint8List? image;

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
                      (image != null)
                          ? Image.memory(
                              image!,
                              fit: BoxFit.cover,
                              width: 500,
                            )
                          : Placeholder(),
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
                                    const Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "28 شهریور 1403",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                          TextSpan(
                                            text: "   19:12",
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
                                              "${duration.inMinutes} دقیقه",
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
                                              "${distance}KM",
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
                                      price.toStringAsFixed(0).to3Dot(),
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

