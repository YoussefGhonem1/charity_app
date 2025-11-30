import 'package:charity/src/features/create_account/cubits/user_cubit.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../shared/widgets/text_form.dart';
import 'package:charity/src/features/create_account/models/users_models.dart';

class SignInPasswordScreen extends StatelessWidget {
  final String email;
  SignInPasswordScreen({Key? key, required this.email}) : super(key: key);

  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.iconTheme.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
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
                      final doc = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .get();

                      if (doc.exists) {
                        final userModel = UserModel.fromMap({
                          'uid': user.uid,
                          ...doc.data()!,
                        });

                        if (!context.mounted) return;
                        context.read<UserCubit>().setUser(userModel);
                      }

                      // 🟢 الانتقال إلى الصفحة الرئيسية
                      if (!context.mounted) return;
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.layout,
                        (route) => false,
                      );
                    } else {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Login Failed: User Null')),
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    if (!context.mounted) return;
                    if (e.code == 'user-not-found') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('No user found for that email.')),
                      );
                    } else if (e.code == 'wrong-password') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Wrong password.')),
                      );
                    }
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
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
