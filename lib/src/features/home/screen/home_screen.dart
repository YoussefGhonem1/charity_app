import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/campaign_model.dart';
import '../widgets/feature_campaign_card.dart';
import '../widgets/lastest_campaign_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? user;
  double wallet = 0;
  List<CampaignModel> campaigns = [];
  List<CampaignModel> filteredCampaigns = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchCampaigns();
  }

  Future<void> fetchUserData() async {
    try {
      var userDoc = await FirebaseFirestore.instance.collection('users').doc('USER_ID').get();
      setState(() {
        user = UserModel.fromFirestore(userDoc.data() as Map<String, dynamic>);
        wallet = (userDoc['wallet'] as num).toDouble();
      });
    } catch (e) {
      debugPrint('Error loading user: $e');
    }
  }

  Future<void> fetchCampaigns() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection('campaigns').get();
      setState(() {
        campaigns = snapshot.docs.map((doc) {
          return CampaignModel.fromFirestore(doc.data() as Map<String, dynamic>);
        }).toList();
        filteredCampaigns = campaigns;
      });
    } catch (e) {
      debugPrint('Error loading campaigns: $e');
    }
  }

  void updateSearch(String value) {
    setState(() {
      query = value;
      filteredCampaigns = campaigns
          .where((c) => c.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF8),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user!.avatarUrl),
                radius: 24,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello, ${user!.name}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text("Donated ${user!.donatedAmount}",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
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
                        const Text("Donation Wallet",
                            style: TextStyle(color: Colors.white, fontSize: 16)),
                        const SizedBox(height: 10),
                        Text("\$$wallet.00",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold))
                      ]),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text("Top up",
                          style: TextStyle(
                              color: Colors.pinkAccent, fontWeight: FontWeight.bold)))
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            onChanged: updateSearch,
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
              itemCount: filteredCampaigns.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final campaign = filteredCampaigns[index];
                return FeatureCampaignCard(
                  campaign: campaign,
                  isFavourite: false,
                  onFavouriteTap: () {},
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text('Latest Campaigns',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 12),
          ...filteredCampaigns.map((c) => LastestCampaignCard(campaign: c)).toList(),
        ],
      ),
    );
  }
}
