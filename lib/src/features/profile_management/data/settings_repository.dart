import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsRepository {
  SettingsRepository._();
  static final SettingsRepository instance = SettingsRepository._();

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';
  DocumentReference<Map<String, dynamic>> get _doc =>
      FirebaseFirestore.instance.collection('users').doc(_uid).collection('private').doc('settings');

  Stream<Map<String, dynamic>?> settingsStream() {
    if (_uid.isEmpty) {
      return Stream.value(null);
    }
    return _doc.snapshots().map((s) => s.data());
  }

  Future<void> updateSettings({
    bool? notificationsEnabled,
    bool? donateAsAnonymous,
    String? language,
  }) async {
    if (_uid.isEmpty) {
      return;
    }
    await _doc.set({
      if (notificationsEnabled != null) 'notificationsEnabled': notificationsEnabled,
      if (donateAsAnonymous != null) 'donateAsAnonymous': donateAsAnonymous,
      if (language != null) 'language': language,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}


