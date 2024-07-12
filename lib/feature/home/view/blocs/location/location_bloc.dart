import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core/utils/resources/functions.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<GetLocationEvent>((event, emit) async {
      try {
        emit(LocationLoading());
        log("loading state");
        final loc = await determinePosition();
        log(loc.toString());
        emit(LocationComplete(loc));
      } catch (e) {
        emit(LocationError());
        log(e.toString());
      }
    });
  }
}
