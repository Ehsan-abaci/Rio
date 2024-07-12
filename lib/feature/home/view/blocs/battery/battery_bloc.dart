import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_scooter/core/resources/data_state.dart';
import 'package:share_scooter/feature/home/controller/battery_controller.dart';
import 'package:share_scooter/feature/home/model/battery_model.dart';

part 'battery_event.dart';
part 'battery_state.dart';

class BatteryBloc extends Bloc<BatteryEvent, BatteryState> {
  final BatteryController _batteryController;
  BatteryBloc(this._batteryController) : super(BatteryInitial()) {
    on<GetBatteryLevel>((event, emit) async {
      emit(BatteryLoading());
      return emit.forEach(
        _batteryController.getBatteryLevel(),
        onData: (dataState) {
          if (dataState is DataSuccess) {
            final data = BatteryModel(dataState.data!.level);
            log("level is ${data.level}");
            return BatteryComplete(data);
          } else if (dataState is DataFailed) {
            log(dataState.error.toString());
            return BatteryError();
          } else {
            return BatteryError();
          }
        },
      );
    });
  }
  @override
  Future<void> close() {
    return super.close();
  }
}
