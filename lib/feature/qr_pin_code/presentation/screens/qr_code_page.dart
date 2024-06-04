import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/widgets/custom_elevated_button.dart';
import 'package:share_scooter/feature/home/presentation/widgets/reservation_modal.dart';
import 'package:share_scooter/feature/home/presentation/widgets/ring_modal.dart';
import 'package:share_scooter/feature/home/presentation/widgets/start_riding_modal.dart';
import 'package:share_scooter/feature/qr_pin_code/presentation/screens/pin_code_page.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: _buildQrView(context)),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              leading: SvgPicture.asset(
                AssetsIcon.back,
                matchTextDirection: true,
                fit: BoxFit.scaleDown,
                color: ColorManager.surface,
              ),
              title: SvgPicture.asset(
                AssetsImage.logo,
                color: ColorManager.reversedEmphasis,
                fit: BoxFit.scaleDown,
                width: 70,
              ),
              centerTitle: true,
            ),
          ),
          Positioned(
            top: height * .2,
            left: width * .03,
            right: width * .03,
            child: FittedBox(
              child: Text(
                " کد QR روی اسکوتر را برای شروع  اسکن کنید",
                style: TextStyle(
                    color: ColorManager.surface,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: height * .05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FutureBuilder<bool?>(
                    future: controller?.getFlashStatus(),
                    builder: (context, snapshot) {
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
                  onTap: () {
                    controller?.pauseCamera();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PinCodePage(
                            controller: controller!,
                          ),
                        )).then(
                      (_) => controller?.resumeCamera(),
                    );
                  },
                  content: "کد دستگاه",
                  icon: AssetsIcon.keyboard,
                  bgColor: Colors.transparent,
                  frColor: ColorManager.surface,
                  borderRadius: 12,
                  borderColor: ColorManager.border,
                  width: width * .4,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: ColorManager.success,
          borderRadius: 10,
          borderLength: 75,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          log(result?.code ?? "");
          log(result?.format.formatName ?? "");
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
