import 'package:charity/src/features/create_account/cubits/user_cubit.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileManagementScreen extends StatefulWidget {
  const ProfileManagementScreen({Key? key}) : super(key: key);

  @override
  State<ProfileManagementScreen> createState() =>
      _ProfileManagementScreenState();
}

class _ProfileManagementScreenState extends State<ProfileManagementScreen> {
  bool donateAsAnonymous = false;
  double walletBalance = 500.00;
  double donatedAmount = 150.00;
  String userName = 'User';

  @override
  void initState() {
    super.initState();
    final user = context.read<UserCubit>().state;
    if (user != null) {
      userName = '${user.firstName} ${user.lastName}';
      walletBalance = user.wallet.toDouble();
      donatedAmount = user.donatedAmount.toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    userName = user != null ? '${user.firstName} ${user.lastName}' : 'User';
    walletBalance = user != null ? user.wallet.toDouble() : 0.0;
    donatedAmount = user != null ? user.donatedAmount.toDouble() : 0.0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(user?.avatarUrl ?? ''),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, $userName',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Donated $donatedAmount',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),

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
                            fontWeight: FontWeight.bold,
                          ),
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
                      onPressed: () {},
                      child: const Text('Top up'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              _buildMenuItem(
                icon: Icons.receipt_long,
                text: 'Transactions',
                onTap: () => Navigator.pushNamed(context, Routes.transactions),
              ),
              _buildMenuItem(
                icon: Icons.calculate,
                text: 'Zakat calculator',
                onTap: () =>
                    Navigator.pushNamed(context, Routes.zakatCalculator),
              ),
              _buildMenuItem(
                icon: Icons.add,
                text: 'Add campaign',
                onTap: () => Navigator.pushNamed(context, Routes.add_donate),
              ),
              _buildMenuItem(
                icon: Icons.edit,
                text: 'Edit profile',
                onTap: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    Routes.editProfile,
                  );
                  if (result is Map &&
                      result['name'] is String &&
                      (result['name'] as String).trim().isNotEmpty) {
                    setState(() {
                      userName = (result['name'] as String).trim();
                    });
                  }
                },
              ),

              ListTile(
                leading: const Icon(Icons.visibility_off),
                title: const Text(
                  'Donate as anonymous',
                  style: TextStyle(fontSize: 16),
                ),
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
                onTap: () => Navigator.pushNamed(context, Routes.inviteFriends),
              ),
              _buildMenuItem(
                icon: Icons.settings,
                text: 'Settings',
                onTap: () => Navigator.pushNamed(context, Routes.settings),
              ),
              _buildMenuItem(
                icon: Icons.logout,
                text: 'Logout',
                onTap: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    context.read<UserCubit>().clearUser();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logged out successfully')),
                    );
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.signInEmail,
                      (route) => false,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logout failed: $e')),
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
      title: Text(text, style: TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
