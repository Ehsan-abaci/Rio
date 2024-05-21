// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ride_bloc.dart';

abstract class RideState extends Equatable {}

class RideInitial extends RideState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FirstRide extends RideState {
  @override
  List<Object?> get props => [];
}

class Reserving extends RideState {
  final Scooter scooter;
  Reserving({
    required this.scooter,
  });

  @override
  List<Object?> get props => [scooter];
}

class Reserved extends RideState {
  RideDetailEntity rideDetail;
  Reserved({
    required this.rideDetail,
  });

  @override
  List<Object?> get props => [rideDetail];

  Reserved copyWith({
    RideDetailEntity? rideDetail,
  }) {
    return Reserved(
      rideDetail: rideDetail ?? this.rideDetail,
    );
  }
}

class ReadyToRide extends RideState {
  RideDetailEntity rideDetail;
  ReadyToRide({
    required this.rideDetail,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [rideDetail];
}

class Riding extends RideState {
  RideDetailEntity rideDetail;
  Riding({
    required this.rideDetail,
  });

  @override
  List<Object?> get props => [rideDetail];
}

class Paused extends RideState {
  RideDetailEntity rideDetail;
  Paused({
    required this.rideDetail,
  });

  @override
  List<Object?> get props => [rideDetail];
}

class Finished extends RideState {
  @override
  List<Object?> get props => [];
}
