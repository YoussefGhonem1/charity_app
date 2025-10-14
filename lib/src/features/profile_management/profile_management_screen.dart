import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';

class ProfileManagementScreen extends StatefulWidget {
  const ProfileManagementScreen({Key? key}) : super(key: key);

  @override
  State<ProfileManagementScreen> createState() => _ProfileManagementScreenState();
}

class _ProfileManagementScreenState extends State<ProfileManagementScreen> {
  bool donateAsAnonymous = false;
  double walletBalance = 500.00;
  String userName = 'Mr Hegazy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Account Tab
        onTap: (index) {
          // 👇 Simple navigation example
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/favourite');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/categories');
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourite'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // 🔸 Header
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: const NetworkImage(
                      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, ' + userName,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Donated \$150K',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // 💰 Donation Wallet Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Donation wallet',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          '\$${walletBalance.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          walletBalance += 100;
                        });
                      },
                      child: const Text('Top up'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // 📌 Menu Options
              _buildMenuItem(
                icon: Icons.receipt_long,
                text: 'Transactions',
                onTap: () => Navigator.pushNamed(context, '/transactions'),
              ),
              _buildMenuItem(
                icon: Icons.edit,
                text: 'Edit profile',
                onTap: () async {
                  final result = await Navigator.pushNamed(context, '/edit-profile');
                  if (result is Map && result['name'] is String && (result['name'] as String).trim().isNotEmpty) {
                    setState(() {
                      userName = (result['name'] as String).trim();
                    });
                  }
                },
              ),

              // 🔘 Toggle
              ListTile(
                leading: const Icon(Icons.visibility_off),
                title: const Text('Donate as anonymous'),
                trailing: Switch(
                  value: donateAsAnonymous,
                  onChanged: (value) {
                    setState(() {
                      donateAsAnonymous = value;
                    });
                  },
                  activeColor: AppColors.primaryColor,
                ),
              ),

              _buildMenuItem(
                icon: Icons.group_add,
                text: 'Invite friends',
                onTap: () => Navigator.pushNamed(context, '/invite'),
              ),
              _buildMenuItem(
                icon: Icons.settings,
                text: 'Settings',
                onTap: () => Navigator.pushNamed(context, '/settings'),
              ),
              _buildMenuItem(
                icon: Icons.logout,
                text: 'Logout',
                onTap: () {
                  // 👇 Here you can add your logout logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logged out successfully')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
