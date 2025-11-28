import 'package:charity/src/features/create_account/cubits/user_cubit.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/localization/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity/src/features/profile_management/cubits/settings_cubit.dart';

class ProfileManagementScreen extends StatefulWidget {
  const ProfileManagementScreen();

  @override
  State<ProfileManagementScreen> createState() =>
      _ProfileManagementScreenState();
}

class _ProfileManagementScreenState extends State<ProfileManagementScreen> {
  double walletBalance = 0.0;
  double donatedAmount = 0.0;
  String userName = '';
  bool _settingsLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = context.read<UserCubit>().state;
    if (user != null) {
      userName = '${user.firstName} ${user.lastName}';
      walletBalance = user.wallet;
      donatedAmount = user.donatedAmount;
    }
    if (!_settingsLoaded) {
      _settingsLoaded = true;
      context.read<SettingsCubit>().load();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppTranslations.of(context);
    final user = context.watch<UserCubit>().state;
    userName = user != null ? '${user.firstName} ${user.lastName}'.trim() : '';
    walletBalance = user?.wallet ?? 0.0;
    donatedAmount = user?.donatedAmount ?? 0.0;

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
                    backgroundImage: (user?.avatarUrl.isNotEmpty == true)
                        ? NetworkImage(user!.avatarUrl)
                        : null,
                    child: (user?.avatarUrl.isEmpty ?? true)
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName.isNotEmpty ? '${t.hello}, $userName' : t.hello,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      Text(
                        donatedAmount > 0
                            ? '${t.donated} \$${donatedAmount.toStringAsFixed(2)}'
                            : '',
                        style: TextStyle(color: Colors.grey),
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
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(t.topUpComingSoon)),
                        );
                      },
                      child: Text(t.topUp),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              _buildMenuItem(
                icon: Icons.receipt_long,
                text: t.transactions,
                onTap: () => Navigator.pushNamed(context, Routes.transactions),
              ),
              _buildMenuItem(
                icon: Icons.calculate,
                text: t.zakatCalculator,
                onTap: () =>
                    Navigator.pushNamed(context, Routes.zakatCalculator),
              ),
              _buildMenuItem(
                icon: Icons.lightbulb_outline,
                text: t.translate('knowledge_hub'),
                onTap: () => Navigator.pushNamed(context, Routes.knowledgeHub),
              ),
              _buildMenuItem(
                icon: Icons.add,
                text: t.addCampaign,
                onTap: () => Navigator.pushNamed(context, Routes.add_donate),
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
              BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, settings) {
                  return ListTile(
                    leading: const Icon(Icons.visibility_off),
                    title: Text(
                      t.donateAsAnonymous,
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: Switch(
                      value: settings.donateAsAnonymous,
                      onChanged: (value) {
                        context
                            .read<SettingsCubit>()
                            .setDonateAsAnonymous(value);
                      },
                      activeThumbColor: AppColors.primaryColor,
                    ),
                  );
                },
              ),
              _buildMenuItem(
                icon: Icons.group_add,
                text: t.inviteFriends,
                onTap: () => Navigator.pushNamed(context, Routes.inviteFriends),
              ),
              _buildMenuItem(
                icon: Icons.settings,
                text: t.settings,
                onTap: () => Navigator.pushNamed(context, Routes.settings),
              ),
              _buildMenuItem(
                icon: Icons.logout,
                text: t.logout,
                onTap: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    if (!context.mounted) return;
                    context.read<UserCubit>().clearUser();
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(t.loggedOutSuccessfully)),
                    );
                    if (!context.mounted) return;
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.signInEmail,
                      (route) => false,
                    );
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${t.logoutFailed}: $e')),
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
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
