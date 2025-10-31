import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionItem {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  TransactionItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  factory TransactionItem.fromMap(String id, Map<String, dynamic> map) {
    return TransactionItem(
      id: id,
      title: (map['title'] as String?) ?? '',
      amount: ((map['amount'] as num?) ?? 0).toDouble(),
      date: DateTime.tryParse((map['date'] as String?) ?? '') ?? DateTime.fromMillisecondsSinceEpoch((map['dateMs'] as int?) ?? DateTime.now().millisecondsSinceEpoch),
    );
  }
}

class TransactionsState {
  final bool loading;
  final List<TransactionItem> items;

  const TransactionsState({required this.loading, required this.items});

  TransactionsState copyWith({bool? loading, List<TransactionItem>? items}) =>
      TransactionsState(loading: loading ?? this.loading, items: items ?? this.items);
}

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit() : super(const TransactionsState(loading: false, items: []));

  Future<void> fetch() async {
    emit(state.copyWith(loading: true));
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      emit(state.copyWith(loading: false, items: []));
      return;
    }
    final snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('transactions')
        .orderBy('dateMs', descending: true)
        .get();
    final items = snap.docs.map((d) => TransactionItem.fromMap(d.id, d.data())).toList();
    emit(TransactionsState(loading: false, items: items));
  }
}


