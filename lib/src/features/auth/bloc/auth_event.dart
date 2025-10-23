// lib/src/features/auth/bloc/auth_event.dart
part of 'auth_bloc.dart'; // سنقوم بربطه لاحقاً

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// حدث للتحقق من حالة المصادقة الحالية عند بدء التطبيق
class AuthCheckRequested extends AuthEvent {}

// حدث تسجيل الدخول باستخدام البريد الإلكتروني وكلمة المرور
class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// حدث إنشاء حساب جديد باستخدام البريد الإلكتروني وكلمة المرور
class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String firstName; // لنحفظ الاسم الأول
  final String lastName;  // لنحفظ الاسم الأخير

  const SignUpRequested({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object> get props => [email, password, firstName, lastName];
}

// حدث تسجيل الخروج
class SignOutRequested extends AuthEvent {}

// حدث طلب إعادة تعيين كلمة المرور
class PasswordResetRequested extends AuthEvent {
   final String email;
   const PasswordResetRequested({required this.email});
   @override
   List<Object> get props => [email];
}

// يمكنك إضافة أحداث لتسجيل الدخول عبر Google/Facebook/Apple هنا
// class GoogleSignInRequested extends AuthEvent {}
// class FacebookSignInRequested extends AuthEvent {}
// class AppleSignInRequested extends AuthEvent {}