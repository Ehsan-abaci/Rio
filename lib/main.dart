import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:share_scooter/feature/home/presentation/screens/map_page.dart';
import 'package:share_scooter/feature/ride_histories/presentation/screens/ride_history_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FMTCObjectBoxBackend().initialise();

  if (!await const FMTCStore('mapStore').manage.ready) {
    await const FMTCStore('mapStore').manage.create();
  }

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
    return MaterialApp(
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
        fontFamily: "Vazir",
        useMaterial3: true,
      ),
      home: RideHistoriesPage(),
    );
  }
}
