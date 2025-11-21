import 'package:flutter/material.dart';
import '../../../shared/widgets/button.dart';
import '../../../shared/widgets/text_form.dart';
import '../../../shared/routing/app_routs.dart';
import '../../home/models/foundation_model.dart';

class FoundationPage extends StatelessWidget {
  final FoundationModel foundation;

  const FoundationPage({Key? key, required this.foundation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المؤسسة
            Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(foundation.imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // اسم المؤسسة
                  Text(
                    foundation.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // اسم المنظمة
                  Row(
                    children: [
                      Text(
                        "By ${foundation.organization}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFE7277),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.verified, color: Colors.green, size: 16),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // القسم والموقع
                  Row(
                    children: [
                      const Icon(Icons.category_outlined,
                          color: Colors.grey, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        foundation.category,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.location_on_outlined,
                          color: Colors.grey, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        foundation.location,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // زر التبرع
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
                      const SizedBox(width: 16),
                      Expanded(
                        child: ContinueButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                TextEditingController otherController =
                                    TextEditingController();
                                bool showTextField = false;
                                int selectedIndex = -1;

                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      title: const Center(
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
                                              leading: const Icon(
                                                  Icons.school,
                                                  color: Colors.purple),
                                              title: const Text(
                                                  'Educational Support'),
                                              selected: selectedIndex == 0,
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = 0;
                                                  showTextField = false;
                                                });
                                              },
                                            ),
                                            const Divider(),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.medical_services,
                                                  color: Colors.blueAccent),
                                              title:
                                                  const Text('Care Support'),
                                              selected: selectedIndex == 1,
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = 1;
                                                  showTextField = false;
                                                });
                                              },
                                            ),
                                            const Divider(),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.volunteer_activism,
                                                  color: Colors.red),
                                              title: const Text(
                                                  'Field Volunteering'),
                                              selected: selectedIndex == 2,
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = 2;
                                                  showTextField = false;
                                                });
                                              },
                                            ),
                                            const Divider(),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.more_horiz,
                                                  color: Colors.blueGrey),
                                              title: const Text('Other'),
                                              selected: selectedIndex == 3,
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = 3;
                                                  showTextField = true;
                                                });
                                              },
                                            ),
                                            if (showTextField) ...[
                                              const SizedBox(height: 16),
                                              CustomTextField(
                                                controller: otherController,
                                                hintText: "Write Here",
                                              ),
                                              const SizedBox(height: 8),
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
                                            const SizedBox(height: 12),
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
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // القصة أو الوصف
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    foundation.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.5,
                    ),
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