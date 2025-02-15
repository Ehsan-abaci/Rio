import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/battery_model.dart';
part 'battery_event.dart';
part 'battery_state.dart';

class BatteryBloc extends Bloc<BatteryEvent, BatteryState> {
  BatteryBloc() : super(BatteryInitial()) {
    on<GetBatteryLevel>((event, emit) async {
      emit(BatteryLoading());

      await Future.delayed(const Duration(seconds: 2));

      final battery = BatteryModel(80);

      emit(BatteryComplete(battery));
    });
  }
}
