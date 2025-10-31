import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final TextEditingController _amountController = TextEditingController(
    text: '0',
  );
  String? _selectedPresetAmount;
  bool _isAnonymous = false;
  final FocusNode _amountFocusNode = FocusNode();

  void _onPresetAmountSelected(String amount) {
    setState(() {
      _selectedPresetAmount = amount;
      _amountController.text = amount;
    });
  }

  @override
  void initState() {
    super.initState();
    _amountFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.shade100,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    const SizedBox(width: 12),
                    Text(
                      'Donate',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text('Enter the Amount', style: TextStyle(fontSize: 22)),
                const SizedBox(height: 10),
                _buildAmountTextField(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: AppColors.bgColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPresetAmountsGrid(),
                _buildAnonymousCheckbox(theme),
                const SizedBox(height: 22),
                ContinueButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.payment);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountTextField() {
    final bool hasFocus = _amountFocusNode.hasFocus;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_amountFocusNode);
      },
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.primaryColor,
            width: hasFocus ? 2.0 : 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '\$',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            IntrinsicWidth(
              child: TextField(
                controller: _amountController,
                focusNode: _amountFocusNode,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                onChanged: (value) {
                  if (_selectedPresetAmount != null) {
                    setState(() {
                      _selectedPresetAmount = null;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresetAmountsGrid() {
    final amounts = ['5', '10', '25', '50', '100', '200'];
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.2,
      ),
      itemCount: amounts.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final amount = amounts[index];
        final isSelected = _selectedPresetAmount == amount;
        return OutlinedButton(
          onPressed: () => _onPresetAmountSelected(amount),
          style: OutlinedButton.styleFrom(
            backgroundColor: isSelected
                ? AppColors.primaryColor.withValues(alpha: 0.1)
                : AppColors.bgColor,
            side: BorderSide(
              color: isSelected
                  ? AppColors.primaryColor
                  : AppColors.greyShade200,
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            '\$$amount',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? AppColors.primaryColor
                  : const Color.fromARGB(255, 65, 22, 22),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnonymousCheckbox(ThemeData theme) {
    return Row(
      children: [
        Checkbox(
          value: _isAnonymous,
          onChanged: (bool? value) {
            setState(() {
              _isAnonymous = value ?? false;
            });
          },
          activeColor: AppColors.primaryColor,
        ),
        Text('Donate as anonymous', style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
