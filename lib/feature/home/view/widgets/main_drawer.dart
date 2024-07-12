import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/extensions.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/widgets/custom_elevated_button.dart';
import 'package:share_scooter/feature/payment/view/bloc/account_bloc.dart';
import 'package:share_scooter/feature/payment/view/screens/credit_payment_page.dart';
import 'package:share_scooter/feature/payment/view/screens/recharge_the_wallet_page.dart';
import 'package:share_scooter/feature/ride_histories/view/bloc/ride_history_bloc.dart';
import 'package:share_scooter/feature/ride_histories/view/screens/ride_history_page.dart';
import 'package:share_scooter/feature/settings/view/screens/setting_page.dart';
import 'package:share_scooter/locator.dart';

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
          _getDrawerHeader(height, width, context),
          _getDrawerBody(context),
        ],
      ),
    );
  }

  Widget _getDrawerBody(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          MenuListTile(
            title: "تاریخچه سواری",
            icon: AssetsIcon.history,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => RideHistoryBloc(di()),
                  child: const RideHistoriesPage(),
                ),
              ),
            ),
          ),
          MenuListTile(
            title: "پرداخت اعتباری",
            icon: AssetsIcon.payment,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreditPaymentPage(),
                  ));
            },
          ),
          MenuListTile(
            title: "اعتبار معرفی به دوستان",
            icon: AssetsIcon.earn,
            onTap: () {},
          ),
          MenuListTile(
            title: "کارت هدیه",
            icon: AssetsIcon.gift,
            onTap: () {},
          ),
          MenuListTile(
            title: "راهنمای ریو",
            icon: AssetsIcon.help,
            onTap: () {},
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
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _getDrawerHeader(double height, double width, BuildContext context) {
    return SizedBox(
      height: height * .4,
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AssetsImage.menuBg,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: width * .075,
            top: height * .13,
            height: height * .1,
            child: const FittedBox(
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
                    "امروز با ریو میخوای سواری داشته یاشی؟",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: width * .075,
            top: height * .26,
            width: width > 500 ? width * .4 : width * .65,
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
                        fit: BoxFit.cover,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const FittedBox(
                                      child: Text(
                                        "اعتبار کیف پول شما",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            wordSpacing: 2,
                                            letterSpacing: 1),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    BlocBuilder<AccountBloc, AccountState>(
                                      builder: (context, state) {
                                        double balance = 0.0;
                                        if (state is AccountComplete) {
                                          balance = state.accountModel.credit;
                                        }
                                        return FittedBox(
                                          child: Text(
                                            "${balance.to3Dot()} تومان (T)",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            CustomElevatedButton(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RechargeTheWalletPage(),
                                  )),
                              content: "شارژ",
                              fontSize: 16,
                              bgColor: ColorManager.surfaceTertiary,
                              frColor: Colors.black,
                              borderRadius: 12,
                              width: width > 500 ? width * .1 : width * .2,
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
    );
  }
}

class MenuListTile extends StatelessWidget {
  const MenuListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final String icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
      ),
      onTap: onTap,
      title: Align(
        alignment: Alignment.bottomRight,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
