import 'package:charity/src/features/create_account/screens/create_account.dart';
import 'package:charity/src/features/forget/screens/forget.dart';
import 'package:charity/src/features/sign_in_password/screens/sign_in_password_screen.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charity App',
      debugShowCheckedModeBanner: false,
       theme: AppTheme.Theme,
      //onGenerateRoute: AppRoutes.onGenerateRoute,
      //initialRoute: Routes.initial,
      home: Forget(),

    );
  }
}

