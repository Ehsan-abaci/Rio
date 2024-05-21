import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final di = GetIt.instance;

Future<void> initAppMoudule() async {
  final sp = await SharedPreferences.getInstance();
  di.registerLazySingleton<SharedPreferences>(() => sp);
}
