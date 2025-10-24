import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/user_cubit.dart';
import '../cubits/campaign_cubit.dart';
import '../models/user_model.dart';
import '../models/campaign_model.dart';
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
                  if (user == null) return const Center(child: CircularProgressIndicator());
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
                          Text("Hello, ${user.name}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          Text("Donated ${user.donatedAmount}", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
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
                    color: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Donation Wallet", style: TextStyle(color: Colors.white, fontSize: 16)),
                              SizedBox(height: 10),
                              Text("\${user.wallet}.00", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            child: const Text("Top up", style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              BlocBuilder<CampaignsCubit, List<CampaignModel>>(
                builder: (context, campaigns) {
                  return Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          context.read<CampaignsCubit>().emit(
                              campaigns.where((c) => c.title.toLowerCase().contains(value.toLowerCase())).toList()
                          );
                        },
                        decoration: InputDecoration(
                          labelText: 'Search Campaigns',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 280,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: campaigns.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final campaign = campaigns[index];
                            return FeatureCampaignCard(
                              campaign: campaign,
                              isFavourite: false,
                              onFavouriteTap: () {},
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('Latest Campaigns', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 12),
                      ...campaigns.map((c) => LastestCampaignCard(campaign: c)).toList(),
                    ],
                  );
                },
              ),
            ]
        )
    );
  }
}
