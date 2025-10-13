import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Map<String, dynamic>> donations = [
    {
      'title': 'Donation for Child',
      'org': 'Unesco',
      'image':
          'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?w=500&q=80',
      'progress': 0.7,
      'isFav': true,
    },
    {
      'title': 'Feed the Hungry',
      'org': 'Red Cross',
      'image':
          'https://images.unsplash.com/photo-1532629345422-7515f3d16bb6?w=500&q=80',
      'progress': 0.5,
      'isFav': true,
    },

    {
      'title': 'Education for All',
      'org': 'Unesco',
      'image':
          'https://images.unsplash.com/photo-1588072432836-e10032774350?w=500&q=80',
      'progress': 0.8,
      'isFav': true,
    },
    {
      'title': 'Save the Planet',
      'org': 'Wwf',
      'image':
          'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=500&q=80',
      'progress': 0.6,
      'isFav': false,
    },
  ];

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
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: donations.length,
                  itemBuilder: (context, index) {
                    final donation = donations[index];
                    return DonationCard(
                      title: donation['title'],
                      org: donation['org'],
                      imageUrl: donation['image'],
                      progress: donation['progress'],
                      isFavourite: donation['isFav'],
                      onFavToggle: () {
                        setState(() {
                          donation['isFav'] = !donation['isFav'];
                        });
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
      shadowColor: Colors.grey.withOpacity(0.2),
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
                      color: Colors.grey.withOpacity(0.8),
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
