import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:flutter/material.dart';
import '../../../shared/widgets/button.dart';
import '../../../shared/widgets/text_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
              ),
              const SizedBox(height: 30),
              ContinueButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: passController.text.trim(),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Password reset email sent!")),
                    );
                    Navigator.pushNamed(context, Routes.forgetConfirmation);
                  } on FirebaseAuthException catch (e) {
                    String message = '';
                    if (e.code == 'user-not-found') {
                      message = 'No user found for this email.';
                    } else if (e.code == 'invalid-email') {
                      message = 'The email is invalid.';
                    } else {
                      message = 'Failed to send email. Try again.';
                    }
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message)));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
