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
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: _refresh,
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
    TransactionsRepository.instance.addTransaction(
      title: 'New donation',
      amount: 10.0,
      campaignTitle: 'Sample',
    );
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }
}


