import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:share_scooter/core/resources/data_state.dart';
import 'package:share_scooter/core/utils/constants.dart';
import 'package:share_scooter/feature/home/model/battery_model.dart';

class BatteryController {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
  ));

  Stream<DataState<BatteryModel>> getBatteryLevel() async* {
    const url = "${Constant.baseUrl}/info/battery/charge_amount";
    while (true) {
      try {
        final res = await _dio.get(url);

        if (res.statusCode == 200) {
          final data = BatteryModel(res.data[0][0]);
          yield DataSuccess(data);
        } else {
          log(res.statusMessage.toString());
          yield DataFailed(res.statusMessage);
        }
      } on DioException catch (e) {
        log(e.message.toString());
        yield DataFailed(e.toString());
      }
      await Future.delayed(const Duration(seconds: 10));
    }
  }
}
