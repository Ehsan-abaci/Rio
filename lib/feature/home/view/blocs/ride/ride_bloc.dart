import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:share_scooter/feature/home/controller/battery_controller.dart';
import 'package:share_scooter/feature/home/controller/ridde_command_controller.dart';
import 'package:share_scooter/feature/home/view/screens/home_page.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../ride_histories/controller/ride_history_hive.dart';
import '../../../../ride_histories/model/ride_history_model.dart';
import '../../../../ride_histories/model/scooter_model.dart';

part 'ride_event.dart';
part 'ride_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  final RideHistoryHive _rideHistoryHiveImpl;
  final RideCommandController _commandController;
  RideBloc(
    this._rideHistoryHiveImpl,
    this._commandController,
  ) : super(RideInitial()) {
    late Scooter selectedScooter;
    late RideHistoryModel rideHistoryModel;
    var moneyController = MoneyController();
    RideState? currentState;
    RideState? previousState;
    double increaseAmount = 0.0;

    on<ReservingEvent>(
      (event, emit) async {
        selectedScooter = event.scooter;
        currentState = RideReserving(selectedScooter: event.scooter);
        emit(currentState!);
        previousState = currentState;
      },
    );

    on<ReservedEvent>((event, emit) async {
      emit(RideLoading());
      final dataState = await _commandController.reserveVehicle();
      if (dataState is DataSuccess) {
        rideHistoryModel = RideHistoryModel(
          ridingCost: 0,
          scooter: selectedScooter,
          startTime: DateTime.now(),
        );
        currentState = RideReserved(rideDetail: rideHistoryModel);
        emit(currentState!);
        previousState = currentState;
      } else {
        emit(previousState!);
      }
    });

    on<StartRidingEvent>((event, emit) async {
      emit(RideLoading());
      final dataState = await _commandController.turnEngineOn();
      if (dataState is DataSuccess) {
        increaseAmount = 500;
        currentState = RideInProgress(rideDetail: rideHistoryModel);
        emit(currentState!);
        add(IncreaseAmount());
        previousState = currentState;
      } else {
        emit(previousState!);
      }
    });
    on<PausedEvent>((event, emit) async {
      emit(RideLoading());
      final dataState = await _commandController.pauseEngine();
      if (dataState is DataSuccess) {
        increaseAmount = 100;
        currentState = RidePaused(rideDetail: rideHistoryModel);
        emit(currentState!);
        previousState = currentState;
        add(IncreaseAmount());
      } else {
        emit(previousState!);
      }
    });

    on<FinishedEvent>((event, emit) async {
      emit(RideLoading());
      final dataState = await _commandController.turnEngineOff();
      if (dataState is DataSuccess) {
        moneyController.dispose();
        currentState = RideFinished(rideDetail: rideHistoryModel);
        emit(currentState!);
        previousState = currentState;
      } else {
        emit(previousState!);
      }
    });

    on<IncreaseAmount>((event, emit) async {
      moneyController.dispose();
      moneyController = MoneyController();
      moneyController.startTimer(increaseAmount);
      await for (final val in moneyController.stream) {
        rideHistoryModel = rideHistoryModel.copyWith(
          ridingCost: rideHistoryModel.ridingCost! + val,
        );
        if (currentState is RideInProgress) {
          currentState = RideInProgress(rideDetail: rideHistoryModel);
        } else if (currentState is RidePaused) {
          currentState = RidePaused(rideDetail: rideHistoryModel);
        }
        emit(currentState!);
        previousState = currentState;
      }
    });
    on<AddNewRideEvent>((event, emit) async {
      try {
        final img = await takeImage(event.previewContainer);
        final rideHistoryModel = event.rideDetailModel.copyWith(
          img: img,
          endTime: DateTime.now(),
        );
        await _rideHistoryHiveImpl.saveRide(rideHistoryModel);
        emit(RideInitial());
      } catch (e) {
        emit(RideError(message: e.toString()));
      }
    });
  }
}

class MoneyController {
  // Create a StreamController that will manage the stream
  final StreamController<double>? _controller = StreamController<double>();
  Timer? _timer;

  // Getter to expose the stream
  Stream<double> get stream => _controller!.stream;
  Stopwatch? stopwatch;
  // Function to start the timer and update the stream
  void startTimer(double amount) {
    stopwatch = Stopwatch()..start();
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
