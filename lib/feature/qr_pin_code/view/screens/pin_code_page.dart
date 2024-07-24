import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/utils/resources/routes_manager.dart';
import 'package:share_scooter/core/widgets/custom_elevated_button.dart';
import 'package:share_scooter/feature/qr_pin_code/view/widgets/otp_widget.dart';

class PinCodePage extends StatefulWidget {
  const PinCodePage({super.key});

  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  QRViewController? controller;
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    QRView(
      key: GlobalKey(debugLabel: "qrCode"),
      onQRViewCreated: _onQRViewCreated,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(color: ColorManager.overlay),
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _getAppBar(),
                _getTipContent(width),
                const OtpWidget(),
                _getButtons(height, width, context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getButtons(double height, double width, BuildContext context) {
    return Expanded(
      flex: 2,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: height * .05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FutureBuilder<bool?>(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    log(snapshot.data.toString());
                    var isTurnedOn = snapshot.data ?? false;
                    return CustomElevatedButton(
                      content: "فلاش گوشی",
                      onTap: () async {
                        await controller?.toggleFlash();
                        setState(() {});
                      },
                      icon: AssetsIcon.flashlight,
                      bgColor: isTurnedOn
                          ? ColorManager.surfaceTertiaryReverse
                          : Colors.transparent,
                      frColor: ColorManager.surface,
                      borderRadius: 12,
                      borderColor: ColorManager.border,
                      width: width * .4,
                    );
                  }),
              CustomElevatedButton(
                onTap: () => Navigator.pop(context),
                content: "کد Qr",
                icon: AssetsIcon.code,
                bgColor: Colors.transparent,
                frColor: ColorManager.surface,
                borderRadius: 12,
                borderColor: ColorManager.border,
                width: width * .4,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getAppBar() {
    return Expanded(
      child: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            AssetsIcon.back,
            matchTextDirection: true,
            fit: BoxFit.scaleDown,
            color: ColorManager.surface,
          ),
        ),
        title: SvgPicture.asset(
          AssetsImage.logo,
          color: ColorManager.reversedEmphasis,
          fit: BoxFit.scaleDown,
          width: 70,
        ),
        centerTitle: true,
      ),
    );
  }

  Widget _getTipContent(double width) {
    return Expanded(
      flex: 2,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(
            left: width * .03,
            right: width * .03,
          ),
          child: Text(
            "کد 4 رقمی اسکوتر بر روی فرمان زیر کد QR قرار دارد.",
            style: TextStyle(
                color: ColorManager.surface,
                fontSize: 22,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
