// lib/src/features/create_account/screens/create_account.dart
import 'package:charity/src/features/auth/bloc/auth_bloc.dart'; // استيراد البلوك
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // استيراد flutter_bloc
import '../../../shared/widgets/button.dart';

class CreateAccountPage extends StatefulWidget {
  CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sign Up Failed: ${state.message}'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
                print(state.message);
              }
            },
            builder: (context, state) {
              bool isLoading = state is AuthLoading;

              return SingleChildScrollView(
                // لتجنب تجاوز الواجهة عند ظهور الكيبورد
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Create Account",
                      style: theme.textTheme.headlineLarge,
                    ),
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
                      keyboardType: TextInputType.emailAddress, // تحديد النوع
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
                      child: ContinueButton(
                        onPressed: () {
                          if (isLoading) return;
                          // --- إضافة حدث إنشاء حساب ---
                          context.read<AuthBloc>().add(
                            SignUpRequested(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                            ),
                          );
                          // --------------------------
                        },
                      ),
                    ),
                    if (isLoading)
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Have an account?',
                          style: theme.textTheme.labelSmall,
                        ),
                        TextButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  // تعطيل أثناء التحميل
                                  Navigator.pushNamed(
                                    context,
                                    Routes.signInEmail,
                                  );
                                },
                          child: Text(
                            'Sign In',
                            style: theme.textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          // --------------------------------------------------------
        ),
      ),
    );
  }
}
