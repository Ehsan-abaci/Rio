import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:share_scooter/core/utils/constants.dart';
// import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:share_scooter/feature/home/presentation/blocs/bloc/ride_bloc.dart';
import 'package:share_scooter/feature/ride_histories/domain/entities/ride_detail_entity.dart';
import 'package:share_scooter/feature/ride_histories/domain/entities/scooter_entity.dart';
import 'package:share_scooter/feature/splash/presentation/screens/splash_screen_page.dart';
import 'package:share_scooter/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/ride_histories/presentation/screens/ride_details_page.dart';
import 'feature/settings/presentation/screens/account_page.dart';
import 'feature/settings/presentation/screens/change_language_page.dart';
import 'feature/settings/presentation/screens/setting_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initAppMoudule();
  await Hive.initFlutter();
  Hive.registerAdapter<RideDetailEntity>(RideDetailEntityAdapter());
  Hive.registerAdapter<Scooter>(ScooterAdapter());

  await Hive.openBox<RideDetailEntity>(Constant.rideHistoryBox);
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
        home: const RideDetailsPage(),
      ),
    );
  }
}
