 import 'package:charity/src/features/auth/bloc/auth_bloc.dart';
 import 'package:charity/src/features/layout/screens/layout_screen.dart'; // استيراد LayoutScreen
 import 'package:charity/src/features/sigin_in_email/screens/signin_email.dart'; // استيراد LoginPage
 import 'package:charity/src/features/splash/screens/splash_page.dart'; // استيراد SplashPage
 import 'package:charity/src/shared/routing/app_routs.dart';
 import 'package:charity/src/shared/theme/app_theme.dart';
 import 'package:flutter/material.dart';
 import 'package:firebase_core/firebase_core.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
 import 'firebase_options.dart';

 void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
   runApp(
     BlocProvider(
       create: (context) => AuthBloc()..add(AuthCheckRequested()),
       child: MyApp(),
     ),
   );
 }

 class MyApp extends StatelessWidget {
   const MyApp({super.key});

   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       title: 'Charity App',
       debugShowCheckedModeBanner: false,
       theme: AppTheme.theme,
       onGenerateRoute: AppRoutes.onGenerateRoute,
       home: Builder( // <-- استخدام Builder هنا
         builder: (materialAppContext) { // context داخل MaterialApp
           return BlocListener<AuthBloc, AuthState>( // <-- نقل BlocListener إلى هنا
             listener: (context, state) {
               // الآن context هنا آمن للاستخدام مع Navigator
               final navigator = Navigator.of(context);
               if (state is Authenticated) {
                 final currentRoute = ModalRoute.of(context)?.settings.name;
                 if (currentRoute != Routes.layout) {
                   print("Navigating to Layout due to Authenticated state..."); // للتحقق
                   navigator.pushNamedAndRemoveUntil(Routes.layout, (route) => false);
                 }
               } else if (state is Unauthenticated) {
                 final currentRoute = ModalRoute.of(context)?.settings.name;
                 // تجنب إعادة التوجيه إذا كنا بالفعل في إحدى شاشات المصادقة أو البداية
                 if (currentRoute != Routes.signInEmail &&
                     currentRoute != Routes.signInPassword &&
                     currentRoute != Routes.createAcount &&
                     currentRoute != Routes.forgetPassword &&
                     currentRoute != Routes.onBoarding && // أضف شاشات أخرى لا تريد التوجيه منها
                     currentRoute != Routes.initial)
                      {
                         print("Navigating to SignInEmail due to Unauthenticated state..."); // للتحقق
                         navigator.pushNamedAndRemoveUntil(Routes.signInEmail, (route) => false);
                      }
               }
             },
             child: BlocBuilder<AuthBloc, AuthState>( // <-- BlocBuilder لتحديد الشاشة
               builder: (context, state) {
                 print("Current Auth State in Builder: $state"); // للتحقق من الحالة
                 if (state is AuthInitial) {
                   // عرض شاشة البداية (Splash) أولاً
                   return const SplashPage();
                 }
                  // يمكنك إضافة حالة تحميل هنا إذا أردت
                 // else if (state is AuthLoading && state is! Authenticated && state is! Unauthenticated) {
                 //    return const Scaffold(body: Center(child: CircularProgressIndicator()));
                 // }
                 else if (state is Authenticated) {
                   return const LayoutScreen(); // الشاشة الرئيسية
                 } else { // Unauthenticated أو AuthFailure (بعد Splash)
                   // يمكنك التحقق من state is AuthFailure هنا لعرض رسالة خطأ إذا أردت
                   return const SplashPage(); // شاشة تسجيل الدخول
                 }
               },
             ),
           );
         }
       ),
     );
   }
 }