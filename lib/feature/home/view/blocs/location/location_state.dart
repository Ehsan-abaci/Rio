part of 'location_bloc.dart';

abstract class LocationState extends Equatable {}

class LocationInitial extends LocationState {
  @override
  List<Object?> get props => [];
}

class LocationLoading extends LocationState {
  @override
  List<Object?> get props => [];
}

class LocationComplete extends LocationState {
  final LatLng userLocation;
  LocationComplete(this.userLocation);
  @override
  List<Object?> get props => [userLocation];
}

class LocationError extends LocationState {
  @override
  List<Object?> get props => [];
}
