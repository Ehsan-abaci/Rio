import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_scooter/feature/home/presentation/screens/map_page.dart';
import '../../../../core/utils/resources/assets_manager.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../payment/presentation/screens/credit_payment_page.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
        body: Center(
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                AssetsImage.bgSignup,
                fit: BoxFit.cover,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  ),
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
                      Text(
                        "بهترین راه برای رسیدن به مقصد",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: ColorManager.highEmphasis,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "از سفر با وسایل نقلیه دوستدار محیط زیست لذت ببرید. همین حالا شروع کنید.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.highEmphasis,
                          height: 1.8,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Column(
                        children: [
                          CustomElevatedButton(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MapPage(),
                                )),
                            content: "ورود با شماره همراه",
                            fontSize: 16,
                            bgColor: ColorManager.primary,
                            frColor: Colors.white,
                            borderRadius: 12,
                            width: width,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomElevatedButton(
                            onTap: () {},
                            content: "ورود با شماره دانشجویی",
                            fontSize: 16,
                            bgColor: ColorManager.highEmphasis,
                            frColor: Colors.white,
                            borderRadius: 12,
                            width: width,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
