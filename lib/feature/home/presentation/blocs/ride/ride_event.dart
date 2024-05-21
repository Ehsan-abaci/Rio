// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ride_bloc.dart';

class RideEvent extends Equatable {
  const RideEvent();

  @override
  List<Object> get props => [];
}

class SetFirstRide extends RideEvent {}

class SetInitial extends RideEvent {}

class SetReserving extends RideEvent {
  final Scooter scooter;
  const SetReserving({
    required this.scooter,
  });
}

class SetReserved extends RideEvent {}

class SetReadyToRide extends RideEvent {}

class SetRiding extends RideEvent {}

class SetPaused extends RideEvent {}

class SetFinished extends RideEvent {}
