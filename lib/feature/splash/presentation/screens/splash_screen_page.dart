import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/resources/assets_manager.dart';
import '../../../signup/presentation/screens/signup_page.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SignupPage()),
        (Route<dynamic> route) => false,
      );
    });
    return Scaffold(
        body: Center(
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AssetsImage.bg,
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Positioned.fill(
              child: SvgPicture.asset(
                AssetsImage.logo,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
