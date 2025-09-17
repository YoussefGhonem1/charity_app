import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedPaymentMethod = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor.shade100,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Payment',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              decoration: const BoxDecoration(color: AppColors.bgColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Payment Method',
                    style: theme.textTheme.headlineSmall,
                  ),
                  SizedBox(height: 16),
                  _buildPaymentOption(
                    context: context,
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'My Wallet (\$400)',
                    value: 0,
                  ),
                  _buildPaymentOption(
                    context: context,
                    icon: Icons.paypal,
                    title: 'Paypal',
                    value: 1,
                  ),
                  _buildPaymentOption(
                    context: context,
                    icon: Icons.g_mobiledata,
                    title: 'Google Pay',
                    value: 2,
                  ),
                  _buildPaymentOption(
                    context: context,
                    icon: Icons.apple,
                    title: 'Apple Pay',
                    value: 3,
                  ),
                  const SizedBox(height: 16),
                  _buildAddNewCardButton(),
                  const SizedBox(height: 26),
                  ContinueButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.enterPin);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required int value,
  }) {
    final bool isSelected = _selectedPaymentMethod == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.greyShade200,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.blackColor, size: 26),
            const SizedBox(width: 16),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Radio<int>(
              value: value,
              groupValue: _selectedPaymentMethod,
              onChanged: (int? newValue) {
                setState(() {
                  _selectedPaymentMethod = newValue!;
                });
              },
              activeColor: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewCardButton() {
    return OutlinedButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.addCard);
      },
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 60),
        side: const BorderSide(color: AppColors.greyShade200, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.add, color: AppColors.primaryColor, size: 24),
          const SizedBox(width: 12),
          Text(
            'Add New Card',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }
}
