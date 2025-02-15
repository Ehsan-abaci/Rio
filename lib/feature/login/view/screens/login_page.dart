import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_scooter/core/utils/resources/routes_manager.dart';
import 'package:share_scooter/core/widgets/scroll_column_expandable.dart';
import '../../../../core/utils/resources/assets_manager.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              AssetsImage.bgSignup,
              fit: BoxFit.cover,
            )),
        Positioned.fill(
          child: ScrollColumnExpandable(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.24,
                  ),
                  child: SvgPicture.asset(
                    AssetsImage.logo,
                    fit: BoxFit.scaleDown,
                    width: width * .4,
                  ).animate().scale(duration: 500.ms),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.08,
                    right: width * 0.08,
                    bottom: height * 0.04,
                  ),
                  child: Column(
                    children: [
                      FittedBox(
                        child: Text(
                          "بهترین راه برای رسیدن به مقصد",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: ColorManager.highEmphasis,
                          ),
                        )
                            .animate()
                            .fade(duration: 500.ms)
                            .slideY(duration: 500.ms),
                      ),
                      SizedBox(height: height * .025),
                      Text(
                        "از سفر با وسایل نقلیه دوستدار محیط زیست لذت ببرید. همین حالا شروع کنید.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.highEmphasis,
                        ),
                      )
                          .animate()
                          .fade(delay: 500.ms, duration: 500.ms)
                          .slideY(delay: 700.ms, duration: 500.ms),
                      SizedBox(
                        height: height * .05,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomElevatedButton(
                            onTap: () => Navigator.pushNamed(
                              context,
                              Routes.loginByPhoneNumberRoute,
                            ),
                            content: "ورود با شماره همراه",
                            fontSize: 16,
                            bgColor: ColorManager.primary,
                            frColor: Colors.white,
                            borderRadius: 12,
                            width: width,
                          )
                              .animate()
                              .slideY(end: 0, begin: 1, duration: 500.ms),
                          SizedBox(
                            height: height * .02,
                          ),
                          CustomElevatedButton(
                            onTap: null,
                            content: "ورود با شماره دانشجویی",
                            fontSize: 16,
                            bgColor: ColorManager.highEmphasis,
                            frColor: Colors.white,
                            borderRadius: 12,
                            width: width,
                          ).animate().slideY(
                              end: 0,
                              begin: 10,
                              duration: 700.ms,
                              delay: 500.ms),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
