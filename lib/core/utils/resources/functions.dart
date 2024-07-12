import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../widgets/processing_modal.dart';

GlobalKey _loadinDialogKey = GlobalKey();

///get  LocationPermission
Future<LatLng> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  final currentPosition = await Geolocator.getCurrentPosition();

  return LatLng(currentPosition.latitude, currentPosition.longitude);
}

void showProcssingModal(BuildContext context) {
  showAdaptiveDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => ProcessingModal(
      key: _loadinDialogKey,
    ),
  );
}

void dismissDialog(BuildContext context) {
  if (_isThereCurrentDialogShowing(_loadinDialogKey)) {
    log("dismiss");
    Navigator.pop(context);
  }
}

bool _isThereCurrentDialogShowing(GlobalKey key) => key.currentContext != null;
