import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileManagementScreen extends StatefulWidget {
  const ProfileManagementScreen({Key? key}) : super(key: key);

  @override
  State<ProfileManagementScreen> createState() => _ProfileManagementScreenState();
}

class _ProfileManagementScreenState extends State<ProfileManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.user;
        
        if (userProvider.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        if (user == null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No user logged in'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, Routes.signInEmail),
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ),
          );
        }
        
        return _buildProfileScreen(user, userProvider);
      },
    );
  }

  Widget _buildProfileScreen(user, UserProvider userProvider) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Account Tab
        onTap: (index) {
          // 👇 Simple navigation example
          if (index == 0) {
            Navigator.pushNamed(context, Routes.homePage);
          } else if (index == 1) {
            Navigator.pushNamed(context, '/favourite');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/categories');
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.greenColor,
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
                    backgroundImage: NetworkImage(user.avatarUrl),
                    onBackgroundImageError: (exception, stackTrace) {
                      // Handle image loading error
                    },
                    child: user.avatarUrl.isEmpty 
                        ? const Icon(Icons.person, size: 30)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, ${user.name}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Donated ${user.donatedAmount}',
                        style: const TextStyle(color: Colors.grey),
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
                  color: AppColors.greenColor,
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
                          '\$${user.walletBalance.toStringAsFixed(2)}',
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
                        foregroundColor: AppColors.greenColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        await userProvider.updateWalletBalance(100);
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
                onTap: () => Navigator.pushNamed(context, Routes.editProfile),
              ),

              // 🔘 Toggle
              ListTile(
                leading: const Icon(Icons.visibility_off),
                title: const Text('Donate as anonymous'),
                trailing: Switch(
                  value: user.donateAsAnonymous,
                  onChanged: (value) async {
                    await userProvider.updateAnonymousPreference(value);
                  },
                  activeColor: AppColors.greenColor,
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
                onTap: () async {
                  await userProvider.logout();
                  if (mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context, 
                      Routes.signInEmail, 
                      (route) => false,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logged out successfully')),
                    );
                  }
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
