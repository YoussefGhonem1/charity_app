import 'package:charity/src/features/create_account/cubits/user_cubit.dart';
import 'package:charity/src/features/create_account/models/users_models.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                child: ContinueButton(
                  onPressed: () async {
                    signUpWithEmail(
                      context: context,
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      firstName: firstNameController.text.trim(),
                      lastName: lastNameController.text.trim(),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
              Row(
                children: [
                  Text('Have an account?', style: theme.textTheme.labelSmall),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.signInEmail);
                    },
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

Future<void> signUpWithEmail({
  required BuildContext context,
  required String email,
  required String password,
  required String firstName,
  required String lastName,
}) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    String uid = userCredential.user!.uid;

    final userData = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
      'donatedAmount': 0.0,
      'wallet': 0.0,
      'avatarUrl': '',
    };

    await FirebaseFirestore.instance.collection('users').doc(uid).set(userData);

    final newUser = UserModel(
      uid: uid,
      firstName: firstName,
      lastName: lastName,
      email: email,
      avatarUrl: '',
      donatedAmount: 0.0,
      wallet: 0.0,
    );

    context.read<UserCubit>().setUser(newUser);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Register Successful ✅")));

    Navigator.pushReplacementNamed(context, Routes.layout);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("The password provided is too weak.")),
      );
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("The account already exists for that email.")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Auth error: $e')));
  }
}
