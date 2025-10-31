import 'package:charity/src/features/home/models/campaign_model.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/widgets/button.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/text_form.dart';

class DonationPage extends StatelessWidget {
final CampaignModel campaign;

  const DonationPage({super.key,    required this.campaign,
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),

          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    campaign.imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                                campaign.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 8),

                  Row(
                    children: [
                      Text(
                        "By ${campaign.organization}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFE7277),
                        ),
                      ),
                      Text(
                        " Unesco",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFE7277),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(width: 4),

                      Icon(Icons.verified, color: Colors.green, size: 16),
                    ],
                  ),
                  SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
"${(campaign.progress * 100).round()}%",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "10 days left",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),

                  Text(
                    "fund raised from \$5000",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: campaign.progress,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFFFE7277),
                    ),
                    borderRadius: BorderRadius.circular(3),

                    minHeight: 8,
                  ),
                  SizedBox(height: 4),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Raised",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),

                      Text(
                        "80%",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop&crop=face',
                            ),
                          ),

                          Positioned(
                            left: 16,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1494790108755-2616b2e5ae1c?w=100&h=100&fit=crop&crop=face',
                              ),
                            ),
                          ),

                          Positioned(
                            left: 32,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop&crop=face',
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(width: 40),
                      Text(
                       "+${campaign.donatedAmount.toInt()} people donated",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  Row(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.grey,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Emergencies',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                                          campaign.location,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: ContinueButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.donate);
                          },
                          text: "Donate Now",
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ContinueButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                TextEditingController otherController = TextEditingController();
                                bool showTextField = false;
                                int selectedIndex = -1;

                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: Center(
                                        child: Text(
                                          'Choose With What You Will Help',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              leading: Icon(Icons.school, color: Colors.purple, size: 27),
                                              title: Text(
                                                'Educational Support',
                                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                              ),
                                              selected: selectedIndex == 0,
                                              selectedTileColor: Colors.purple.withOpacity(0.07),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: selectedIndex == 0 ? Colors.purple : Colors.transparent,
                                                  width: 2,
                                                ),
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = 0;
                                                  showTextField = false;
                                                });
                                              },
                                            ),
                                            Divider(),
                                            ListTile(
                                              leading: Icon(Icons.medical_services, color: Colors.blueAccent, size: 27),
                                              title: Text(
                                                'Care Support',
                                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                              ),
                                              selected: selectedIndex == 1,
                                              selectedTileColor: Colors.blueAccent.withOpacity(0.07),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: selectedIndex == 1 ? Colors.blueAccent : Colors.transparent,
                                                  width: 2,
                                                ),
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = 1;
                                                  showTextField = false;
                                                });
                                              },
                                            ),
                                            Divider(),
                                            ListTile(
                                              leading: Icon(Icons.help_outline, color: Colors.orangeAccent, size: 27),
                                              title: Text(
                                                'Item Donation',
                                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                              ),
                                              selected: selectedIndex == 2,
                                              selectedTileColor: Colors.orangeAccent.withOpacity(0.07),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: selectedIndex == 2 ? Colors.orangeAccent : Colors.transparent,
                                                  width: 2,
                                                ),
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = 2;
                                                  showTextField = false;
                                                });
                                              },
                                            ),
                                            Divider(),
                                            ListTile(
                                              leading: Icon(Icons.volunteer_activism, color: Colors.red, size: 27),
                                              title: Text(
                                                'Field Volunteering',
                                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                              ),
                                              selected: selectedIndex == 3,
                                              selectedTileColor: Colors.red.withOpacity(0.07),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: selectedIndex == 3 ? Colors.red : Colors.transparent,
                                                  width: 2,
                                                ),
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = 3;
                                                  showTextField = false;
                                                });
                                              },
                                            ),
                                            Divider(),
                                            ListTile(
                                              leading: Icon(Icons.emoji_emotions_outlined, color: Colors.pinkAccent, size: 27),
                                              title: Text(
                                                'Emotional Support',
                                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                              ),
                                              selected: selectedIndex == 4,
                                              selectedTileColor: Colors.pinkAccent.withOpacity(0.07),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: selectedIndex == 4 ? Colors.pinkAccent : Colors.transparent,
                                                  width: 2,
                                                ),
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = 4;
                                                  showTextField = false;
                                                });
                                              },
                                            ),
                                            Divider(),
                                            ListTile(
                                              leading: Icon(Icons.food_bank_outlined, color: Colors.greenAccent, size: 27),
                                              title: Text(
                                                'Feeding',
                                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                              ),
                                              selected: selectedIndex == 5,
                                              selectedTileColor: Colors.greenAccent.withOpacity(0.07),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: selectedIndex == 5 ? Colors.greenAccent : Colors.transparent,
                                                  width: 2,
                                                ),
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = 5;
                                                  showTextField = false;
                                                });
                                              },
                                            ),
                                            Divider(),
                                            ListTile(
                                              leading: Icon(Icons.more_horiz, color: Colors.blueGrey, size: 27),
                                              title: Text(
                                                'Other',
                                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                              ),
                                              selected: selectedIndex == 6,
                                              selectedTileColor: Colors.blueGrey.withOpacity(0.07),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: selectedIndex == 6 ? Colors.blueGrey : Colors.transparent,
                                                  width: 2,
                                                ),
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = 6;
                                                  showTextField = true;
                                                });
                                              },
                                            ),
                                            if (showTextField) ...[
                                              SizedBox(height: 16),
                                              CustomTextField(
                                                controller: otherController,
                                                hintText: "Write Here",
                                              ),
                                              SizedBox(height: 8),
                                              SizedBox(
                                                width: 90,
                                                height: 36,
                                                child: ContinueButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  text: "Send",
                                                ),
                                              ),
                                            ],
                                            SizedBox(height: 12),
                                            ContinueButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              text: "Continue",
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          text: "Donate Service",
                        ),
                      )


                    ],
                  ),
                  SizedBox(height: 32),


                  Text(
                    'Story',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(
                    'We are a national charity working to transform the hopes and happiness of young people facing abuse, exploitation and neglect. We support them through their most serious life challenges and we campaign tirelessly for the big social changes that will improve the lives of those who need hope mosst.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  SizedBox(height: 16),

                  Text(
                    'We are a national charity working to transform the hopes and happiness of young people facing abuse, exploitation and neglect. We support them through their most serious life challenges and we campaign tirelessly for the big social changes that will improve the lives of those who need hope most.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 32),

                  Text(
                    'Unesco',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 12),

                  Text(
                    'The United Nations Educational, Scientific and Cultural Organization is a specialized agency of the United Nations with the aim of promoting world peace and security through international cooperation in education, arts, sciences and culture.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 32),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color(0xFFFE7277),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fund Raised',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),

                              SizedBox(height: 4),

                              Text(
                                '\$1M',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: 12),

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color(0xFFFE7277),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'people Donated',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),

                              SizedBox(height: 4),
                              Text(
                                '30K',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFE7277),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


