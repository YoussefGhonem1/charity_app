import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final List<_Transaction> _transactions = [
    _Transaction(title: 'Donation to Education Fund', amount: 50.00, date: DateTime.now().subtract(const Duration(days: 1))),
    _Transaction(title: 'Monthly Subscription', amount: 25.00, date: DateTime.now().subtract(const Duration(days: 3))),
    _Transaction(title: 'Emergency Relief', amount: 100.00, date: DateTime.now().subtract(const Duration(days: 7))),
  ];

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final total = _transactions.fold<double>(0, (sum, t) => sum + t.amount);
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total donated', style: TextStyle(color: Colors.black54)),
                  Text('4${total.toStringAsFixed(2)}', style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: _refresh,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                itemBuilder: (context, index) {
                  final t = _transactions[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                      child: const Icon(Icons.volunteer_activism, color: Colors.black54),
                    ),
                    title: Text(t.title),
                    subtitle: Text(_formatDate(t.date)),
                    trailing: Text(
                      '+\u00024${t.amount.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemCount: _transactions.length,
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
    setState(() {
      _transactions.insert(0, _Transaction(title: 'New donation', amount: 10.0, date: DateTime.now()));
    });
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }
}

class _Transaction {
  final String title;
  final double amount;
  final DateTime date;
  _Transaction({required this.title, required this.amount, required this.date});
}


