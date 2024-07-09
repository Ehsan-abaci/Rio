import 'package:get_it/get_it.dart';
import 'package:share_scooter/feature/home/view/blocs/bloc/ride_bloc.dart';
import 'package:share_scooter/feature/ride_histories/controller/ride_history_hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

final di = GetIt.instance;

Future<void> initAppMoudule() async {
  final sp = await SharedPreferences.getInstance();
  di.registerLazySingleton<SharedPreferences>(() => sp);
  di.registerLazySingleton<RideHistoryHive>(() => RideHistoryHiveImpl());

  // blocs
  di.registerLazySingleton<RideBloc>(() => RideBloc(di()));
  // di.registerLazySingleton<RideHistoryBloc>(() => RideHistoryBloc(di()));
}
