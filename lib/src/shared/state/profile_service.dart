import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:charity/src/features/profile_management/data/profile_repository.dart';
import 'dart:async';

class UserProfile {
  final String name;
  final String email;
  final String phone;
  final String? avatarPathOrUrl; // file path or remote url

  const UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    this.avatarPathOrUrl,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? avatarPathOrUrl,
  }) => UserProfile(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        avatarPathOrUrl: avatarPathOrUrl ?? this.avatarPathOrUrl,
      );
}

class ProfileService {
  ProfileService._() {
    final currentEmail = FirebaseAuth.instance.currentUser?.email ?? '';
    if (currentEmail.isNotEmpty) {
      profile.value = profile.value.copyWith(email: currentEmail);
    }
    FirebaseAuth.instance.authStateChanges().listen((user) {
      final nextEmail = user?.email ?? '';
      profile.value = profile.value.copyWith(email: nextEmail);
      _listenProfileDoc();
    });
    _listenProfileDoc();
  }
  static final ProfileService instance = ProfileService._();

  final ValueNotifier<UserProfile> profile = ValueNotifier<UserProfile>(
    const UserProfile(
      name: '',
      email: '',
      phone: '',
      avatarPathOrUrl: null,
    ),
  );

  void update(UserProfile next) {
    profile.value = next;
  }

  StreamSubscription<Map<String, dynamic>?>? _profileSub;

  void _listenProfileDoc() {
    _profileSub?.cancel();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || uid.isEmpty) {
      profile.value = const UserProfile(name: '', email: '', phone: '', avatarPathOrUrl: null);
      return;
    }
    _profileSub = ProfileRepository.instance.profileStream().listen((data) {
      if (data == null) return;
      final current = profile.value;
      profile.value = UserProfile(
        name: (data['name'] ?? current.name ?? '').toString(),
        // Always reflect FirebaseAuth email, never override from Firestore
        email: FirebaseAuth.instance.currentUser?.email ?? current.email,
        phone: (data['phone'] ?? current.phone ?? '').toString(),
        avatarPathOrUrl: (data['avatarUrl'] as String?) ?? current.avatarPathOrUrl,
      );
    });
  }
}


