import 'dart:developer';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:share_scooter/core/resources/data_state.dart';
import 'package:share_scooter/core/utils/constants.dart';

class RideCommandController {
  final Dio _dio;

  RideCommandController(this._dio);

  Future<DataState<Null>> reserveVehicle() async {
    const url = "${Constant.baseUrl}/commands/send/reserve_vehicle";
    try {
      final res = await _dio.post(url);
      if (res.statusCode == 200) {
        log("reserve_vehicle was success");
        return const DataSuccess(null);
      }
      return DataFailed(res.statusMessage);
    } on DioException catch (e) {
      return DataFailed(e.message);
    }
  }

  Future<DataState<Null>> turnEngineOn() async {
    const url = "${Constant.baseUrl}/commands/send/turn_engine_on";
    try {
      final res = await _dio.post(url);
      if (res.statusCode == 200) {
        log("turn_engine_on was success");
        return const DataSuccess(null);
      }
      return DataFailed(res.statusMessage);
    } on DioException catch (e) {
      return DataFailed(e.message);
    }
  }

  Future<DataState<Null>> turnEngineOff() async {
    const url = "${Constant.baseUrl}/commands/send/turn_engine_off";
    try {
      final res = await _dio.post(url);
      if (res.statusCode == 200) {
        log("turn_engine_off was success");
        return const DataSuccess(null);
      }
      return DataFailed(res.statusMessage);
    } on DioException catch (e) {
      return DataFailed(e.message);
    }
  }

  Future<DataState<Null>> pauseEngine() async {
    const url = "${Constant.baseUrl}/commands/send/pause_engine";
    try {
      final res = await _dio.post(url);
      if (res.statusCode == 200) {
        log("pause_engine was success");
        return const DataSuccess(null);
      }
      return DataFailed(res.statusMessage);
    } on DioException catch (e) {
      return DataFailed(e.message);
    }
  }

  Future<DataState<Null>> resumeEngine() async {
    const url = "${Constant.baseUrl}/commands/send/resume_engine";
    try {
      final res = await _dio.post(url);
      if (res.statusCode == 200) {
        log("resume_engine was success");
        return const DataSuccess(null);
      }
      return DataFailed(res.statusMessage);
    } on DioException catch (e) {
      return DataFailed(e.message);
    }
  }
}
