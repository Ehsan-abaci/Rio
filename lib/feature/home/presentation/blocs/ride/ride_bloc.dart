import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_scooter/feature/home/presentation/screens/map_page.dart';
import 'package:share_scooter/feature/ride_details/domain/entities/ride_detail_entity.dart';

part 'ride_event.dart';
part 'ride_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  Timer? timer;
  RideBloc() : super(RideInitial()) {
    on<SetInitial>(
      (event, emit) => emit(
        RideInitial(),
      ),
    );
    on<SetReserving>(
      (event, emit) => emit(
        Reserving(
          scooter: event.scooter,
        ),
      ),
    );
    on<SetReserved>((event, emit) {
      final scooter = (state as Reserving).scooter;
      log(scooter.id.toString());
      RideDetailEntity rideDetailEntity = RideDetailEntity(
        scooter: scooter,
        startTime: DateTime.now(),
      );

      emit(Reserved(
        rideDetail: rideDetailEntity,
      ));
    });

    on<SetReadyToRide>((event, emit) {
      var rideDetail = (state as Reserved).rideDetail;
      emit(ReadyToRide(rideDetail: rideDetail));
    });

    on<SetRiding>((event, emit) async {
      var rideDetail = (state as Paused).rideDetail;
      emit(Riding(rideDetail: rideDetail));
    });

    on<SetPaused>((event, emit) {
      var rideDetail = (state as Riding).rideDetail;
      emit(Paused(rideDetail: rideDetail));
    });
  }
}
