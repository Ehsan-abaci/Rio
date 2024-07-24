import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_scooter/feature/home/controller/ridde_command_controller.dart';
import 'package:share_scooter/feature/home/view/screens/home_page.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/error.dart';
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
    late MoneyController moneyController;
    RideState? currentState;

    on<ReservingEvent>(
      (event, emit) async {
        currentState = RideReserving(selectedScooter: event.scooter);
        emit(currentState!);
      },
    );

    on<ReservedEvent>((event, emit) async {
      moneyController = MoneyController();
      emit(state.copyWith(isLoading: true));

      final dataState = await _commandController.reserveVehicle();
      if (dataState is DataSuccess) {
        final rideData = RideHistoryModel(
          ridingCost: 0,
          scooter: (state as RideReserving).selectedScooter,
          startTime: DateTime.now(),
        );
        currentState = RideReserved(
          rideDetail: rideData,
          isLoading: false,
          modal: ReservedModal.ringModal,
        );
        emit(currentState!);
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            error: ErrorType.INTERNET.getError(),
          ),
        );
      }
    });

    on<StartRidingEvent>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
      ));

      final dataState = await _commandController.turnEngineOn();
      if (dataState is DataSuccess) {
        currentState = RideInProgress(rideDetail: state.rideDetail);
        emit(currentState!);
        add(IncreaseAmount());
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            error: ErrorType.INTERNET.getError(),
          ),
        );
      }
    });
    on<PausedEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final dataState = await _commandController.pauseEngine();
      if (dataState is DataSuccess) {
        currentState = RidePaused(rideDetail: state.rideDetail);
        emit(currentState!);
        add(IncreaseAmount());
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            error: ErrorType.INTERNET.getError(),
          ),
        );
      }
    });

    on<FinishedEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final dataState = await _commandController.turnEngineOff();
      if (dataState is DataSuccess) {
        moneyController.dispose();
        currentState = RideFinished(rideDetail: state.rideDetail);
        emit(currentState!);
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            error: ErrorType.INTERNET.getError(),
          ),
        );
      }
    });

    on<IncreaseAmount>((event, emit) async {
      if (currentState is RidePaused) {
        await moneyController.startPausedTimer();
      } else if (currentState is RideInProgress) {
        await moneyController.startunningTimer();
      } else {
        return;
      }
      await for (final val in moneyController.stream) {
        final rideData = state.rideDetail?.copyWith(
          ridingCost: state.rideDetail!.ridingCost! + val,
        );
        if (currentState is RideInProgress) {
          currentState = RideInProgress(rideDetail: rideData);
        } else if (currentState is RidePaused) {
          currentState = RidePaused(rideDetail: rideData);
        }
        emit(currentState!);
      }
    });
    on<AddNewRideEvent>((event, emit) async {
      try {
        final img = await takeImage(event.previewContainer);
        final rideHistoryModel = event.rideDetailModel!.copyWith(
          img: img,
          endTime: DateTime.now(),
        );
        await _rideHistoryHiveImpl.saveRide(rideHistoryModel);
        currentState = RideInitial(
          rideDetail: null,
          isLoading: false,
          error: null,
        );
        emit(currentState!);
      } catch (e) {
        emit(
          state.copyWith(
            error: ErrorState(
              title: "Error",
              desc: e.toString(),
            ),
          ),
        );
      }
    });
  }
}

class MoneyController {
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
  Future<void> startPausedTimer() async {
    if (_runningStopwatch.isRunning) {
      _flush();
      _runningStopwatch.stop();
      _runningTimer?.cancel();
    }
    _pausedStopwatch.start();

    // Set up a periodic timer that triggers every minute

    _pausedTimer = Timer.periodic(const Duration(seconds: 5), (t) {
      // Add the updated amount to the stream
      mySteamInputSink.add(100.0);
    });
  }

  Future<void> startunningTimer() async {
    if (_pausedStopwatch.isRunning) {
      _flush();
      _pausedStopwatch.stop();
      _pausedTimer?.cancel();
    }
    _runningStopwatch.start();
    // Set up a periodic timer that triggers every minute
    _runningTimer = Timer.periodic(const Duration(seconds: 5), (t) {
      // Add the updated amount to the stream
      mySteamInputSink.add(500.0);
    });
  }

  _flush() {
    _controller.close();
    _controller = StreamController();
  }

  void disposeTimer() {
    _pausedTimer?.cancel();
    _runningTimer?.cancel();
  }

  // Function to stop the timer and close the stream
  dispose() {
    _pausedTimer?.cancel();
    _runningTimer?.cancel();
    _controller.close();
  }
}
