import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/widgets/low_level_circle_button.dart';
import 'package:share_scooter/feature/home/presentation/blocs/ride/ride_bloc.dart';
import 'package:share_scooter/feature/home/presentation/widgets/main_drawer.dart';
import 'package:share_scooter/feature/home/presentation/widgets/vehicle_bottom_sheet.dart';
import 'package:share_scooter/feature/qr_code/presentation/screens/qr_code_page.dart';

import 'package:share_scooter/line_anim.dart';
import 'package:share_scooter/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Scooter {
  String id;
  String name;
  LatLng location;
  Scooter({
    required this.id,
    required this.name,
    required this.location,
  });
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {
  Scooter? selectedScooter;
  List<Scooter> scooters = [
    Scooter(
      id: "#1",
      name: "Apple Scooter",
      location: const LatLng(36.304436, 59.594230),
    ),
    Scooter(
      id: "#2",
      name: "Apple Scooter",
      location: const LatLng(36.304436, 57.594230),
    ),
    Scooter(
      name: "Apple Scooter",
      id: "#3",
      location: const LatLng(36.304436, 58.594230),
    ),
    Scooter(
      name: "Apple Scooter",
      id: "#4",
      location: const LatLng(38.304436, 59.594230),
    ),
  ];

  LatLng? currentLocation;
  late MapController mapController;

  EasyAnimationController? animator = EasyAnimationController();
  final GlobalKey previewContainer = GlobalKey();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    mapController = MapController();
    if (mounted) {
      _determinePosition();
    }
  }


  @override
  void dispose() {
    mapController.dispose();

    super.dispose();
  }

  ///get  LocationPermission
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
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

    currentLocation =
        LatLng(currentPosition.latitude, currentPosition.longitude);
    setState(() {});
  }

  selecetScooter(Scooter scooter) {
    context.read<RideBloc>().add(SetReserving(scooter: scooter));
    mapController.fitCamera(
      CameraFit.bounds(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 200),
        minZoom: 2,
        maxZoom: 15,
        bounds: LatLngBounds(
          scooter.location,
          currentLocation!,
        ),
      ),
    );
    mapController.rotate(0);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final bottomSheetHeight = height * .3;
    return BlocBuilder<RideBloc, RideState>(
      builder: (context, state) {
        Widget? bottomSheet;
        if (state is Reserving) {
          selectedScooter = state.scooter;
          bottomSheet = VehicleBottomSheet(
            selectedScooter: selectedScooter!,
          );
        } 
        else if (state is Riding) {
          bottomSheet = VehicleBottomSheet(
            selectedScooter: state.rideDetail.scooter,
          );
        } 
        else if (state is Paused) {
          bottomSheet = VehicleBottomSheet(
            selectedScooter: state.rideDetail.scooter,
          );
        } 
        else if (state is ReadyToRide) {
          bottomSheet = VehicleBottomSheet(
            selectedScooter: state.rideDetail.scooter,
          );
        } 
        else {
          selectedScooter = null;
          bottomSheet = null;
        }
        return PopScope(
          canPop: bottomSheet == null,
          onPopInvoked: (didPop) {
            if (bottomSheet != null) {
              context.read<RideBloc>().add(SetInitial());
            }
            return;
          },
          child: Scaffold(
              key: _scaffoldKey,
              bottomSheet: bottomSheet,
              body: Stack(
                children: [
                  Positioned.fill(
                    bottom: bottomSheet != null ? bottomSheetHeight - 20 : 0.0,
                    right: 0,
                    left: 0,
                    child: RepaintBoundary(
                      key: previewContainer,
                      child: FlutterMap(
                        mapController: mapController,
                        options: const MapOptions(
                          keepAlive: true,
                          initialZoom: 16,
                        ),
                        children: [
                          TileLayer(
                            tileProvider:
                                const FMTCStore('mapStore').getTileProvider(),
                            keepBuffer: 100,
                            urlTemplate:
                                'https://api.mapbox.com/styles/v1/hamidaslami2/clob8flgd012t01qsdwnf70md/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaGFtaWRhc2xhbWkyIiwiYSI6ImNsbm9wcm5idjAyaWUya255enF0bmZyNnoifQ.eD-IuFdTBd9rDEgqyPyQEA',
                          ),
                          CurrentLocationLayer(
                            alignPositionOnUpdate: AlignOnUpdate.once,
                            alignDirectionOnUpdate: AlignOnUpdate.never,
                            style: LocationMarkerStyle(
                              marker: Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 5,
                                      blurRadius: 5)
                                ], color: Colors.white, shape: BoxShape.circle),
                                child: Container(
                                  margin: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                      color: Colors.blueAccent,
                                      shape: BoxShape.circle),
                                ),
                              ),
                              markerSize: const Size.square(25),
                              accuracyCircleColor:
                                  Colors.blueAccent.withOpacity(0.1),
                              headingSectorColor:
                                  Colors.blueAccent.withOpacity(0.8),
                              headingSectorRadius: 50,
                            ),
                            moveAnimationDuration:
                                Duration.zero, // disable animation
                          ),
                          MarkerLayer(
                            markers: [
                              ...scooters.map(
                                (e) => Marker(
                                  width: 70,
                                  height: 70,
                                  point: e.location,
                                  child: GestureDetector(
                                    onTap: () {
                                      selecetScooter(e);
                                    },
                                    child: SvgPicture.asset(
                                      e.id == selectedScooter?.id
                                          ? AssetsIcon.selectedPoint
                                          : AssetsIcon.point,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fromRect(
                    rect: Rect.fromLTWH(0, 0, width, height * .12),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ColorManager.white,
                            ColorManager.white.withOpacity(.7),
                            ColorManager.white.withOpacity(.3),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                              child: SvgPicture.asset(
                                AssetsIcon.menu,
                                color: ColorManager.primaryDark,
                              ),
                            ),
                            SvgPicture.asset(
                              AssetsImage.logo,
                              width: width * .2,
                              color: ColorManager.primaryDark,
                            ),
                            SvgPicture.asset(
                              AssetsIcon.coupon,
                              color: ColorManager.primaryDark,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: (bottomSheet == null)
                        ? width * .08
                        : width * .08 + bottomSheetHeight,
                    right: width * .08,
                    child: LowLevelCircleButton(
                      AssetsIcon.location,
                      height * .06,
                      ColorManager.white,
                      ColorManager.primaryDark,
                      () async {
                        await takeImage(previewContainer, selectedScooter!);
                      },
                    ),
                  ),
                  Positioned(
                    bottom: (bottomSheet == null)
                        ? width * .08
                        : width * .08 + bottomSheetHeight,
                    left: width * .08,
                    child: LowLevelCircleButton(
                      AssetsIcon.code,
                      height * .09,
                      ColorManager.primaryDark,
                      ColorManager.white,
                      () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => QrCodePage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              drawer: MainDrawer()),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

Future<void> takeImage(
    GlobalKey previewContainer, Scooter selectedScooter) async {
  final sp = di<SharedPreferences>();
  try {
    RenderRepaintBoundary? boundary = previewContainer.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;

    final image = await boundary!.toImage();
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData?.buffer.asUint8List();
    log(pngBytes.toString());
    List<dynamic> images = jsonDecode(sp.getString('ride_image') ?? "[]");
    await sp.setString(
      'ride_image',
      jsonEncode(
        images..add(pngBytes),
      ),
    );
    // await sp.clear();
    log("success");
  } catch (e) {
    log("Error: $e");
  }
}
