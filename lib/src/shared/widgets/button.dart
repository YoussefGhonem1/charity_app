import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const ContinueButton({
    super.key,
    required this.onPressed,
    this.text = 'Continue',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 49,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: AppColors.bgColor),
        ),
      ),
    );
  }
}
