part of 'ride_history_bloc.dart';

abstract class RideHistoryState extends Equatable {}

class RideHistoryInitial extends RideHistoryState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends RideHistoryState {
  @override
  List<Object?> get props => [];
}

class CompleteState extends RideHistoryState {
  final List<RideHistoryModel> rideHistories;
  CompleteState({
    required this.rideHistories,
  });
  @override
  List<Object?> get props => [rideHistories];
}

class ErrorState extends RideHistoryState {
  @override
  List<Object?> get props => [];
}
