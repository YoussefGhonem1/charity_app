// lib/src/features/auth/bloc/auth_state.dart
part of 'auth_bloc.dart'; // سنقوم بربطه لاحقاً

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// الحالة الأولية عند بدء التطبيق
class AuthInitial extends AuthState {}

// حالة التحميل (عند محاولة تسجيل الدخول/الخروج/إنشاء حساب)
class AuthLoading extends AuthState {}

// حالة نجاح المصادقة (تم تسجيل الدخول)
class Authenticated extends AuthState {
  final User user; // كائن المستخدم من Firebase Auth

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

// حالة عدم المصادقة (لم يتم تسجيل الدخول أو تم تسجيل الخروج)
class Unauthenticated extends AuthState {}

// حالة حدوث خطأ أثناء المصادقة
class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}