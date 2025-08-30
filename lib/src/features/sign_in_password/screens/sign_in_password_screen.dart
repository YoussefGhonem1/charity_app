import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/button.dart';
import '../../../shared/widgets/text_form.dart';

class SignInPasswordScreen extends StatelessWidget {
  SignInPasswordScreen({super.key});

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
              const SizedBox(height: 50),
              Text('Sign in', style: theme.textTheme.headlineLarge),
              const SizedBox(height: 40),
              CustomTextField(
                controller: passController,
                hintText: "Password",
                keyboardType: TextInputType.name,
                obscureText: true,
              ),
              const SizedBox(height: 30),
              ContinueButton(
                onPressed: () {
                  //Navigator.pushReplacementNamed(context, Routes.createAcount);
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text('Forgot Password ?', style: theme.textTheme.labelSmall),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.forgetPassword,
                      );
                    },
                    child: Text('Reset', style: theme.textTheme.labelMedium),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
