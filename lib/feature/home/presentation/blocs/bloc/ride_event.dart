// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ride_bloc.dart';

class RideEvent {}


class StartRidingEvent extends RideEvent {}

class ReservingEvent extends RideEvent {
  Scooter scooter;
  ReservingEvent({
    required this.scooter,
  });
}

class ReservedEvent extends RideEvent {}

class PausedEvent extends RideEvent {}

class FinishedEvent extends RideEvent {}

class IncreaseAmount extends RideEvent {}

class AddNewRideEvent extends RideEvent {
  final RideDetailEntity rideDetailEntity;
  final GlobalKey previewContainer;
  AddNewRideEvent({
    required this.rideDetailEntity,
    required this.previewContainer,
  });
  @override
  List<Object?> get props => [rideDetailEntity];
}