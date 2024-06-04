import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/utils/resources/functions.dart';
import 'package:share_scooter/core/widgets/low_level_circle_button.dart';
import 'package:share_scooter/core/widgets/processing_modal.dart';
import 'package:share_scooter/feature/home/presentation/blocs/bloc/ride_bloc.dart';
import 'package:share_scooter/feature/home/presentation/widgets/main_drawer.dart';
import 'package:share_scooter/feature/home/presentation/widgets/notification_dialog.dart';
import 'package:share_scooter/feature/home/presentation/widgets/vehicle_bottom_sheet.dart';
import 'package:share_scooter/feature/qr_pin_code/presentation/screens/qr_code_page.dart';
import 'package:share_scooter/feature/ride_histories/domain/entities/scooter_entity.dart';
import 'package:share_scooter/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final sp = di<SharedPreferences>();

  final GlobalKey previewContainer = GlobalKey();
  Scooter? selectedScooter;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    mapController = MapController();
    if (mounted) {
      // currentLocation = await determinePosition();
      currentLocation = const LatLng(36.312309, 59.599125);
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
    return PopScope(
      canPop: context.watch<RideBloc>().state is! RideReserving,
      onPopInvoked: (_) {
        if (context.read<RideBloc>().state is RideReserving) {
          context.read<RideBloc>().emit(RideInitial());
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: BlocListener<RideBloc, RideState>(
          listener: (context, state) async {
            if (state is RideFinished) {
              context.read<RideBloc>().add(
                    AddNewRideEvent(
                      rideDetailEntity: state.rideDetail,
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
          child: Stack(
            children: [
              _getMapContent(),
              _getAppbar(width, height),
              _getNotification(width, height),
              _getLocationButton(width, height, bottomSheetHeight),
              _getQrCodeButton(width, height, bottomSheetHeight),
              _getBottomSheet(bottomSheetHeight),
            ],
          ),
        ),
        drawer: const MainDrawer(),
      ),
    );
  }

  Widget _getBottomSheet(double bottomSheetHeight) {
    return BlocBuilder<RideBloc, RideState>(
   
      builder: (context, state) {
        if (state is! RideInitial && state is! RideFirst) {
          return Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            height: bottomSheetHeight,
            child: const VehicleBottomSheet(),
          );
        }
        return const Align();
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

  Widget _getNotification(double width, double height) {
    return BlocBuilder<RideBloc, RideState>(
      buildWhen: (previous, current) =>
          current is RideReserved ||
          current is RideInProgress ||
          current is RidePaused ||
          current is RideInitial,
      builder: (context, state) {
        log("build _getNotification");
        Widget? notificationDialog;
        if (state is RideReserved) {
          notificationDialog = NotificationDialog(
            leadingIcon: AssetsIcon.reservation,
            title: "یک اسکوتر رزرو کرده اید",
            subtitle: [
              "هزینه شما تا الان: ",
              "${state.rideDetail.totalCost} T"
            ],
            indexOfGreenSubtitle: 1,
          );
        } else if (state is RideInProgress) {
          notificationDialog = NotificationDialog(
            leadingIcon: AssetsIcon.navigation,
            title: "درحال سواری هستید",
            subtitle: [
              "هزینه شما تا الان: ",
              "${state.rideDetail.totalCost} T"
            ],
            indexOfGreenSubtitle: 1,
          );
        } else if (state is RidePaused) {
          notificationDialog = const NotificationDialog(
            leadingIcon: AssetsIcon.pause,
            title: "سواری متوقف شده است",
            subtitle: [
              'زمانی که دستگاه متوقف است؛ به علت مصرف باتری و عدم اجاره مجدد اسکوتر، به ازای هر دقیقه هزینه ',
              "\nT 100.0",
              ' برای شما لحاظ می شود',
            ],
            indexOfGreenSubtitle: 1,
          );
        }
        return Positioned(
          right: width * .1,
          left: width * .1,
          top: height * .15,
          child: notificationDialog ?? const Align(),
        );
      },
    );
  }

  Widget _getQrCodeButton(
      double width, double height, double bottomSheetHeight) {
    return BlocBuilder<RideBloc, RideState>(
      buildWhen: (previous, current) =>
          current is! RidePaused && current is! RideInProgress,
      builder: (context, state) {
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
      buildWhen: (previous, current) =>
          current is! RideInitial || current is! RideFirst,
      builder: (context, state) {
        log("build _getLocationButton");
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
              tileProvider: CancellableNetworkTileProvider(),
              // const FMTCStore('mapStore').getTileProvider(),
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
              builder: (context, state) {
                log("log getMapContent");
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
