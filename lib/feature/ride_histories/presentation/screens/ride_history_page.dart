
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';

class RideHistoriesPage extends StatefulWidget {
  const RideHistoriesPage({super.key});

  @override
  State<RideHistoriesPage> createState() => _RideHistoriesPageState();
}

class _RideHistoriesPageState extends State<RideHistoriesPage> {
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
            RideHistoryItem(),
            RideHistoryItem(),
            RideHistoryItem(),
            RideHistoryItem(),
            RideHistoryItem(),
          ],
        ),
      ),
    );
  }
}

class RideHistoryItem extends StatelessWidget {
  const RideHistoryItem({super.key});

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
                  child: Placeholder(),
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
                                    // Text(
                                    //   "28 شهریور 1403    19:12",
                                    // ),
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
                                              "18 دقیقه",
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
                                              "6KM",
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
                                      "4.000000000",
                                      style: TextStyle(
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
