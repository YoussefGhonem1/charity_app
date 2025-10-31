import 'package:charity/src/features/create_account/cubits/user_cubit.dart';
import 'package:charity/src/features/create_account/models/users_models.dart';
import 'package:charity/src/features/home/cubits/foundations_cubit.dart';
import 'package:charity/src/features/home/widgets/foundation_card.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'dart:io';
import 'package:charity/src/shared/widgets/button.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:charity/l10n/app_localizations.dart';
import '../models/user_model.dart';
import '../data/campaign_repository.dart';
import '../../../shared/state/favourite_service.dart';
import '../../../shared/state/profile_service.dart';
import '../models/category_model.dart';
import '../models/location_model.dart';
=======
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/campaign_cubit.dart';
>>>>>>> develop
import '../widgets/feature_campaign_card.dart';
import '../widgets/lastest_campaign_card.dart';

<<<<<<< HEAD
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserModel user;
  final double wallet = 500;

  final repo = CampaignRepository.instance;

  List categories = [
    CategoryModel("Emergencies"),
    CategoryModel("Social project"),
    CategoryModel("Medical"),
    CategoryModel("Education"),
    CategoryModel("Environment"),
    CategoryModel("Women Support"),
  ];

  late List latestCampaigns;

  List locations = [
    LocationModel("Samarinda"),
    LocationModel("Jakarta"),
    LocationModel("Namibia"),
    LocationModel("France"),
    LocationModel("Kenya"),
    LocationModel("Nigeria"),
    LocationModel("Egypt"),
  ];

  final fav = FavouriteService.instance;

  @override
  void initState() {
    super.initState();
    latestCampaigns = repo.latestCampaigns;
    user = UserModel(
      ProfileService.instance.profile.value.name,
      ProfileService.instance.profile.value.avatarPathOrUrl ?? '',
      "\$150K",
    );
    ProfileService.instance.profile.addListener(() {
      final p = ProfileService.instance.profile.value;
      setState(() {
        user = UserModel(
          p.name,
          p.avatarPathOrUrl ?? user.avatarUrl,
          user.donatedAmount,
        );
      });
    });
  }

  void showAllCategoriesLocations() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        height: 350,
        padding: EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).allCategories,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 6),

              Wrap(
                spacing: 11,
                runSpacing: 9,
                children: categories
                    .map((cat) => CategoryChip(category: cat))
                    .toList(),
              ),
              SizedBox(height: 18),
              Text(
                AppLocalizations.of(context).allLocations,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 6),

              Wrap(
                spacing: 11,
                runSpacing: 9,
                children: locations
                    .map((loc) => LocationChip(location: loc))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
=======
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
>>>>>>> develop

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: Color(0xFFF7FAF8),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 25),
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: user.avatarUrl.trim().isEmpty
                      ? null
                      : (user.avatarUrl.startsWith('http')
                          ? NetworkImage(user.avatarUrl) as ImageProvider
                          : FileImage(File(user.avatarUrl))),
                  child: user.avatarUrl.trim().isEmpty
                      ? const Icon(Icons.person)
                      : null,
