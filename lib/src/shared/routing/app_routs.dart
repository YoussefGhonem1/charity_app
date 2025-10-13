import 'package:charity/src/features/create_account/screens/create_account.dart';
import 'package:charity/src/features/favourite/favourite.dart';
import 'package:charity/src/features/forget_password/screens/forget_password_page.dart';
import 'package:charity/src/features/on_boarding/screens/on_boarding_page.dart';
import 'package:charity/src/features/payment/screens/add_card_page.dart';
import 'package:charity/src/features/payment/screens/donate_page.dart';
import 'package:charity/src/features/payment/screens/enter_pin_page.dart';
import 'package:charity/src/features/payment/screens/payment_page.dart';
import 'package:charity/src/features/payment/screens/success_page.dart';
import 'package:charity/src/features/splash/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:charity/src/features/forget_password/screens/reset_password_sent_page.dart';
import '../../features/sigin_in_email/screens/signin_email.dart';
import '../../features/sign_in_password/screens/sign_in_password_screen.dart';

class Routes {
  static const String initial = '/';
  static const String onBoarding = '/on_boarding';
  static const String signInPassword = '/sign_in_password';
  static const String createAcount = '/create_account';
  static const String forgetPassword = '/forget_password';
  static const String forgetConfirmation = '/forget_confirmation';
  static const String signInEmail = '/sign_in_email';
  static const String donate = '/donate';
  static const String payment = '/payment';
  static const String addCard = '/add_card';
  static const String enterPin = '/enter_pin';
  static const String success = '/success';
  static const String favourite = '/favourite';
}

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initial:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingPage());

      case Routes.signInPassword:
        return MaterialPageRoute(builder: (_) => SignInPasswordScreen());

      case Routes.createAcount:
        return MaterialPageRoute(builder: (_) => CreateAccountPage());

      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => ForgetPasswordPage());
      case Routes.forgetConfirmation:
        return MaterialPageRoute(builder: (_) => ResetPasswordSentScreen());
      case Routes.donate:
        return MaterialPageRoute(builder: (_) => DonatePage());
      case Routes.payment:
        return MaterialPageRoute(builder: (_) => PaymentPage());
      case Routes.addCard:
        return MaterialPageRoute(builder: (_) => AddNewCardPage());
      case Routes.signInEmail:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Routes.enterPin:
        return MaterialPageRoute(builder: (_) => EnterPinPage());
      case Routes.success:
        return MaterialPageRoute(builder: (_) => SuccessPage());
      case Routes.favourite:
        return MaterialPageRoute(builder: (_) => FavouriteScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('404 - Page Not Found'))),
        );
    }
  }
}
