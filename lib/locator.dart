import 'package:get_it/get_it.dart';
import 'package:share_scooter/feature/home/presentation/blocs/bloc/ride_bloc.dart';
import 'package:share_scooter/feature/ride_histories/data/data_source/local/ride_history_hive.dart';
import 'package:share_scooter/feature/ride_histories/presentation/bloc/ride_history_bloc.dart';
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
