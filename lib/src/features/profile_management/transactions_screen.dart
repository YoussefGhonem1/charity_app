import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'data/transactions_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
<<<<<<< HEAD
=======
  final List<_Transaction> _transactions = [
    _Transaction(
      title: 'Donation to Education Fund',
      amount: 50.00,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    _Transaction(
      title: 'Monthly Subscription',
      amount: 25.00,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    _Transaction(
      title: 'Emergency Relief',
      amount: 100.00,
      date: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

>>>>>>> develop
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.greyShade200),
              ),
<<<<<<< HEAD
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: TransactionsRepository.instance.transactionsStream(),
                builder: (context, snapshot) {
                  final txs = snapshot.data ?? const [];
                  final total = txs.fold<double>(0, (acc, t) => acc + ((t['amount'] ?? 0) as num).toDouble());
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total donated', style: TextStyle(color: Colors.black54)),
                      Text('\$${total.toStringAsFixed(2)}', style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  );
                },
=======
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total donated',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                  Text(
                    '4${total.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
>>>>>>> develop
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: _refresh,
<<<<<<< HEAD
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: TransactionsRepository.instance.transactionsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final txs = snapshot.data ?? const [];
                  if (txs.isEmpty) {
                    return const Center(child: Text('No transactions yet'));
                  }
                  return ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    itemBuilder: (context, index) {
                      final t = txs[index];
                      final createdAt = (t['createdAt'] as Timestamp?);
                      final date = createdAt?.toDate();
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
                          child: const Icon(Icons.volunteer_activism, color: Colors.black54),
                        ),
                        title: Text(t['title']?.toString() ?? 'Donation'),
                        subtitle: Text(date != null ? _formatDate(date) : ''),
                        trailing: Text(
                          '+\$${((t['amount'] ?? 0) as num).toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemCount: txs.length,
=======
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                itemBuilder: (context, index) {
                  final t = _transactions[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                      child: const Icon(
                        Icons.volunteer_activism,
                        color: Colors.black54,
                      ),
                    ),
                    title: Text(t.title, style: TextStyle(fontSize: 18)),
                    subtitle: Text(_formatDate(t.date)),
                    trailing: Text(
                      '+\u00024${t.amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
>>>>>>> develop
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        onPressed: _simulateAdd,
        icon: const Icon(Icons.add),
        label: const Text('Add test'),
      ),
    );
  }

  Future<void> _refresh() async {
    if (_loading) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _loading = false);
  }

  void _simulateAdd() {
<<<<<<< HEAD
    TransactionsRepository.instance.addTransaction(
      title: 'New donation',
      amount: 10.0,
      campaignTitle: 'Sample',
    );
=======
    setState(() {
      _transactions.insert(
        0,
        _Transaction(title: 'New donation', amount: 10.0, date: DateTime.now()),
      );
    });
>>>>>>> develop
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }
}

<<<<<<< HEAD

=======
class _Transaction {
  final String title;
  final double amount;
  final DateTime date;
  _Transaction({required this.title, required this.amount, required this.date});
}
>>>>>>> develop
