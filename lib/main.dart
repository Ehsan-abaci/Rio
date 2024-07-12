import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:share_scooter/core/utils/constants.dart';
import 'package:share_scooter/feature/home/view/blocs/battery/battery_bloc.dart';
import 'package:share_scooter/feature/home/view/blocs/ride/ride_bloc.dart';
import 'package:share_scooter/feature/ride_histories/model/ride_history_model.dart';
import 'package:share_scooter/feature/splash/view/screens/splash_screen_page.dart';
import 'package:share_scooter/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/home/view/blocs/location/location_bloc.dart';
import 'feature/ride_histories/model/scooter_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initAppMoudule();
  await Hive.initFlutter();
  Hive.registerAdapter<RideHistoryModel>(RideHistoryModelAdapter());
  Hive.registerAdapter<Scooter>(ScooterAdapter());

  await Hive.openBox<RideHistoryModel>(Constant.rideHistoryBox);
  // await FMTCObjectBoxBackend().initialise();

  // if (!await const FMTCStore('mapStore').manage.ready) {
  //   await const FMTCStore('mapStore').manage.create();
  // }

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.dark));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di<RideBloc>(),
        ),
        BlocProvider(
          create: (context) => di<LocationBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale('fa', "IR"),
        supportedLocales: const [
          Locale('fa', "IR"),
          Locale('en', "US"),
        ],
        title: 'RIO',
        themeMode: ThemeMode.light,
        theme: ThemeData(
          fontFamily: Constant.fontFamily,
          useMaterial3: true,
        ),
        home: const SplashScreenPage(),
      ),
    );
  }
}
