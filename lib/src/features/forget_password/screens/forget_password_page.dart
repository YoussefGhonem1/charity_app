import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:flutter/material.dart';
import '../../../shared/widgets/button.dart';
import '../../../shared/widgets/text_form.dart';

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});

  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 50),
              Text('Forgot Password', style: theme.textTheme.headlineLarge),
              const SizedBox(height: 40),
              CustomTextField(
                controller: passController,
                hintText: "Enter Email Address",
                keyboardType: TextInputType.name,
                obscureText: true,
              ),
              const SizedBox(height: 30),
              ContinueButton(
                onPressed: () {
               Navigator.pushNamed(context, Routes.forgetConfirmation);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
