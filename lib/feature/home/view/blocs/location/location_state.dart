// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final ErrorState error;
  LocationError(this.error);
  @override
  List<Object?> get props => [error];
}
