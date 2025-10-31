import 'package:charity/src/features/create_account/cubits/user_cubit.dart';
import 'package:charity/src/features/home/cubits/campaign_cubit.dart';
import 'package:charity/src/features/home/cubits/foundations_cubit.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:charity/l10n/app_localizations.dart';
import 'src/shared/state/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
<<<<<<< HEAD

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
=======
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserCubit()..loadUserData()),
        BlocProvider(create: (_) => CampaignsCubit()..fetchCampaigns()),
        BlocProvider(create: (context) => FoundationCubit()..fetchFoundations()),
      ],
      child: const MyApp(),
    ),
  );
>>>>>>> develop
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final settings = SettingsController.instance;
    return ValueListenableBuilder<Locale>(
      valueListenable: settings.locale,
      builder: (_, locale, _) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: settings.themeMode,
          builder: (_, themeMode, _) {
            return MaterialApp(
              onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeMode,
              locale: locale,
              supportedLocales: const [Locale('en'), Locale('ar')],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              onGenerateRoute: AppRoutes.onGenerateRoute,
              initialRoute: Routes.initial,
            );
          },
        );
      },
=======
    return MaterialApp(
      title: 'Charity App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: Routes.initial,
>>>>>>> develop
    );
  }
}
