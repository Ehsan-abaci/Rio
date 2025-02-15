part of 'battery_bloc.dart';

abstract class BatteryState extends Equatable {}

class BatteryInitial extends BatteryState {
  @override
  List<Object?> get props => [];
}

class BatteryLoading extends BatteryState {
  @override
  List<Object?> get props => [];
}

class BatteryComplete extends BatteryState {
  final BatteryModel batteryModel;
  BatteryComplete(this.batteryModel);
  @override
  List<Object?> get props => [batteryModel];
}

class BatteryError extends BatteryState {
  @override
  List<Object?> get props => [];
}
