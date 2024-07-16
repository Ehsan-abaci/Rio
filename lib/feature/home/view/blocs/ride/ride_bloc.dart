import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
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
        currentState = RidePaused(rideDetail: rideHistoryModel);
        emit(currentState!);
        add(IncreaseAmount());
        previousState = currentState;
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
      if (currentState is RidePaused) {
        moneyController.startPausedTimer();
      } else if (currentState is RideInProgress) {
        moneyController.startunningTimer();
      } else {
        return;
      }
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
  static final MoneyController _moneyController = MoneyController._internal();
  MoneyController._internal();
  factory MoneyController() => _moneyController;

  // Create a StreamController that will manage the stream
  StreamController<double> _controller = StreamController();
  Sink<double> get mySteamInputSink => _controller.sink;
  Timer? _pausedTimer;
  Timer? _runningTimer;

  final Stopwatch _pausedStopwatch = Stopwatch();
  final Stopwatch _runningStopwatch = Stopwatch();

  // Getter to expose the stream
  Stream<double> get stream => _controller.stream;

  // Function to start the timer and update the stream
  void startPausedTimer() async {
    if (_runningStopwatch.isRunning) {
      _flush();
      _runningStopwatch.stop();
      _runningTimer?.cancel();
    }
    _pausedStopwatch.start();

    // Set up a periodic timer that triggers every minute

    _pausedTimer = Timer.periodic(const Duration(minutes: 1), (t) {
      // Add the updated amount to the stream
      mySteamInputSink.add(100.0);
    });
  }

  void startunningTimer() async {
    if (_pausedStopwatch.isRunning) {
      _flush();
      _pausedStopwatch.stop();
      _pausedTimer?.cancel();
    }
    _runningStopwatch.start();
    // Set up a periodic timer that triggers every minute
    _runningTimer = Timer.periodic(const Duration(minutes: 1), (t) {
      // Add the updated amount to the stream
      mySteamInputSink.add(500.0);
    });
  }

  _flush() {
    _controller.close();
    _controller = StreamController<double>();
  }

  void disposeTimer() {
    _pausedTimer?.cancel();
    _runningTimer?.cancel();
  }

  // Function to stop the timer and close the stream
  void dispose() {
    _pausedTimer?.cancel();
    _runningTimer?.cancel();
    _controller.close();
  }
}
