import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavouriteService {
  FavouriteService._() {
    _init();
  }
  static final FavouriteService instance = FavouriteService._();

  // Store keys like "title|by" for campaigns
  final ValueNotifier<Set<String>> _favourites = ValueNotifier<Set<String>>({});

  ValueListenable<Set<String>> get favourites => _favourites;

  static String campaignKey(String title, String by) => "$title|$by";

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';
  DocumentReference<Map<String, dynamic>> get _doc =>
      FirebaseFirestore.instance.collection('users').doc(_uid).collection('private').doc('favourites');

  StreamSubscription<DocumentSnapshot>? _subscription;

  void _init() {
    if (_uid.isEmpty) {
      // No auth: keep local-only favourites
      return;
    }
    _subscription = _doc.snapshots().listen((snapshot) {
      if (snapshot.data() != null) {
        final data = snapshot.data()!;
        final keys = (data['keys'] as List<dynamic>?)?.cast<String>() ?? [];
        _favourites.value = Set<String>.from(keys);
      }
    });
  }

  void dispose() {
    _subscription?.cancel();
  }

  bool isFavourite(String title, String by) {
    return _favourites.value.contains(campaignKey(title, by));
  }

  void toggleFavourite(String title, String by) {
    final key = campaignKey(title, by);
    final next = Set<String>.from(_favourites.value);
    if (next.contains(key)) {
      next.remove(key);
    } else {
      next.add(key);
    }
    _favourites.value = next;
    _saveToFirestore(next);
  }

  Future<void> _saveToFirestore(Set<String> keys) async {
    if (_uid.isEmpty) {
      return;
    }
    try {
      await _doc.set({
        'keys': keys.toList(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {
      // Ignore errors for now
    }
  }
}


