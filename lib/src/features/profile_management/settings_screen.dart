import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:charity/src/shared/localization/app_translations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity/src/shared/cubits/theme_cubit.dart';
import 'package:charity/src/shared/cubits/locale_cubit.dart';
import 'package:charity/src/features/profile_management/cubits/settings_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen();

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    final t = AppTranslations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.settings)),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          _buildSectionTitle(context, t.preferences),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, settings) {
              return SwitchListTile(
                value: settings.notificationsEnabled,
                onChanged: (value) {
                  context.read<SettingsCubit>().setNotifications(value);
                  _toast(value ? t.translate('notifications_enabled') : t.translate('notifications_disabled'));
                },
                title: Text(t.notifications, style: const TextStyle(fontSize: 18)),
                secondary: const Icon(Icons.notifications),
                activeThumbColor: AppColors.primaryColor,
              );
            },
          ),
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, mode) {
              final enabled = mode == ThemeMode.dark;
              return SwitchListTile(
                value: enabled,
                onChanged: (value) {
                  context.read<ThemeCubit>().toggleDark(value);
                  _toast(value ? t.translate('dark_mode_enabled') : t.translate('dark_mode_disabled'));
                },
                title: Text(t.darkMode, style: const TextStyle(fontSize: 18)),
                secondary: const Icon(Icons.dark_mode),
                activeThumbColor: AppColors.primaryColor,
              );
            },
          ),
          BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              final language = locale.languageCode == 'ar' ? t.arabic : t.english;
              return ListTile(
                leading: const Icon(Icons.language),
                title: Text(t.language, style: const TextStyle(fontSize: 18)),
                subtitle: Text(language),
                trailing: const Icon(Icons.chevron_right),
                onTap: _pickLanguage,
              );
            },
          ),

          const Divider(),
          _buildSectionTitle(context, t.about),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(t.aboutApp, style: const TextStyle(fontSize: 18)),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: t.appName,
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2025 Charity Org',
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(t.privacyPolicy, style: const TextStyle(fontSize: 18)),
            onTap: () {
              _toast(t.openPrivacyPolicy);
            },
          ),

          const Divider(),
          _buildSectionTitle(context, t.dangerZone),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: Text(t.logOut, style: const TextStyle(fontSize: 18)),
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
    final t = AppTranslations.of(context);
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        final translations = AppTranslations.of(context);
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(translations.english),
                onTap: () => Navigator.pop(context, 'English'),
              ),
              ListTile(
                title: Text(translations.arabic),
                onTap: () => Navigator.pop(context, 'Arabic'),
              ),
            ],
          ),
        );
      },
    );
    if (selected != null) {
      if (!context.mounted) return;
      final locale = selected == 'Arabic' ? const Locale('ar') : const Locale('en');
      context.read<LocaleCubit>().setLocale(locale);
      final updatedT = AppTranslations.of(context);
      final languageName = selected == 'Arabic' ? updatedT.arabic : updatedT.english;
      _toast('${t.translate('language_set_to')} $languageName');
    }
  }

  Future<void> _confirmLogout() async {
    final t = AppTranslations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        final translations = AppTranslations.of(context);
        return AlertDialog(
          title: Text(translations.logOut),
          content: Text(translations.areYouSureLogout),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(translations.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                translations.logOut,
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
          ],
        );
      },
    );
    if (confirmed == true) {
      await FirebaseAuth.instance.signOut();
      if (!mounted) return;
      Navigator.pop(context);
    }
  }
}
