import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_scooter/feature/home/presentation/screens/map_page.dart';
import 'package:share_scooter/feature/ride_details/domain/entities/ride_detail_entity.dart';

part 'ride_event.dart';
part 'ride_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  RideBloc() : super(RideInitial()) {
    late Scooter selectedScooter;
    late RideDetailEntity rideDetailEntity;
    var _moneyController = MoneyController();
    RideState? currentState;
    double _increaseAmount = 0.0;

    on<RideInitialEvent>((event, emit) {
      emit(RideInitial());
    });

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
      _increaseAmount = 500;
      currentState = RideInProgress(rideDetail: rideDetailEntity);
      add(IncreaseAmount());
    });
    on<PausedEvent>((event, emit) async {
      emit(RidePaused(rideDetail: rideDetailEntity));
      _increaseAmount = 100;
      currentState = RidePaused(rideDetail: rideDetailEntity);
      add(IncreaseAmount());
    });

    on<FinishedEvent>((event, emit) {
      _moneyController.dispose();
      emit(
        RideFinished(
          rideDetail: rideDetailEntity,
        ),
      );
    });

    on<IncreaseAmount>((event, emit) async {
      _moneyController.dispose();
      _moneyController = MoneyController();
      _moneyController.startTimer(_increaseAmount);
      await for (final val in _moneyController.stream) {
        rideDetailEntity = rideDetailEntity.copyWith(
          ridingCost: rideDetailEntity.ridingCost! + val,
        );
        if (currentState is RideInProgress) {
          currentState = RideInProgress(rideDetail: rideDetailEntity);
        } else if (currentState is RidePaused) {
          currentState = RidePaused(rideDetail: rideDetailEntity);
        }
        emit(currentState!);
        log(currentState.toString());
        log(rideDetailEntity.ridingCost.toString());
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
