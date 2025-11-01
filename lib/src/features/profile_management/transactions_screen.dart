import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:charity/src/shared/localization/app_translations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/transactions_cubit.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen();

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    final t = AppTranslations.of(context);
    final state = context.watch<TransactionsCubit>().state;
    final items = state.items;
    final total = items.fold<double>(0, (sum, tr) => sum + tr.amount);
    return Scaffold(
      appBar: AppBar(title: Text(t.transactions)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.lightGreyColor(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.greyShade(context)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t.totalDonated,
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: () => context.read<TransactionsCubit>().fetch(),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                itemBuilder: (context, index) {
                  if (state.loading && items.isEmpty) {
                    return ListTile(title: Text(t.loading));
                  }
                  final transaction = items[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
                      child: Icon(
                        Icons.volunteer_activism,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white70
                            : Colors.black54,
                      ),
                    ),
                    title: Text(
                      transaction.title,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    subtitle: Text(_formatDate(transaction.date)),
                    trailing: Text(
                      '+\$${transaction.amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemCount: items.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }
}
