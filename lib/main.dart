import 'package:charity/src/features/create_account/cubits/user_cubit.dart';
import 'package:charity/src/features/home/cubits/campaign_cubit.dart';
import 'package:charity/src/features/home/cubits/foundations_cubit.dart';
import 'package:charity/src/features/home/models/add_campaign_model.dart';
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













class AddCampaignModel extends StatefulWidget {
  const AddCampaignModel({super.key});
  @override
  State<AddCampaignModel> createState() => _AddCampaignModelState();
}

class _AddCampaignModelState extends State<AddCampaignModel> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _status = 'Idle';

  @override
  void initState() {
    super.initState();
    _maybeSeedData();
  }

  Future<void> _maybeSeedData() async {
    setState(() => _status = 'Checking seed flag...');
    try {
      final metaDoc = _firestore.collection('meta').doc('seeded');
      final snap = await metaDoc.get();

      if (snap.exists && snap.data()?['done'] == true) {
        setState(() => _status = 'Already seeded — skipping.');
        return;
      }

      setState(() => _status = 'Seeding sample data...');

      final sampleItems = [
        {
          "title": "Italian Pasta",
          "description": "Fresh handmade pasta with Alfredo sauce.",
          "imageUrl": "https://example.com/pasta.jpg",
          "price": 14.99,
          "rating": 4.8,
        },
        {
          "title": "Margherita Pizza",
          "description": "Classic pizza with mozzarella and basil.",
          "imageUrl": "https://example.com/pizza.jpg",
          "price": 12.49,
          "rating": 4.6,
        },
        {
          "title": "Tiramisu",
          "description": "Italian dessert made with coffee and mascarpone.",
          "imageUrl": "https://example.com/tiramisu.jpg",
          "price": 7.99,
          "rating": 4.9,
        },
      ];

      final batch = _firestore.batch();
      final itemsColl = _firestore.collection('items');

      for (var item in sampleItems) {
        final docRef = itemsColl.doc(); // auto id
        batch.set(docRef, item);
      }

      // mark seeded
      batch.set(metaDoc, {'done': true, 'seededAt': FieldValue.serverTimestamp()});

      await batch.commit();

      setState(() => _status = 'Seeding complete!');
    } catch (e, st) {
      // print full error for debugging
      debugPrint('Error seeding Firestore: $e\n$st');
      setState(() => _status = 'Error: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }}










