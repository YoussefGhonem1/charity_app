import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionsRepository {
  TransactionsRepository._();
  static final TransactionsRepository instance = TransactionsRepository._();

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';
  CollectionReference<Map<String, dynamic>> get _col => FirebaseFirestore
      .instance
      .collection('users')
      .doc(_uid)
      .collection('transactions');

  Stream<List<Map<String, dynamic>>> transactionsStream() {
    if (_uid.isEmpty) {
      return Stream.value(<Map<String, dynamic>>[]);
    }
    return _col.orderBy('createdAt', descending: true).snapshots().map(
          (s) => s.docs.map((d) => d.data()).toList(),
        );
  }

  Future<void> addTransaction({
    required String title,
    required double amount,
    required String campaignTitle,
  }) async {
    if (_uid.isEmpty) {
      return;
    }
    await _col.add({
      'title': title,
      'amount': amount,
      'campaignTitle': campaignTitle,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}


