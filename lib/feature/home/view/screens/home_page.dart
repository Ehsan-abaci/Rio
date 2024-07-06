import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/utils/resources/functions.dart';
import 'package:share_scooter/core/widgets/low_level_circle_button.dart';
import 'package:share_scooter/core/widgets/processing_modal.dart';
import 'package:share_scooter/feature/home/view/blocs/bloc/ride_bloc.dart';
import 'package:share_scooter/feature/home/view/widgets/main_drawer.dart';
import 'package:share_scooter/feature/home/view/widgets/notification_dialog.dart';
import 'package:share_scooter/feature/home/view/widgets/vehicle_bottom_sheet.dart';
import 'package:share_scooter/feature/qr_pin_code/view/screens/qr_code_page.dart';
import 'package:share_scooter/feature/ride_histories/model/scooter_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _loadinDialogKey = GlobalKey();

  LatLng? currentLocation;
  late MapController mapController;

  final GlobalKey previewContainer = GlobalKey();
  Scooter? selectedScooter;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    mapController = MapController();
    if (mounted) {
      currentLocation = await determinePosition();
    }
  }

  List<Scooter> scooters = [
    Scooter(
      id: "#1",
      name: "Apple Scooter",
      lat: 36.304436,
      lng: 59.594230,
    ),
    Scooter(
      id: "#2",
      name: "Apple Scooter",
      lat: 36.304436,
      lng: 57.594230,
    ),
    Scooter(
      name: "Apple Scooter",
      id: "#3",
      lat: 36.304436,
      lng: 58.594230,
    ),
    Scooter(
      name: "Apple Scooter",
      id: "#4",
      lat: 38.304436,
      lng: 59.594230,
    ),
  ];

  goToCurrentLocation() {
    mapController.move(currentLocation!, 14);
  }

  selecetScooter(Scooter scooter) {
    final height = MediaQuery.sizeOf(context).height;
    final bottomSheetHeight = height * .3;
    context.read<RideBloc>().add(ReservingEvent(scooter: scooter));
    mapController.fitCamera(
      CameraFit.bounds(
        padding: EdgeInsets.only(
            left: 100, right: 100, top: 50, bottom: bottomSheetHeight + 50),
        minZoom: 2,
        maxZoom: 15,
        bounds: LatLngBounds(
          LatLng(scooter.lat, scooter.lng),
          currentLocation!,
        ),
      ),
    );
    mapController.rotate(0);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final bottomSheetHeight = height * .3;
    return BlocListener<RideBloc, RideState>(
      listenWhen: (previous, current) =>
          current is RideInitial ||
          current is RideFinished ||
          current is RideLoading,
      listener: (context, state) async {
        if (state is RideFinished) {
          context.read<RideBloc>().add(
                AddNewRideEvent(
                  rideDetailModel: state.rideDetail,
                  previewContainer: previewContainer,
                ),
              );
        } else if (state is RideLoading) {
          showAdaptiveDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => ProcessingModal(
              key: _loadinDialogKey,
            ),
          );
        } else if (state is RideInitial) {
          dismissDialog(context, _loadinDialogKey);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            _getMapContent(),
            _getAppbar(width, height),
            // _getNotification(width, height),
            NotificationDialog(),
            _getLocationButton(width, height, bottomSheetHeight),
            _getQrCodeButton(width, height, bottomSheetHeight),
            _getBottomSheet(bottomSheetHeight),
          ],
        ),
        drawer: const MainDrawer(),
      ),
    );
  }

  Widget _getBottomSheet(double bottomSheetHeight) {
    return BlocBuilder<RideBloc, RideState>(
      builder: (context, state) {
        return PopScope(
          canPop: state is RideInitial,
          onPopInvoked: (_) {
            final state = context.read<RideBloc>().state;
            if (state is! RideInitial) {
              context.read<RideBloc>().emit(RideInitial());
            }
          },
          child: const VehicleBottomSheet(),
        );
      },
    );
  }

  Widget _getAppbar(double width, double height) {
    return Positioned.fromRect(
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
    );
  }

  // Widget _getNotification(double width, double height) {
  //   return BlocBuilder<RideBloc, RideState>(
  //     buildWhen: (previous, current) =>
  //         current is RideReserved ||
  //         current is RideInProgress ||
  //         current is RidePaused ||
  //         previous is RideFinished,
  //     builder: (context, state) {
  //       return Positioned(
  //         right: width * .1,
  //         left: width * .1,
  //         top: height * .15,
  //         child: (state is RideReserved ||
  //                 state is RideInProgress ||
  //                 state is RidePaused)
  //             ?
  //             : const Align(),
  //       );
  //     },
  //   );
  // }

  Widget _getQrCodeButton(
      double width, double height, double bottomSheetHeight) {
    return BlocBuilder<RideBloc, RideState>(
      buildWhen: (previous, current) {
        if (current is RideInitial ||
            current is RideFirst ||
            current is RideReserved ||
            current is RideReserving) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        log("build _getQrCodeButton");
        var bottomSheetExpanded = false;
        if (state is! RideInitial && state is! RideFirst) {
          bottomSheetExpanded = true;
        }
        if (state is RideInitial ||
            state is RideFirst ||
            state is RideReserving) {
          return Positioned(
            bottom: (!bottomSheetExpanded)
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
                    builder: (context) => const QrCodePage(),
                  ),
                );
              },
            ),
          );
        } else {
          return const Align();
        }
      },
    );
  }

  Widget _getLocationButton(
      double width, double height, double bottomSheetHeight) {
    return BlocBuilder<RideBloc, RideState>(
      buildWhen: (previous, current) {
        if ((current is RideInitial || current is RideFirst) ||
            current is RideReserving) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        var bottomSheetExpanded = false;
        if (state is! RideInitial && state is! RideFirst) {
          bottomSheetExpanded = true;
        }
        return Positioned(
          bottom: (!bottomSheetExpanded)
              ? width * .08
              : width * .08 + bottomSheetHeight,
          right: width * .08,
          child: LowLevelCircleButton(
            AssetsIcon.location,
            height * .06,
            ColorManager.white,
            ColorManager.primaryDark,
            () {
              goToCurrentLocation();
            },
          ),
        );
      },
    );
  }

  Widget _getMapContent() {
    return Positioned.fill(
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
              // tileProvider: CancellableNetworkTileProvider(),
              tileProvider: const FMTCStore('mapStore').getTileProvider(),
              keepBuffer: 100,
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/hamidaslami2/clob8flgd012t01qsdwnf70md/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaGFtaWRhc2xhbWkyIiwiYSI6ImNsbm9wcm5idjAyaWUya255enF0bmZyNnoifQ.eD-IuFdTBd9rDEgqyPyQEA',
            ),
            CurrentLocationLayer(
              alignPositionOnUpdate: AlignOnUpdate.once,
              alignDirectionOnUpdate: AlignOnUpdate.never,
              style: LocationMarkerStyle(
                marker: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 5,
                          blurRadius: 5)
                    ],
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                markerSize: const Size.square(25),
                accuracyCircleColor: Colors.blueAccent.withOpacity(0.1),
                headingSectorColor: Colors.blueAccent.withOpacity(0.8),
                headingSectorRadius: 50,
              ),
              moveAnimationDuration: Duration.zero, // disable animation
            ),
            BlocBuilder<RideBloc, RideState>(
              buildWhen: (previous, current) {
                if (current is RideReserving ||
                    current is RideReserved ||
                    current is RideInitial ||
                    current is RideFirst) {
                  return true;
                } else {
                  return false;
                }
              },
              builder: (context, state) {
                if (state is RideReserving) {
                  selectedScooter = state.selectedScooter;
                }
                if (state is RideFirst ||
                    state is RideInitial ||
                    state is RideReserving) {
                  return MarkerLayer(
                    markers: [
                      ...scooters.map(
                        (e) {
                          return Marker(
                            width: 70,
                            height: 70,
                            point: LatLng(e.lat, e.lng),
                            child: GestureDetector(
                              onTap: () {
                                selecetScooter(e);
                              },
                              child: SvgPicture.asset(
                                e.id == selectedScooter?.id &&
                                        state is RideReserving
                                    ? AssetsIcon.selectedPoint
                                    : AssetsIcon.point,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return MarkerLayer(
                    markers: [
                      Marker(
                        width: 70,
                        height: 70,
                        point:
                            LatLng(selectedScooter!.lat, selectedScooter!.lng),
                        child: SvgPicture.asset(
                          AssetsIcon.point,
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

FutureOr<String?> takeImage(GlobalKey previewContainer) async {
  try {
    RenderRepaintBoundary? boundary = previewContainer.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;

    final image = await boundary!.toImage();
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData?.buffer.asUint8List();
    return pngBytes != null ? base64Encode(pngBytes) : null;
  } catch (e) {
    return null;
  }
}
