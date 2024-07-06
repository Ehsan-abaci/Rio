import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_scooter/feature/ride_histories/controller/ride_history_hive.dart';
import 'package:share_scooter/feature/ride_histories/model/ride_history_model.dart';

part 'ride_history_event.dart';
part 'ride_history_state.dart';

class RideHistoryBloc extends Bloc<RideHistoryEvent, RideHistoryState> {
  final RideHistoryHive _rideHistoryHiveImpl;

  RideHistoryBloc(
    this._rideHistoryHiveImpl,
  ) : super(RideHistoryInitial()) {
    on<FetchRideHisyoriesEvent>(_fetchRideHistories);
    add(FetchRideHisyoriesEvent());
  }

  FutureOr<void> _fetchRideHistories(event, emit) {
    emit(LoadingState());
    try {
      final rideHistories = _rideHistoryHiveImpl.fetchRideHistories();
      emit(CompleteState(rideHistories: rideHistories));
    } catch (e) {
      emit(ErrorState());
    }
  }


}
