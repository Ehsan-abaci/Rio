// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ride_bloc.dart';

abstract class RideState extends Equatable {}

class RideInitial extends RideState {
  @override
  List<Object?> get props => [];
}

class RideFirst extends RideState {
  @override
  List<Object?> get props => [];
}

class RideReserving extends RideState {
  Scooter selectedScooter;
  RideReserving({
    required this.selectedScooter,
  });
  @override
  List<Object?> get props => [selectedScooter];
}

class RideReserved extends RideState {
  RideDetailEntity rideDetail;
  RideReserved({
    required this.rideDetail,
  });
  @override
  List<Object?> get props => [rideDetail];
}

class RideInProgress extends RideState {
  RideDetailEntity rideDetail;
  RideInProgress({
    required this.rideDetail,
  });
  @override
  List<Object?> get props => [rideDetail];
}

class RidePaused extends RideState {
    RideDetailEntity rideDetail;
  RidePaused({
    required this.rideDetail,
  });
  @override
  List<Object?> get props => [rideDetail];
}

class RideFinished extends RideState {
  @override
  List<Object?> get props => [];
}