=======
      backgroundColor: const Color(0xFFF7FAF8),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          BlocBuilder<UserCubit, UserModel?>(
            builder: (context, user) {
              if (user == null)
                return const Center(child: CircularProgressIndicator());
              return Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.avatarUrl),
                    radius: 24,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, ${user.firstName} ${user.lastName}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Donated ${user.donatedAmount}",
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          BlocBuilder<UserCubit, UserModel?>(
            builder: (context, user) {
              if (user == null) return const SizedBox.shrink();
              return Card(
                color: const Color(0xFFFE7277),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
>>>>>>> develop
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Donation Wallet",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${user.wallet}.00",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Top up",
                          style: TextStyle(
                            color: Color(0xFFFE7277),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          BlocBuilder<CampaignsCubit, CampaignsState>(
            builder: (context, state) {
              if (state is CampaignsLoading)
                return const Center(child: CircularProgressIndicator());
              if (state is CampaignsLoaded) {
                final featureCampaigns = state.campaigns;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
<<<<<<< HEAD
                    Text(
                      user.name.trim().isEmpty ? t.helloNoName : t.hello(user.name),
=======
                    const Text(
                      'Feature Campaigns',
>>>>>>> develop
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
<<<<<<< HEAD
                    SizedBox(height: 2),
                    Text(
                      t.donated(user.donatedAmount),
                      style: TextStyle(color: Colors.grey[500], fontSize: 13),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.search, size: 26, color: Colors.grey[400]),
              ],
            ),
            SizedBox(height: 18),
            Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Color(0xFFFE7277),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.donationWallet,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "\$$wallet.00",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      t.topUp,
                      style: TextStyle(
                        color: Color(0xFFFE7277),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              t.featureCampaign,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 300,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: repo.featureCampaigns.length,
                separatorBuilder: (_, _) => SizedBox(width: 12),
                itemBuilder: (context, i) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.donationPage);
                  },
                  child: FeatureCampaignCard(
                    campaign: repo.featureCampaigns[i],
                    isFavourite: fav.isFavourite(
                      repo.featureCampaigns[i].title,
                      repo.featureCampaigns[i].by,
                    ),
                    onFavouriteTap: () {
                      setState(() {
                        fav.toggleFavourite(
                          repo.featureCampaigns[i].title,
                          repo.featureCampaigns[i].by,
                        );
                      });
=======
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 300,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: featureCampaigns.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final campaign = featureCampaigns[index];
                          return GestureDetector(
                            onTap: () {
                               Navigator.pushNamed(
    context,
    Routes.donationPage,
    arguments: campaign,
  );
                            },
                            child: FeatureCampaignCard(
                              campaign: campaign,
                              isFavourite: false,
                              onFavouriteTap: () {},
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              if (state is CampaignsError)
                return Center(child: Text('Error: ${state.message}'));
              return const SizedBox();
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Foundations',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 240,
            child: BlocBuilder<FoundationCubit, FoundationsState>(
              builder: (context, state) {
                if (state is FoundationsLoading)
                  return const Center(child: CircularProgressIndicator());
                if (state is FoundationsLoaded) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.foundations.length,
                    itemBuilder: (context, index) {
                      final foundation = state.foundations[index];
                      return GestureDetector(
                        onTap: () {
                             Navigator.pushNamed(
    context,
    Routes.foundationPage,
    arguments: foundation,
  );
                        },
                        child: SizedBox(
                          width: 200,
                          child: FoundationCard(foundation: foundation),
                        ),
                      );
>>>>>>> develop
                    },
                  );
                }
                if (state is FoundationsError)
                  return Center(child: Text('Error: ${state.message}'));
                return const SizedBox();
              },
            ),
<<<<<<< HEAD
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  t.categories,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Spacer(),
                TextButton(
                  onPressed: showAllCategoriesLocations,
                  child: Text(
                    t.seeAll,
                    style: TextStyle(color: Color(0xFFFE7277), fontSize: 13),
                  ),
                ),
              ],
            ),
            Wrap(
              spacing: 11,
              runSpacing: 9,
              children: categories
                  .take(2)
                  .map((cat) => CategoryChip(category: cat))
                  .toList(),
            ),
            SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  t.latestCampaign,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
            SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              itemCount: latestCampaigns.length,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: .85,
              ),
              itemBuilder: (context, i) => InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.donationPage);
                },
                child: LatestCampaignCard(
                  campaign: latestCampaigns[i],
                  isFavourite: fav.isFavourite(
                    latestCampaigns[i].title,
                    latestCampaigns[i].by,
                  ),
                  onFavouriteTap: () {
                    setState(() {
                      fav.toggleFavourite(
                        latestCampaigns[i].title,
                        latestCampaigns[i].by,
                      );
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 14),
            ContinueButton(
              onPressed: showAllCategoriesLocations,
              text: t.seeAll,
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.locations,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                TextButton(
                  onPressed: showAllCategoriesLocations,
                  child: Text(
                    t.seeAll,
                    style: TextStyle(color: Color(0xFFFE7277), fontSize: 13),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Wrap(
              spacing: 11,
              runSpacing: 9,
              children: locations
                  .take(3)
                  .map((loc) => LocationChip(location: loc))
                  .toList(),
            ),
          ],
        ),
=======
          ),
          const SizedBox(height: 20),
          BlocBuilder<CampaignsCubit, CampaignsState>(
            builder: (context, state) {
              if (state is CampaignsLoading)
                return const Center(child: CircularProgressIndicator());
              if (state is CampaignsLoaded) {
                final latestCampaigns = state.campaigns;
                final displayedCampaigns = latestCampaigns.length > 4
                    ? latestCampaigns.sublist(0, 4)
                    : latestCampaigns;
                bool showAll = false;
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Latest Campaigns',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: showAll
                              ? latestCampaigns.length
                              : displayedCampaigns.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.99,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                          itemBuilder: (context, index) {
                            final campaign = showAll
                                ? latestCampaigns[index]
                                : displayedCampaigns[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
    context,
    Routes.donationPage,
    arguments: campaign,
  );
                              },
                              child: LastestCampaignCard(
                                campaign: campaign,
                                isFavourite: false,
                                onFavouriteTap: () {},
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        ContinueButton(
                          text: showAll ? "Show Less" : "See All",
                          onPressed: () {
                            setState(() {
                              showAll = !showAll;
                            });
                          },
                        ),
                      ],
                    );
                  },
                );
              }
              if (state is CampaignsError)
                return Center(child: Text('Error: ${state.message}'));
              return const SizedBox();
            },
          ),
        ],
>>>>>>> develop
      ),
    );
  }
}
