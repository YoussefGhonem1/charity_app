import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import '../../shared/state/profile_service.dart';
import 'dart:io';
import 'data/settings_repository.dart';
import 'data/profile_repository.dart';
import 'package:charity/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:charity/src/shared/routing/app_routs.dart';

class ProfileManagementScreen extends StatefulWidget {
  const ProfileManagementScreen({super.key});

  @override
  State<ProfileManagementScreen> createState() => _ProfileManagementScreenState();
}

class _ProfileManagementScreenState extends State<ProfileManagementScreen> {
  bool donateAsAnonymous = false;
  double walletBalance = 500.00;
  late String userName;
  String? avatar;

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
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
                    backgroundImage: avatar == null
                        ? null
                        : (avatar!.startsWith('http')
                            ? NetworkImage(avatar!) as ImageProvider
                            : FileImage(File(avatar!))),
                    child: avatar == null ? const Icon(Icons.person, size: 30) : null,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.hello(userName),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        t.donated('\$150K'),
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
                      child: Text(t.topUp),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // 📌 Menu Options
              _buildMenuItem(
                icon: Icons.receipt_long,
                text: t.transactions,
                onTap: () => Navigator.pushNamed(context, '/transactions'),
              ),
              _buildMenuItem(
                icon: Icons.edit,
                text: t.editProfile,
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
                title: Text(t.donateAsAnonymous),
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
