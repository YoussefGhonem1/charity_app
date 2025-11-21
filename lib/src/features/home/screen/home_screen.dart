import 'package:charity/src/features/create_account/cubits/user_cubit.dart';
import 'package:charity/src/features/create_account/models/users_models.dart';
import 'package:charity/src/features/home/cubits/foundations_cubit.dart';
import 'package:charity/src/features/home/widgets/foundation_card.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/campaign_cubit.dart';
import '../widgets/feature_campaign_card.dart';
import '../widgets/lastest_campaign_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const Text(
                      'Feature Campaigns',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
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
          Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text(
            'Foundations',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

TextButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.all);
      },
      child: Text(
        'See All',
        style: TextStyle(
          fontSize: 16,
          color: Colors.blue,
        ),
      ),
    ),
          ]
          ),
           SizedBox(height: 12),
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
                    },
                  );
                }
                if (state is FoundationsError)
                  return Center(child: Text('Error: ${state.message}'));
                return const SizedBox();
              },
            ),
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
      ),
    );
  }
}
