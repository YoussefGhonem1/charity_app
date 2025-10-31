import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../home/data/campaign_repository.dart';
import '../home/models/campaign_model.dart';
import '../../shared/state/favourite_service.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  final repo = CampaignRepository.instance;
  final fav = FavouriteService.instance;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                color: const Color(0xFFFFEBEE), // Light red background
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Favourite',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.redAccent),
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: Icon(
                                  Icons.search_rounded,
                                  color: Colors.grey,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 13,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.filter_list, size: 30),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ValueListenableBuilder<Set<String>>(
                  valueListenable: fav.favourites,
                  builder: (context, set, _) {
                    final all = <CampaignModel>[
                      ...repo.featureCampaigns,
                      ...repo.latestCampaigns,
                    ];
                    final unique = {
                      for (final c in all) FavouriteService.campaignKey(c.title, c.by): c
                    };
                    final favCampaigns = unique.entries
                        .where((e) => set.contains(e.key))
                        .map((e) => e.value)
                        .toList();

                    if (favCampaigns.isEmpty) {
                      return const Center(
                        child: Text('No favourite campaigns yet'),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: favCampaigns.length,
                      itemBuilder: (context, index) {
                        final c = favCampaigns[index];
                        return DonationCard(
                          title: c.title,
                          org: c.by,
                          imageUrl: c.image,
                          progress: c.percent,
                          isFavourite: true,
                          onFavToggle: () {
                            setState(() {
                              fav.toggleFavourite(c.title, c.by);
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DonationCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String org;
  final double progress;
  final bool isFavourite;
  final VoidCallback onFavToggle;

  const DonationCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.org,
    required this.progress,
    required this.isFavourite,
    required this.onFavToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shadowColor: Colors.grey.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    imageUrl,
                    height: 110,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  onTap: onFavToggle,
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: isFavourite ? Colors.redAccent : Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 16.0),

            Expanded(
              child: SizedBox(
                height: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Text('By', style: TextStyle(color: Colors.grey)),
                        const SizedBox(width: 4.0),
                        Text(
                          org,
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        const Icon(
                          Icons.verified_outlined,
                          color: Colors.redAccent,
                          size: 16,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Raised',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '${(progress * 100).toInt()}%',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[300],
                          color: Colors.redAccent,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
