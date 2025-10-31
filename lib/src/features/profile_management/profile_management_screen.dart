import 'package:charity/src/features/create_account/cubits/user_cubit.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
<<<<<<< HEAD
import '../../shared/state/profile_service.dart';
import 'dart:io';
import 'data/settings_repository.dart';
import 'data/profile_repository.dart';
import 'package:charity/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
=======
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
>>>>>>> develop

class ProfileManagementScreen extends StatefulWidget {
  const ProfileManagementScreen({super.key});

  @override
  State<ProfileManagementScreen> createState() =>
      _ProfileManagementScreenState();
}

class _ProfileManagementScreenState extends State<ProfileManagementScreen> {
  bool donateAsAnonymous = false;
  double walletBalance = 500.00;
<<<<<<< HEAD
  late String userName;
  String? avatar;
=======
  double donatedAmount = 150.00;
  String userName = 'User';
>>>>>>> develop

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    final p = ProfileService.instance.profile.value;
    userName = p.name;
    avatar = p.avatarPathOrUrl;
    ProfileService.instance.profile.addListener(() {
      final p2 = ProfileService.instance.profile.value;
      if (!mounted) return;
      setState(() {
        userName = p2.name;
        avatar = p2.avatarPathOrUrl;
      });
    });
    // Listen to Firestore profile and settings
    ProfileRepository.instance.profileStream().listen((data) {
      if (data == null || !mounted) return;
      setState(() {
        userName = (data['name'] as String?) ?? userName;
        avatar = (data['avatarUrl'] as String?) ?? avatar;
      });
    });
    SettingsRepository.instance.settingsStream().listen((data) {
      if (!mounted) return;
      setState(() {
        donateAsAnonymous = (data?['donateAsAnonymous'] as bool?) ?? donateAsAnonymous;
      });
    });
=======
    final user = context.read<UserCubit>().state;
    if (user != null) {
      userName = '${user.firstName} ${user.lastName}';
      walletBalance = user.wallet.toDouble();
      donatedAmount = user.donatedAmount.toDouble();
    }
>>>>>>> develop
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final t = AppLocalizations.of(context);
=======
    final user = context.watch<UserCubit>().state;
    userName = user != null ? '${user.firstName} ${user.lastName}' : 'User';
    walletBalance = user != null ? user.wallet.toDouble() : 0.0;
    donatedAmount = user != null ? user.donatedAmount.toDouble() : 0.0;

>>>>>>> develop
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
<<<<<<< HEAD
                    backgroundImage: avatar == null
                        ? null
                        : (avatar!.startsWith('http')
                            ? NetworkImage(avatar!) as ImageProvider
                            : FileImage(File(avatar!))),
                    child: avatar == null ? const Icon(Icons.person, size: 30) : null,
=======
                    backgroundImage: NetworkImage(user?.avatarUrl ?? ''),
>>>>>>> develop
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
<<<<<<< HEAD
                        t.hello(userName),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        t.donated('\$150K'),
=======
                        'Hello, $userName',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Donated $donatedAmount',
>>>>>>> develop
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
                        Text(
                          t.donationWallet,
                          style: const TextStyle(color: Colors.white70),
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
<<<<<<< HEAD
                      onPressed: () {
                        setState(() {
                          walletBalance += 100;
                        });
                      },
                      child: Text(t.topUp),
=======
                      onPressed: () {},
                      child: const Text('Top up'),
>>>>>>> develop
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              _buildMenuItem(
                icon: Icons.receipt_long,
<<<<<<< HEAD
                text: t.transactions,
                onTap: () => Navigator.pushNamed(context, '/transactions'),
=======
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
>>>>>>> develop
              ),
              _buildMenuItem(
                icon: Icons.edit,
                text: t.editProfile,
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
<<<<<<< HEAD
                title: Text(t.donateAsAnonymous),
=======
                title: const Text(
                  'Donate as anonymous',
                  style: TextStyle(fontSize: 16),
                ),
>>>>>>> develop
                trailing: Switch(
                  value: donateAsAnonymous,
                  onChanged: (value) async {
                    setState(() {
                      donateAsAnonymous = value;
                    });
                    await SettingsRepository.instance.updateSettings(donateAsAnonymous: value);
                  },
                  activeThumbColor: AppColors.primaryColor,
                ),
              ),

              _buildMenuItem(
                icon: Icons.group_add,
<<<<<<< HEAD
                text: t.inviteFriends,
                onTap: () => Navigator.pushNamed(context, '/invite'),
              ),
              _buildMenuItem(
                icon: Icons.settings,
                text: t.settings,
                onTap: () => Navigator.pushNamed(context, '/settings'),
              ),
              _buildMenuItem(
                icon: Icons.logout,
                text: t.logout,
                onTap: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                  } catch (_) {}
                  // Clear local profile state immediately
                  ProfileService.instance.update(
                    const UserProfile(name: '', email: '', phone: '', avatarPathOrUrl: null),
                  );
                  if (!mounted) return;
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.initial,
                    (route) => false,
                  );
=======
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
>>>>>>> develop
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
