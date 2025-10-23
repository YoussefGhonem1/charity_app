// lib/src/features/sign_in_password/screens/sign_in_password_screen.dart
import 'package:charity/src/features/auth/bloc/auth_bloc.dart'; // استيراد البلوك
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // استيراد flutter_bloc
import '../../../shared/widgets/button.dart';
import '../../../shared/widgets/text_form.dart';

class SignInPasswordScreen extends StatelessWidget {
  // --- استقبل البريد الإلكتروني من الشاشة السابقة ---
  final String email;

  SignInPasswordScreen({required this.email, super.key});
  // ------------------------------------------------

  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          // --- استخدم BlocConsumer للاستماع للحالات وعرض الواجهة ---
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Login Failed: ${state.message}'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
              // لا نحتاج لمعالجة Authenticated هنا، لأن BlocListener في MyApp سيتولى التوجيه
            },
            builder: (context, state) {
              bool isLoading = state is AuthLoading; // التحقق إذا كانت الحالة "تحميل"

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text('Sign in', style: theme.textTheme.headlineLarge),
                  const SizedBox(height: 40),
                  CustomTextField(
                    controller: passController,
                    hintText: "Password",
                    keyboardType: TextInputType.visiblePassword, // تغيير النوع
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  ContinueButton(
                    onPressed: () {
                      if (isLoading) return; // تعطيل الزر أثناء التحميل
                      // --- إضافة حدث تسجيل الدخول ---
                      context.read<AuthBloc>().add(SignInRequested(
                        email: email, // استخدم البريد الإلكتروني المستقبل
                        password: passController.text.trim(),
                      ));
                      // -----------------------------
                      // Navigator.pushReplacementNamed(context, Routes.layout); // إزالة الانتقال اليدوي
                    },
                  ),
                   if (isLoading) // إظهار مؤشر التحميل
                     const Padding(
                       padding: EdgeInsets.only(top: 16.0),
                       child: Center(child: CircularProgressIndicator()),
                     ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Forgot Password ?', style: theme.textTheme.labelSmall),
                      TextButton(
                        onPressed: isLoading ? null : () { // تعطيل أثناء التحميل
                          Navigator.pushNamed( // استخدام pushNamed أفضل هنا
                            context,
                            Routes.forgetPassword,
                          );
                        },
                        child: Text('Reset', style: theme.textTheme.labelMedium),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          // --------------------------------------------------------
        ),
      ),
    );
  }
}

// **ملاحظة:** ستحتاج لتعديل كيفية الانتقال من `signin_email.dart` إلى `sign_in_password_screen.dart`
// لكي تمرر البريد الإلكتروني. مثال:
// في signin_email.dart عند الضغط على Continue:
/*
Navigator.pushNamed(
  context,
  Routes.signInPassword,
  arguments: emailController.text.trim(), // تمرير البريد كـ argument
);
*/
// في app_routs.dart، استقبل الـ argument:
/*
case Routes.signInPassword:
  final email = settings.arguments as String?; // استقبل البريد
  if (email != null) {
    return MaterialPageRoute(builder: (_) => SignInPasswordScreen(email: email));
  }
  // يمكنك إضافة معالجة خطأ هنا إذا لم يتم تمرير البريد
  return MaterialPageRoute(builder: (_) => const LoginPage()); // العودة لتسجيل الدخول
*/