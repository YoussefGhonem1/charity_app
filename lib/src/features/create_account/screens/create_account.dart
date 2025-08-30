import 'package:charity/src/shared/widgets/text_form.dart';
import 'package:flutter/material.dart';
import '../../../shared/widgets/button.dart';

class CreateAccountPage extends StatefulWidget {
  CreateAccountPage({super.key});
  final TextEditingController passController = TextEditingController();

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              Text("Create Account", style: theme.textTheme.headlineLarge),
              const SizedBox(height: 40),

              CustomTextField(
                hintText: 'First Name',
                controller: firstNameController,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                hintText: 'Last Name',
                controller: lastNameController,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                hintText: 'Email Address',
                controller: emailController,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                hintText: 'Password',
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ContinueButton(onPressed: () {}),
              ),

              const SizedBox(height: 20),
              Row(
                children: [
                  Text('Have an account?', style: theme.textTheme.labelSmall),
                  TextButton(
                    onPressed: () {},
                    child: Text('Sign In', style: theme.textTheme.labelMedium),
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
