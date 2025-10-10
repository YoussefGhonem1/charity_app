import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/campaign_model.dart';
import '../models/category_model.dart';
import '../models/location_model.dart';
import '../widgets/feature_campaign_card.dart';
import '../widgets/lastest_campaign_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/location_chip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserModel user = UserModel(
    "Mr Dat",
    "https://randomuser.me/api/portraits/men/32.jpg",
    "\$150K",
  );
  final double wallet = 500;

  List featureCampaigns = [
    CampaignModel(
      "Donation for Child",
      "Unesco",
      0.5,
      12300,
      "Emergencies",
      "Africa / Namibia",
      "https://media.hawzahnews.com/d/2019/11/03/4/866306.jpg",
    ),
    CampaignModel(
      "Help for Families",
      "Unesco",
      0.7,
      4530,
      "Social project",
      "Europe / France",
      "https://ofhsoupkitchen.org/wp-content/uploads/2021/02/charity-bible-verses-1-1024x683.jpg",
    ),
    CampaignModel(
      "Orphans Charity",
      "Unesco",
      0.6,
      7800,
      "Emergencies",
      "Asia / Indonesia",
      "https://storage.googleapis.com/wp-static/wp-orphansinneed/2023/12/07b86145-giving-charity-ramadan.jpeg",
    ),
    CampaignModel(
      "Donation Drive",
      "Unesco",
      0.9,
      19000,
      "Medical",
      "Africa / Nigeria",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7csJ8xtOjTamjyw5sw84GqlRCUowlLOQF8w&s",
    ),
  ];

  List categories = [
    CategoryModel("Emergencies"),
    CategoryModel("Social project"),
    CategoryModel("Medical"),
    CategoryModel("Education"),
    CategoryModel("Environment"),
    CategoryModel("Women Support"),
  ];

  List latestCampaigns = [
    CampaignModel(
      "Donation for Child",
      "Unesco",
      0.5,
      12300,
      "Emergencies",
      "Africa / Namibia",
      "https://media.hawzahnews.com/d/2019/11/03/4/866306.jpg",
    ),
    CampaignModel(
      "School Library Project",
      "Unesco",
      0.7,
      6700,
      "Education",
      "Asia / Indonesia",
      "https://ofhsoupkitchen.org/wp-content/uploads/2021/02/charity-bible-verses-1-1024x683.jpg",
    ),
    CampaignModel(
      "Medical Aid Campaign",
      "Unesco",
      0.4,
      3200,
      "Medical",
      "Africa / Kenya",
      "https://storage.googleapis.com/wp-static/wp-orphansinneed/2023/12/07b86145-giving-charity-ramadan.jpeg",
    ),
    CampaignModel(
      "Clean Water Action",
      "Unesco",
      0.6,
      2100,
      "Environment",
      "Africa / Nigeria",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7csJ8xtOjTamjyw5sw84GqlRCUowlLOQF8w&s",
    ),
  ];

  List locations = [
    LocationModel("Samarinda"),
    LocationModel("Jakarta"),
    LocationModel("Namibia"),
    LocationModel("France"),
    LocationModel("Kenya"),
    LocationModel("Nigeria"),
    LocationModel("Egypt"),
  ];

  List featureFav = [0, 0, 0, 0];
  List latestFav = [0, 0, 0, 0];

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
              Text("All Categories", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Wrap(
                spacing: 11, runSpacing: 9,
                children: categories.map((cat) => CategoryChip(category: cat)).toList(),
              ),
              SizedBox(height: 18),
              Text("All Locations", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Wrap(
                spacing: 11, runSpacing: 9,
                children: locations.map((loc) => LocationChip(location: loc)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7FAF8),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 25),
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.avatarUrl),
                  radius: 24,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello, ${user.name}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 2),
                    Text("Donated ${user.donatedAmount}", style: TextStyle(color: Colors.grey[500], fontSize: 13)),
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
                        Text("Donation wallet", style: TextStyle(fontSize: 15, color: Colors.white)),
                        SizedBox(height: 8),
                        Text("\$$wallet.00", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      backgroundColor: Colors.white,
                    ),
                    child: Text("Top up", style: TextStyle(color: Color(0xFFFE7277), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text("Feature Campaign", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            SizedBox(height: 14),
            SizedBox(
              height: 340,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: featureCampaigns.length,
                separatorBuilder: (_, __) => SizedBox(width: 12),
                itemBuilder: (context, i) => FeatureCampaignCard(
                  campaign: featureCampaigns[i],
                  isFavourite: featureFav[i] == 1,
                  onFavouriteTap: () {
                    setState(() => featureFav[i] = featureFav[i] == 1 ? 0 : 1);
                  },
                ),
              ),
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Categories", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                Spacer(),
                TextButton(
                  onPressed: showAllCategoriesLocations,
                  child: Text("See all", style: TextStyle(color: Color(0xFFFE7277), fontSize: 13)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 11, runSpacing: 9,
              children: categories.take(2).map((cat) => CategoryChip(category: cat)).toList(),
            ),
            SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Latest Campaign", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
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
              itemBuilder: (context, i) => LatestCampaignCard(
                campaign: latestCampaigns[i],
                isFavourite: latestFav[i] == 1,
                onFavouriteTap: () {
                  setState(() => latestFav[i] = latestFav[i] == 1 ? 0 : 1);
                },
              ),
            ),
            SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: showAllCategoriesLocations,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFE7277),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "See all",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Locations", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                TextButton(
                  onPressed: showAllCategoriesLocations,
                  child: Text("See all", style: TextStyle(color: Color(0xFFFE7277), fontSize: 13)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 11, runSpacing: 9,
              children: locations.take(3).map((loc) => LocationChip(location: loc)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
