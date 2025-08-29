import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PasswordInputBox extends StatelessWidget {
  final TextEditingController controller;
  const PasswordInputBox({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.greyShade200,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Password',
            hintStyle: TextStyle(
              color: AppColors.greyColor,
              fontSize: 18,
            ),
          ),
          obscureText: true,
        ),
      ),
    );
  }
}
