import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:share_scooter/feature/home/presentation/screens/home_page.dart';
import 'package:share_scooter/feature/ride_histories/data/data_source/local/ride_history_hive.dart';
import 'package:share_scooter/feature/ride_histories/domain/entities/ride_detail_entity.dart';
import 'package:share_scooter/feature/ride_histories/domain/entities/scooter_entity.dart';

part 'ride_event.dart';
part 'ride_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  final RideHistoryHive _rideHistoryHiveImpl;
  RideBloc(
    this._rideHistoryHiveImpl,
  ) : super(RideInitial()) {
    late Scooter selectedScooter;
    late RideDetailEntity rideDetailEntity;
    var moneyController = MoneyController();
    RideState? currentState;
    double increaseAmount = 0.0;


    on<ReservingEvent>(
      (event, emit) {
        selectedScooter = event.scooter;
        emit(RideReserving(selectedScooter: event.scooter));
      },
    );

    on<ReservedEvent>((event, emit) {
      rideDetailEntity = RideDetailEntity(
        ridingCost: 0,
        scooter: selectedScooter,
        startTime: DateTime.now(),
      );
      emit(RideReserved(rideDetail: rideDetailEntity));
    });

    on<StartRidingEvent>((event, emit) async {
      emit(RideInProgress(rideDetail: rideDetailEntity));
      increaseAmount = 500;
      currentState = RideInProgress(rideDetail: rideDetailEntity);
      add(IncreaseAmount());
    });
    on<PausedEvent>((event, emit) async {
      emit(RidePaused(rideDetail: rideDetailEntity));
      increaseAmount = 100;
      currentState = RidePaused(rideDetail: rideDetailEntity);
      add(IncreaseAmount());
    });

    on<FinishedEvent>((event, emit) {
      moneyController.dispose();
      emit(
        RideFinished(
          rideDetail: rideDetailEntity,
        ),
      );
    });

    on<IncreaseAmount>((event, emit) async {
      moneyController.dispose();
      moneyController = MoneyController();
      moneyController.startTimer(increaseAmount);
      await for (final val in moneyController.stream) {
        rideDetailEntity = rideDetailEntity.copyWith(
          ridingCost: rideDetailEntity.ridingCost! + val,
        );
        if (currentState is RideInProgress) {
          currentState = RideInProgress(rideDetail: rideDetailEntity);
        } else if (currentState is RidePaused) {
          currentState = RidePaused(rideDetail: rideDetailEntity);
        }
        emit(currentState!);
      }
    });
    on<AddNewRideEvent>((event, emit) async {
      emit(RideLoading());
      try {
        final img = await takeImage(event.previewContainer);
        final rideDetailEntity = event.rideDetailEntity.copyWith(
          img: img,
          endTime: DateTime.now(),
        );
        await _rideHistoryHiveImpl.saveRide(rideDetailEntity);
        emit(RideInitial());
      } catch (e) {
        emit(RideError(message: e.toString()));
      }
    });
  }
}

class MoneyController {
  // Create a StreamController that will manage the stream
  StreamController<double>? _controller = StreamController<double>();
  Timer? _timer;

  // Getter to expose the stream
  Stream<double> get stream => _controller!.stream;
  // Function to start the timer and update the stream
  void startTimer(double amount) {
    // Set up a periodic timer that triggers every minute
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      // Add the updated amount to the stream
      _controller?.add(amount);
    });
  }

  void disposeTimer() {
    _timer?.cancel();
  }

  // Function to stop the timer and close the stream
  void dispose() {
    _timer?.cancel();
    _controller?.close();
  }
}
