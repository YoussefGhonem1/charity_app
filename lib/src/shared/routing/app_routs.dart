
import 'package:charity/src/features/create_account/screens/create_account.dart';
import 'package:charity/src/features/forget_password/screens/forget_password_page.dart';
import 'package:charity/src/features/on_boarding/screens/on_boarding_page.dart';
import 'package:charity/src/features/splash/screens/splash_page.dart';
import 'package:flutter/material.dart';

import '../../features/sign_in_password/screens/sign_in_password_screen.dart';


class Routes {
  static const String initial = '/';
  static const String onBoarding = '/on_boarding';
  static const String signInPassword = '/sign_in_password';
  static const String createAcount = '/create_account';
  static const String forgetPassword = '/forget_password';


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
       

      default:
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(
                body: Center(child: Text('404 - Page Not Found')),
              ),
        );
    }
  }
}