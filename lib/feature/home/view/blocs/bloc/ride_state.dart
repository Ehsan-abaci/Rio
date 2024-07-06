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
  final Scooter selectedScooter;
  RideReserving({
    required this.selectedScooter,
  });
  @override
  List<Object?> get props => [selectedScooter];
}

class RideReserved extends RideState {
  final RideHistoryModel rideDetail;
  RideReserved({
    required this.rideDetail,
  });
  @override
  List<Object?> get props => [rideDetail];
}

class RideInProgress extends RideState {
  final RideHistoryModel rideDetail;
  RideInProgress({
    required this.rideDetail,
  });
  @override
  List<Object?> get props => [rideDetail];
}

class RidePaused extends RideState {
  final RideHistoryModel rideDetail;
  RidePaused({
    required this.rideDetail,
  });
  @override
  List<Object?> get props => [rideDetail];
}

class RideFinished extends RideState {
  final RideHistoryModel rideDetail;
  RideFinished({
    required this.rideDetail,
  });
  @override
  List<Object?> get props => [rideDetail];
}

class RideLoading extends RideState {
  @override
  List<Object?> get props => [];
}

class RideError extends RideState {
  final String message;
  RideError({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}
