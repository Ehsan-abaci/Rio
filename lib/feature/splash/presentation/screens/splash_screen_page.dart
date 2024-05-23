import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/resources/assets_manager.dart';
import '../../../signup/presentation/screens/signup_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (BuildContext context) => const SignupPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  AssetsImage.bg,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  AssetsImage.logo,
                  fit: BoxFit.scaleDown,
                  width: MediaQuery.sizeOf(context).width * .4,
                ),
              ),
            ],
          ),
        ));
  }
}