import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/resources/network_info.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/widgets/custom_elevated_button.dart';
import 'package:share_scooter/feature/signup/view/screens/signup_page.dart';
import 'package:share_scooter/feature/splash/view/cubit/network_connection_cubit.dart';
import 'package:share_scooter/locator.dart';
import '../../../../core/utils/resources/assets_manager.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    _checkConnection();
    super.initState();
  }

  void _checkConnection() {
    context.read<NetworkConnectionCubit>().checkNetworkConnection();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: BlocBuilder<NetworkConnectionCubit, NetworkConnectionState>(
        builder: (context, state) {
          if (state is NetworkConnectionSuccess) {
            Future.delayed(
                const Duration(seconds: 2),
                () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const SignupPage(),
                      ),
                    ));
          }
          return Center(
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
                if (state is NetworkConnectionError)
                  Positioned(
                    right: w * .08,
                    left: w * .08,
                    bottom: h * 0,
                    height: h * .4,
                    child: _getConnectionError(h, w),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _getConnectionError(double h, double w) {
    return Column(
      children: [
        const Text(
          "مشکل در برقراری ارتباط",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          "در برقراری ارتباط با شبکه مشکلی پیش آمده لطفا از وجود دسترسی به شبکه مطمئن و مجددا تلاش کنید",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: h * .2,
        ),
        CustomElevatedButton(
          content: "تلاش مجدد",
          fontSize: 16,
          bgColor: ColorManager.primary,
          frColor: Colors.white,
          borderRadius: 12,
          width: w,
          onTap: _checkConnection,
        ),
      ],
    );
  }
}
