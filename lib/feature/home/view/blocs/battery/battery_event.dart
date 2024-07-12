part of 'battery_bloc.dart';

abstract class BatteryEvent extends Equatable {}

class GetBatteryLevel extends BatteryEvent {
  @override
  List<Object?> get props => [];
}
