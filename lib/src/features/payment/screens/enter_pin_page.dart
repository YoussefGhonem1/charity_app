import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';

class EnterPinPage extends StatefulWidget {
  const EnterPinPage({super.key});

  @override
  State<EnterPinPage> createState() => _EnterPinPageState();
}

class _EnterPinPageState extends State<EnterPinPage> {
  String _pin = '';

  void _onKeyPressed(String value) {
    setState(() {
      if (value == 'backspace') {
        if (_pin.isNotEmpty) {
          _pin = _pin.substring(0, _pin.length - 1);
        }
      } else if (_pin.length < 5) {
        _pin += value;
      }
    });
  }

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
                      'Enter PIN',
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
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Please Enter your PIN',
                        style: theme.textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 32),
                      _buildPinDots(),
                      const SizedBox(height: 48),
                      ContinueButton(
                        text: 'Confirm',
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.success);
                        },
                      ),
                    ],
                  ),
                  _buildKeypad(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPinDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 50,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: index < _pin.length
                  ? AppColors.primaryColor
                  : AppColors.greyShade200,
              width: 1.5,
            ),
          ),
          child: Center(
            child: index < _pin.length
                ? Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  )
                : null,
          ),
        );
      }),
    );
  }

  Widget _buildKeypad() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildKeypadButton('1'),
            _buildKeypadButton('2', 'ABC'),
            _buildKeypadButton('3', 'DEF'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildKeypadButton('4', 'GHI'),
            _buildKeypadButton('5', 'JKL'),
            _buildKeypadButton('6', 'MNO'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildKeypadButton('7', 'PQRS'),
            _buildKeypadButton('8', 'TUV'),
            _buildKeypadButton('9', 'WXYZ'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 80),
            _buildKeypadButton('0'),
            _buildKeypadButton('backspace'),
          ],
        ),
      ],
    );
  }

  Widget _buildKeypadButton(String value, [String? letters]) {
    return SizedBox(
      width: 80,
      height: 60,
      child: Material(
        color: AppColors.primaryColor.shade100,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _onKeyPressed(value),
          child: Center(
            child: value == 'backspace'
                ? const Icon(
                    Icons.backspace_outlined,
                    color: AppColors.blackColor,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (letters != null)
                        Text(
                          letters,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
