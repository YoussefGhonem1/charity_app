import 'package:charity/src/shared/routing/app_routs.dart';
import 'dart:io';
import 'package:charity/src/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:charity/l10n/app_localizations.dart';
import '../models/user_model.dart';
import '../data/campaign_repository.dart';
import '../../../shared/state/favourite_service.dart';
import '../../../shared/state/profile_service.dart';
import '../models/category_model.dart';
import '../models/location_model.dart';
import '../widgets/feature_campaign_card.dart';
import '../widgets/lastest_campaign_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/location_chip.dart';

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

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
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
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name.trim().isEmpty ? t.helloNoName : t.hello(user.name),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
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
                    },
                  ),
                ),
              ),
            ),
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
      ),
    );
  }
}
