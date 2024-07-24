import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_scooter/core/widgets/error_dialog.dart';

import '../../widgets/processing_modal.dart';

///get  LocationPermission
Future<LatLng> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('سرویس مکان یابی غیرفعال است.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('مجوز دسترسی به موقعیت یابی داده نشد.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('مجوز دسترسی به سرویس لوکیشن داده نشده است.');
  }

  final currentPosition = await Geolocator.getCurrentPosition();

  return LatLng(currentPosition.latitude, currentPosition.longitude);
}

void showProccessingModal(BuildContext context) {
  showAdaptiveDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => const ProcessingModal(),
  );
}

void showErrorDialog(BuildContext context, String title, String desc) {
  showAdaptiveDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => ErrorDialog(
      errorTitle: title,
      errorDesc: desc,
    ),
  );
}

void dismissDialog(BuildContext context) {
  if (_isThereCurrentDialogShowing(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

bool _isThereCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;

String formatNumber(String number) {
  RegExp phoneRegExp = RegExp(r'^9[0-9]{9}$');

  number = number.replaceFirst(RegExp(r'^0+'), '');

  if (phoneRegExp.hasMatch(number.replaceAll(' ', ''))) {
    number = number.replaceAll(' ', '');
    return number
        .replaceAllMapped(RegExp(r".{7}$"), (match) => ' ${match[0]}')
        .replaceAllMapped(RegExp(r".{4}$"), (match) => ' ${match[0]}')
        .replaceAllMapped(RegExp(r".{2}$"), (match) => ' ${match[0]}');
  } else {
    return number;
  }
}
