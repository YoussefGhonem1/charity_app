
import 'package:charity/src/features/on_boarding/screens/on_boarding_page.dart';
import 'package:charity/src/features/splash/screens/splash_page.dart';
import 'package:flutter/material.dart';


class Routes {
  static const String initial = '/';
  static const String onBoarding = '/on_boarding';

}

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initial:
        return MaterialPageRoute(builder: (_) => const SplashPage());
             case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingPage());
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