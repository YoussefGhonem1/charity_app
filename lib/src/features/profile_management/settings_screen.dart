import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false; // Demo only; not wiring a full theme switch here
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          _buildSectionTitle(context, 'Preferences'),
          SwitchListTile(
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() => _notificationsEnabled = value);
              _toast('Notifications ${value ? 'enabled' : 'disabled'}');
            },
            title: const Text('Notifications'),
            secondary: const Icon(Icons.notifications),
            activeColor: AppColors.primaryColor,
          ),
          SwitchListTile(
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() => _darkModeEnabled = value);
              _toast('Dark mode ${value ? 'enabled' : 'disabled'}');
            },
            title: const Text('Dark mode'),
            secondary: const Icon(Icons.dark_mode),
            activeColor: AppColors.primaryColor,
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: Text(_language),
            trailing: const Icon(Icons.chevron_right),
            onTap: _pickLanguage,
          ),

          const Divider(),
          _buildSectionTitle(context, 'About'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About app'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Charity App',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2025 Charity Org',
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy policy'),
            onTap: () {
              _toast('Open privacy policy');
            },
          ),

          const Divider(),
          _buildSectionTitle(context, 'Danger zone'),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Log out'),
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
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _pickLanguage() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () => Navigator.pop(context, 'English'),
              ),
              ListTile(
                title: const Text('Arabic'),
                onTap: () => Navigator.pop(context, 'Arabic'),
              ),
            ],
          ),
        );
      },
    );
    if (selected != null) {
      setState(() => _language = selected);
      _toast('Language set to $selected');
    }
  }

  Future<void> _confirmLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Log out', style: TextStyle(color: AppColors.primaryColor)),
            ),
          ],
        );
      },
    );
    if (confirmed == true) {
      _toast('Logged out');
      Navigator.pop(context);
    }
  }
}


