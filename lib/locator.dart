import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:share_scooter/feature/home/controller/battery_controller.dart';
import 'package:share_scooter/feature/home/controller/ridde_command_controller.dart';
import 'package:share_scooter/feature/home/view/blocs/battery/battery_bloc.dart';
import 'package:share_scooter/feature/home/view/blocs/location/location_bloc.dart';
import 'package:share_scooter/feature/home/view/blocs/ride/ride_bloc.dart';
import 'package:share_scooter/feature/payment/controller/account_database_controller.dart';
import 'package:share_scooter/feature/payment/view/bloc/account_bloc.dart';
import 'package:share_scooter/feature/ride_histories/controller/ride_history_hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

final di = GetIt.instance;

Future<void> initAppMoudule() async {
  final sp = await SharedPreferences.getInstance();
  di.registerLazySingleton<SharedPreferences>(() => sp);
  di.registerLazySingleton<Dio>(
      () => Dio(BaseOptions(connectTimeout: const Duration(seconds: 10))));
  di.registerLazySingleton<RideHistoryHive>(() => RideHistoryHiveImpl());
  di.registerLazySingleton<AccountDatabaseController>(
      () => AccountDatabaseControllerImpl());
  di.registerLazySingleton<BatteryController>(() => BatteryController());
  di.registerLazySingleton<RideCommandController>(
      () => RideCommandController(di()));

  // blocs
  di.registerLazySingleton<RideBloc>(() => RideBloc(di(), di()));
  di.registerLazySingleton<LocationBloc>(() => LocationBloc());
  di.registerLazySingleton<BatteryBloc>(() => BatteryBloc(di()));
  di.registerLazySingleton<AccountBloc>(() => AccountBloc(di()));
  // di.registerLazySingleton<RideHistoryBloc>(() => RideHistoryBloc(di()));
}
