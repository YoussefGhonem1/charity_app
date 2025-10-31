import 'package:charity/src/features/create_account/cubits/user_cubit.dart';
import 'package:charity/src/features/home/cubits/campaign_cubit.dart';
import 'package:charity/src/features/home/cubits/foundations_cubit.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/theme/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charity App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: Routes.initial,
    );
  }
}
























