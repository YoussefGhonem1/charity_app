import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:flutter/material.dart';
import '../../../shared/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../shared/widgets/text_form.dart';

class SignInPasswordScreen extends StatelessWidget {
  final String email;
  SignInPasswordScreen({super.key, required this.email});

  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                onPressed: () async {
                  try {
                    final userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                          email: email.trim(),
                          password: passController.text.trim(),
                        );
                    final user = userCredential.user;
                    if (user != null) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.layout,
                        (route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Login Failed User Null')),
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('No User Found')));
                    } else if (e.code == 'wrong-password') {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Wrong Password')));
                    }
                  }
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
