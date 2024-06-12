import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_scooter/feature/ride_histories/data/data_source/local/ride_history_hive.dart';
import 'package:share_scooter/feature/ride_histories/domain/entities/ride_detail_entity.dart';

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
