// lib/src/features/auth/bloc/auth_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // استيراد Firestore

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore; // إضافة متغير Firestore
  StreamSubscription<User?>? _userSubscription;

  AuthBloc({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore, // إضافة Firestore للكونستركتور (اختياري للحقن)
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance, // تهيئة Firestore
        super(AuthInitial()) {

    // الاستماع لتغيرات حالة المستخدم في Firebase Auth
    _userSubscription = _firebaseAuth.authStateChanges().listen((user) {
      // لا نضيف الحدث هنا مباشرة لمنع الحلقات اللانهائية المحتملة
      // سيتم التحقق من الحالة عند استدعاء الأحداث الأخرى أو عند بدء التشغيل
      // إذا كان المستخدم null (تسجيل خروج)، نصدر حالة Unauthenticated
      if (user == null) {
         if (state is! Unauthenticated && state is! AuthInitial) { // تجنب إصدار الحالة بشكل متكرر
           emit(Unauthenticated());
         }
      } else {
         if (state is! Authenticated) { // تجنب إصدار الحالة بشكل متكرر
             emit(Authenticated(user));
         }
      }
    });

    // --- تسجيل معالجات الأحداث ---
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<PasswordResetRequested>(_onPasswordResetRequested);
    // ----------------------------
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  // --- معالجات الأحداث ---

  // <<-- دالة معالجة AuthCheckRequested
  Future<void> _onAuthCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) async {
     // emit(AuthLoading()); // يمكن إضافتها إذا أردت إظهار تحميل بسيط
     // تأكد من الحالة الحالية للمستخدم
     final user = _firebaseAuth.currentUser;
     if (user != null) {
        // تأكد من أن الحالة الحالية ليست Authenticated بالفعل لتجنب إعادة الإصدار غير الضروري
       if (state is! Authenticated) {
          emit(Authenticated(user));
       }
     } else {
        // تأكد من أن الحالة الحالية ليست Unauthenticated بالفعل
       if (state is! Unauthenticated && state is! AuthInitial) {
         emit(Unauthenticated());
       } else if (state is AuthInitial) {
         // إذا كانت الحالة الأولية، انتقل إلى Unauthenticated
         emit(Unauthenticated());
       }
     }
  }

  // <<-- دالة معالجة SignInRequested
  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    // تحقق أولاً إذا كان المستخدم مسجلاً بالفعل لتجنب إعادة المحاولة غير الضرورية
    if (state is Authenticated) return;
    emit(AuthLoading());
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      // لا نصدر Authenticated هنا، لأن مستمع authStateChanges سيتولى ذلك
      // فقط تأكد من عدم وجود خطأ وإزالة حالة التحميل (سيتم استبدالها بـ Authenticated)
      if (userCredential.user == null) {
          emit(Unauthenticated()); // إذا لم يتم إرجاع مستخدم لسبب ما
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'Sign in failed'));
      emit(Unauthenticated()); // العودة لحالة عدم المصادقة بعد الفشل
    } catch (e) {
       emit(AuthFailure('An unknown error occurred: ${e.toString()}'));
       emit(Unauthenticated()); // العودة لحالة عدم المصادقة بعد الفشل
    }
  }

  // <<-- دالة معالجة SignUpRequested (موجودة ومعدلة سابقاً)
  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    if (state is Authenticated) return; // لا تقم بالتسجيل إذا كان مسجلاً بالفعل
    emit(AuthLoading());
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (userCredential.user != null) {
        // --- إضافة المستخدم إلى Firestore ---
        await _saveUserDataToFirestore(
          user: userCredential.user!,
          firstName: event.firstName,
          lastName: event.lastName,
        );
        // ------------------------------------
         // لا نصدر Authenticated هنا، لأن مستمع authStateChanges سيتولى ذلك
      } else {
        emit(Unauthenticated());
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'Sign up failed'));
      emit(Unauthenticated()); // العودة لحالة عدم المصادقة بعد الفشل
    } catch (e) {
      emit(AuthFailure('An unknown error occurred: ${e.toString()}'));
      emit(Unauthenticated()); // العودة لحالة عدم المصادقة بعد الفشل
    }
  }

  // <<-- دالة معالجة SignOutRequested
   Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    // تحقق إذا كان المستخدم مسجلاً للخروج بالفعل
    if (state is Unauthenticated) return;
    // لا تصدر AuthLoading هنا بالضرورة إلا إذا كانت العملية قد تستغرق وقتاً ملحوظاً
    // emit(AuthLoading());
    try {
      await _firebaseAuth.signOut();
       // لا نصدر Unauthenticated هنا، لأن مستمع authStateChanges سيتولى ذلك
    } catch (e) {
      emit(AuthFailure('Sign out failed: ${e.toString()}'));
      // حتى لو فشل تسجيل الخروج، تحقق من الحالة الحالية وأصدرها
       final user = _firebaseAuth.currentUser;
       if (user != null) {
          emit(Authenticated(user)); // إذا ما زال مسجل الدخول لسبب ما
       } else {
          emit(Unauthenticated());
       }
    }
  }

  // <<-- دالة معالجة PasswordResetRequested
   Future<void> _onPasswordResetRequested(
      PasswordResetRequested event, Emitter<AuthState> emit) async {
    // يمكن تنفيذ هذا الإجراء حتى لو كان المستخدم مسجلاً دخوله
    emit(AuthLoading()); // إظهار التحميل لأن العملية تتصل بالشبكة
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: event.email);
      // لا نغير حالة المصادقة هنا، نصدر حالة Unauthenticated (أو الحالة السابقة) بعد التحميل
      // يمكنك إصدار حالة خاصة للنجاح إذا أردت عرض رسالة مختلفة في الواجهة
      // emit(PasswordResetEmailSent());
      final currentState = state; // احتفظ بالحالة الحالية (قبل التحميل)
      if (currentState is Authenticated) {
          emit(Authenticated(currentState.user)); // ارجع للحالة المصادقة
      } else {
          emit(Unauthenticated()); // ارجع لحالة عدم المصادقة
      }
      // يمكنك أيضاً إصدار حدث أو استخدام bloc listener لإظهار رسالة نجاح للمستخدم
    } on FirebaseAuthException catch (e) {
       emit(AuthFailure(e.message ?? 'Password reset failed'));
        // العودة للحالة التي كانت عليها قبل بدء التحميل
       final user = _firebaseAuth.currentUser;
       if (user != null && state is! Authenticated) {
          emit(Authenticated(user));
       } else if (user == null && state is! Unauthenticated) {
          emit(Unauthenticated());
       }
    } catch (e) {
       emit(AuthFailure('An unknown error occurred: ${e.toString()}'));
        // العودة للحالة التي كانت عليها قبل بدء التحميل
        final user = _firebaseAuth.currentUser;
       if (user != null && state is! Authenticated) {
          emit(Authenticated(user));
       } else if (user == null && state is! Unauthenticated) {
          emit(Unauthenticated());
       }
    }
  }

  // --- دالة مساعدة لحفظ بيانات المستخدم (موجودة سابقاً) ---
  Future<void> _saveUserDataToFirestore({
    required User user,
    required String firstName,
    required String lastName,
  }) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'firstName': firstName,
        'lastName': lastName,
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
        'profileImageUrl': null,
        'totalDonated': 0.0,
        'favoriteCampaignIds': [],
      });
    } catch (e) {
      print("Error saving user data to Firestore: $e");
    }
  }
}