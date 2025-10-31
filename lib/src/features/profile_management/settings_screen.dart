import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'data/settings_repository.dart';
import 'package:charity/l10n/app_localizations.dart';
import '../../shared/state/settings_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import '../../shared/state/profile_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
<<<<<<< HEAD

  @override
  void initState() {
    super.initState();
    SettingsRepository.instance.settingsStream().listen((data) {
      if (!mounted) return;
      setState(() {
        _notificationsEnabled = (data?['notificationsEnabled'] as bool?) ?? _notificationsEnabled;
      });
    });
  }
=======
  bool _darkModeEnabled = false;
  String _language = 'English';
>>>>>>> develop

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final settings = SettingsController.instance;
    return Scaffold(
      appBar: AppBar(title: Text(t.settings)),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          _buildSectionTitle(context, t.preferences),
          SwitchListTile(
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() => _notificationsEnabled = value);
              SettingsRepository.instance.updateSettings(notificationsEnabled: value);
              _toast('${t.notifications} ${value ? t.enabled : t.disabled}');
            },
<<<<<<< HEAD
            title: Text(t.notifications),
=======
            title: const Text('Notifications', style: TextStyle(fontSize: 18)),
>>>>>>> develop
            secondary: const Icon(Icons.notifications),
            activeThumbColor: AppColors.primaryColor,
          ),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: settings.themeMode,
            builder: (_, mode, _) {
              return SwitchListTile(
                value: mode == ThemeMode.dark,
                onChanged: (value) {
                  settings.setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                  _toast('${t.darkMode} ${value ? t.enabled : t.disabled}');
                },
                title: Text(t.darkMode),
                secondary: const Icon(Icons.dark_mode),
                activeThumbColor: AppColors.primaryColor,
              );
            },
<<<<<<< HEAD
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(t.language),
            subtitle: ValueListenableBuilder<String>(
              valueListenable: settings.languageName,
              builder: (_, lang, _) => Text(lang),
            ),
=======
            title: const Text('Dark mode', style: TextStyle(fontSize: 18)),
            secondary: const Icon(Icons.dark_mode),
            activeColor: AppColors.primaryColor,
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language', style: TextStyle(fontSize: 18)),
            subtitle: Text(_language),
>>>>>>> develop
            trailing: const Icon(Icons.chevron_right),
            onTap: _pickLanguage,
          ),

          const Divider(),
          _buildSectionTitle(context, t.about),
          ListTile(
            leading: const Icon(Icons.info_outline),
<<<<<<< HEAD
            title: Text(t.aboutApp),
=======
            title: const Text('About app', style: TextStyle(fontSize: 18)),
>>>>>>> develop
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: t.appTitle,
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2025 Charity Org',
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
<<<<<<< HEAD
            title: Text(t.privacyPolicy),
=======
            title: const Text('Privacy policy', style: TextStyle(fontSize: 18)),
>>>>>>> develop
            onTap: () {
              _toast(t.openPrivacyPolicy);
            },
          ),

          const Divider(),
          _buildSectionTitle(context, t.dangerZone),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
<<<<<<< HEAD
            title: Text(t.logout),
=======
            title: const Text('Log out', style: TextStyle(fontSize: 18)),
>>>>>>> develop
            onTap: _confirmLogout,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _toast(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _pickLanguage() async {
    final t = AppLocalizations.of(context);
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(t.english),
                onTap: () => Navigator.pop(context, 'English'),
              ),
              ListTile(
                title: Text(t.arabic),
                onTap: () => Navigator.pop(context, 'Arabic'),
              ),
            ],
          ),
        );
      },
    );
    if (selected != null) {
      SettingsController.instance.setLanguageByName(selected);
      await SettingsRepository.instance.updateSettings(language: selected);
      _toast(t.languageSetTo(selected));
    }
  }

  Future<void> _confirmLogout() async {
    final t = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(t.logOutDialogTitle),
          content: Text(t.logOutDialogMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(t.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
<<<<<<< HEAD
              child: Text(t.logout, style: TextStyle(color: AppColors.primaryColor)),
=======
              child: Text(
                'Log out',
                style: TextStyle(color: AppColors.primaryColor),
              ),
>>>>>>> develop
            ),
          ],
        );
      },
    );
    if (!mounted) return;
    if (confirmed == true) {
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
    }
  }
}
