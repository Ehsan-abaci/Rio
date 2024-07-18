part of 'network_connection_cubit.dart';

abstract class NetworkConnectionState extends Equatable {}

class NetworkConnectionInitial extends NetworkConnectionState {
  @override
  List<Object?> get props => [];
}

class NetworkConnectionLoading extends NetworkConnectionState {
  @override
  List<Object?> get props => [];
}

class NetworkConnectionSuccess extends NetworkConnectionState {
  @override
  List<Object?> get props => [];
}

class NetworkConnectionError extends NetworkConnectionState {
  @override
  List<Object?> get props => [];
}
