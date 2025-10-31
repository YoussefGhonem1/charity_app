import 'dart:async';
import 'package:flutter/material.dart';
import '../../features/profile_management/data/settings_repository.dart';

class SettingsController {
  SettingsController._() {
    _sub = SettingsRepository.instance.settingsStream().listen((data) {
      final lang = (data?['language'] as String?) ?? _languageName.value;
      final theme = (data?['themeMode'] as String?) ?? _themeModeName.value;
      setLanguageByName(lang, persist: false);
      setThemeModeByName(theme, persist: false);
    });
  }

  static final SettingsController instance = SettingsController._();

  late final StreamSubscription _sub;

  final ValueNotifier<ThemeMode> themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);
  final ValueNotifier<Locale> locale = ValueNotifier<Locale>(const Locale('en'));

  // Keep simple string notifiers for UI labels
  final ValueNotifier<String> _languageName = ValueNotifier<String>('English');
  final ValueNotifier<String> _themeModeName = ValueNotifier<String>('light');

  ValueNotifier<String> get languageName => _languageName;

  void setThemeMode(ThemeMode mode, {bool persist = true}) {
    themeMode.value = mode;
    _themeModeName.value = mode == ThemeMode.dark ? 'dark' : mode == ThemeMode.system ? 'system' : 'light';
    if (persist) {
      SettingsRepository.instance.updateSettings(language: null).ignore();
    }
  }

  void setThemeModeByName(String name, {bool persist = true}) {
    final normalized = name.toLowerCase();
    if (normalized == 'dark') {
      themeMode.value = ThemeMode.dark;
    } else if (normalized == 'system') {
      themeMode.value = ThemeMode.system;
    } else {
      themeMode.value = ThemeMode.light;
    }
    _themeModeName.value = normalized;
    if (persist) {
      SettingsRepository.instance.updateSettings().ignore();
    }
  }

  void setLanguageByName(String language, {bool persist = true}) {
    final isArabic = language.toLowerCase().startsWith('ar');
    locale.value = Locale(isArabic ? 'ar' : 'en');
    _languageName.value = isArabic ? 'Arabic' : 'English';
    if (persist) {
      SettingsRepository.instance.updateSettings(language: _languageName.value);
    }
  }

  void dispose() {
    _sub.cancel();
  }
}

extension on Future<void> {
  void ignore() {}
}


