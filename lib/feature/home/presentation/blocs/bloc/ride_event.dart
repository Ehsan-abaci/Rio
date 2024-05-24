// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ride_bloc.dart';

class RideEvent {}

class RideInitialEvent extends RideEvent {}
class StartRidingEvent extends RideEvent {}

class ReservingEvent extends RideEvent {
  Scooter scooter;
  ReservingEvent({
    required this.scooter,
  });
}

class ReservedEvent extends RideEvent {
  // RideDetailEntity rideDetail;
  // ReservedEvent({
  //   required this.rideDetail,
  // });
}

class PausedEvent extends RideEvent {}

class FinishedEvent extends RideEvent {}

class IncreaseAmount extends RideEvent {}
