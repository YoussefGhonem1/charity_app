import 'package:charity/src/features/articles/cubit/articles_cubit.dart';
import 'package:charity/src/features/create_account/cubits/user_cubit.dart';
import 'package:charity/src/features/home/cubits/campaign_cubit.dart';
import 'package:charity/src/features/home/cubits/foundations_cubit.dart';
import 'package:charity/src/features/favourite/cubits/favourite_cubit.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/theme/app_theme.dart';
import 'package:charity/src/shared/cubits/theme_cubit.dart';
import 'package:charity/src/shared/cubits/locale_cubit.dart';
import 'package:charity/src/shared/localization/app_translations.dart';
import 'package:charity/src/features/profile_management/cubits/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
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
        BlocProvider(create: (context) => ArticlesCubit()..getArticles()),
        BlocProvider(create: (_) => FavouriteCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LocaleCubit()),
        BlocProvider(create: (_) => SettingsCubit()..load()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp(
              title: 'Charity App',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.theme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              locale: locale,
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              localizationsDelegates: const [
                AppTranslations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              builder: (context, child) {
                return Directionality(
                  textDirection: locale.languageCode == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: child ?? const SizedBox.shrink(),
                );
              },
              onGenerateRoute: AppRoutes.onGenerateRoute,
              initialRoute: Routes.initial,
            );
          },
        );
      },
    );
  }
}
























