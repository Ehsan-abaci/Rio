import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/widgets/custom_elevated_button.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Drawer(
      backgroundColor: ColorManager.surface,
      width: width * .8,
      child: Column(
        children: [
          SizedBox(
            height: height * .4,
            child: Stack(
              children: [
                Positioned.fill(
                  child: SvgPicture.asset(
                    AssetsImage.menuBg,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  right: width * .075,
                  top: height * .13,
                  height: height * .1,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "سلام احسان",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "امروز میخوای سواری کنی؟",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            wordSpacing: 3
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: width * .075,
                  top: height * .26,
                  width: width * .65,
                  height: height * .1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorManager.walletBg,
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: SvgPicture.asset(
                              AssetsImage.bg,
                              fit: BoxFit.fill,
                              colorFilter: ColorFilter.mode(
                                ColorManager.primaryDark,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * .02, vertical: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              "اعتبار کیف پول RIO",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                wordSpacing: 2,
                                                letterSpacing: 1
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          FittedBox(
                                            child: Text(
                                              "50,000 هزارتومان",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  CustomElevatedButton(
                                    content: "افزایش اعتبار",
                                    fontSize: 12,
                                    bgColor: ColorManager.surfaceTertiary,
                                    frColor: Colors.black,
                                    borderRadius: 12,
                                    width: width * .5,
                                    height: height * .1,
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
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: SvgPicture.asset(
                    AssetsIcon.history,
                  ),
                  title: const Text(
                    "تاریخچه سواری",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    AssetsIcon.payment,
                  ),
                  title: const Text(
                    "روش های پرداخت",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: SvgPicture.asset(
                    AssetsIcon.settings,
                  ),
                  title: const Text(
                    "تنظیمات",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
