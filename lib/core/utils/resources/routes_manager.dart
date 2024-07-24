import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_scooter/feature/home/view/screens/home_page.dart';
import 'package:share_scooter/feature/login/view/screens/login_page.dart';
import 'package:share_scooter/feature/login/view/screens/login_phone_number_page.dart';
import 'package:share_scooter/feature/payment/view/screens/add_credit_code_page.dart';
import 'package:share_scooter/feature/payment/view/screens/credit_payment_page.dart';
import 'package:share_scooter/feature/payment/view/screens/recharge_the_wallet_page.dart';
import 'package:share_scooter/feature/qr_pin_code/view/screens/pin_code_page.dart';
import 'package:share_scooter/feature/qr_pin_code/view/screens/qr_code_page.dart';
import 'package:share_scooter/feature/ride_histories/model/ride_history_model.dart';
import 'package:share_scooter/feature/ride_histories/view/bloc/ride_history_bloc.dart';
import 'package:share_scooter/feature/ride_histories/view/screens/ride_details_page.dart';
import 'package:share_scooter/feature/ride_histories/view/screens/ride_history_page.dart';
import 'package:share_scooter/feature/settings/view/screens/account_page.dart';
import 'package:share_scooter/feature/settings/view/screens/change_language_page.dart';
import 'package:share_scooter/feature/settings/view/screens/setting_page.dart';
import 'package:share_scooter/feature/settings/view/screens/terms_of_use_page.dart';
import 'package:share_scooter/feature/splash/view/screens/splash_screen_page.dart';
import 'package:share_scooter/locator.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String loginByPhoneNumberRoute = '/login-by-phone';
  static const String homeRoute = '/home';
  static const String qrCodeRoute = '/qrCode';
  static const String pinCodeRoute = '/pinCode';
  static const String rideDetailRoute = '/ride-detail';
  static const String rideHistoryRoute = '/ride-history';
  static const String accountRoute = '/account';
  static const String settingRoute = '/setting';
  static const String addCreditCodeRoute = '/add-credit-code';
  static const String creditPaymentRoute = '/credit-peyment';
  static const String rechargeWalletRoute = '/recharge-wallet';
  static const String changeLanguageRoute = '/change-language';
  static const String termsOfUsePeageRoute = '/terms-of-use';
}

class RouteGenerator {
  static Route getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreenPage());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routes.loginByPhoneNumberRoute:
        return MaterialPageRoute(builder: (_) => LoginPhoneNumberPage());
      case Routes.homeRoute:
        initHomeMoudule();
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.qrCodeRoute:
        return MaterialPageRoute(builder: (_) => const QrCodePage());
      case Routes.pinCodeRoute:
        return MaterialPageRoute(builder: (_) => const PinCodePage());
      case Routes.rideDetailRoute:
        return MaterialPageRoute(
            builder: (_) => RideDetailsPage(
                  rideHistoryModel: routeSettings.arguments as RideHistoryModel,
                ));
      case Routes.rideHistoryRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => RideHistoryBloc(di()),
                  child: const RideHistoriesPage(),
                ),
            settings: RouteSettings(arguments: routeSettings.arguments));
      case Routes.accountRoute:
        return MaterialPageRoute(builder: (_) => const AccountPage());
      case Routes.settingRoute:
        return MaterialPageRoute(builder: (_) => const SettingPage());
      case Routes.addCreditCodeRoute:
        return MaterialPageRoute(builder: (_) => AddCreditCodePage());
      case Routes.creditPaymentRoute:
        return MaterialPageRoute(builder: (_) => const CreditPaymentPage());
      case Routes.rechargeWalletRoute:
        return MaterialPageRoute(builder: (_) => const RechargeTheWalletPage());
      case Routes.changeLanguageRoute:
        return MaterialPageRoute(builder: (_) => const ChangeLanguagePage());
      case Routes.termsOfUsePeageRoute:
        return MaterialPageRoute(builder: (_) => const TermsOfUsePage());
      default:
        return MaterialPageRoute(
            builder: (_) => const HomePage()); //default route
    }
  }
}
