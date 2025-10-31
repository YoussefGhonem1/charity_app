import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileRepository {
  ProfileRepository._();
  static final ProfileRepository instance = ProfileRepository._();

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';
  DocumentReference<Map<String, dynamic>> get _doc =>
      FirebaseFirestore.instance.collection('users').doc(_uid);

  Stream<Map<String, dynamic>?> profileStream() {
    if (_uid.isEmpty) {
      return Stream.value(null);
    }
    return _doc.snapshots().map((snap) => snap.data());
  }

  Future<void> upsertProfile({
    required String name,
    required String email,
    required String phone,
    String? avatarUrl,
  }) async {
    if (_uid.isEmpty) {
      return;
    }
    await _doc.set({
      'name': name,
      'email': email,
      'phone': phone,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<String> uploadAvatar(File file) async {
    if (_uid.isEmpty) {
      throw StateError('No authenticated user');
    }
    final ref = FirebaseStorage.instance
        .ref()
        .child('users')
        .child(_uid)
        .child('avatar.jpg');
    await ref.putFile(file, SettableMetadata(contentType: 'image/jpeg'));
    return await ref.getDownloadURL();
  }
}


