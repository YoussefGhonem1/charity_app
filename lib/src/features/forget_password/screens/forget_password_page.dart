// lib/src/features/forget_password/screens/forget_password_page.dart
import 'package:charity/src/features/auth/bloc/auth_bloc.dart'; // استيراد البلوك
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // استيراد flutter_bloc
import '../../../shared/widgets/button.dart';
import '../../../shared/widgets/text_form.dart';

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});

  final TextEditingController emailController = TextEditingController(); // تغيير اسم المتحكم

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
                    content: Text('Password Reset Failed: ${state.message}'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
              // يمكنك إضافة حالة مخصصة لنجاح إرسال الإيميل مثل PasswordResetEmailSent
              // والتحقق منها هنا للانتقال إلى شاشة التأكيد
              // مثال: if (state is PasswordResetEmailSent) {
              //   Navigator.pushReplacementNamed(context, Routes.forgetConfirmation);
              // }
            },
            builder: (context, state) {
              bool isLoading = state is AuthLoading;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: isLoading ? null : () { // تعطيل أثناء التحميل
                      // العودة للشاشة السابقة (غالباً شاشة تسجيل الدخول)
                      Navigator.pop(context);
                      // أو إذا كانت هذه أول شاشة، يمكن استخدام:
                      // Navigator.pushReplacementNamed(context, Routes.signInEmail);
                    },
                  ),
                  const SizedBox(height: 50),
                  Text('Forgot Password', style: theme.textTheme.headlineLarge),
                  const SizedBox(height: 40),
                  CustomTextField(
                    controller: emailController, // استخدام المتحكم الصحيح
                    hintText: "Enter Email Address",
                    keyboardType: TextInputType.emailAddress, // تغيير النوع
                    obscureText: false, // لا حاجة لإخفاء الإيميل
                  ),
                  const SizedBox(height: 30),
                  ContinueButton(
                    onPressed: () {
                        if (isLoading) return;
                      // --- إضافة حدث طلب إعادة تعيين كلمة المرور ---
                      context.read<AuthBloc>().add(PasswordResetRequested(
                           email: emailController.text.trim(),
                         ));
                      // ----------------------------------------
                      // **مؤقتاً**: الانتقال المباشر لشاشة التأكيد.
                      // يجب إزالة هذا السطر عند إضافة الحالة المخصصة في listener
                       Navigator.pushReplacementNamed(
                         context,
                         Routes.forgetConfirmation,
                       );
                    },
                  ),
                   if (isLoading)
                     const Padding(
                       padding: EdgeInsets.only(top: 16.0),
                       child: Center(child: CircularProgressIndicator()),
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