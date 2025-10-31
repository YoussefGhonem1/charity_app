import 'package:charity/src/features/splash/widgets/animation_letter.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../shared/theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});


  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  final String word = 'Charity';

late final List<Offset> entryOffsets = List.generate(
  word.length,
  (index) => [
    const Offset(-2, 0),
    const Offset(0.0, -2),
    const Offset(0.0, 2),
    const Offset(2, 0),
  ][index % 4],
);

  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _slideAnimations;
  late final List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(word.length, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800),
      );
    });

    _slideAnimations = List.generate(word.length, (index) {
      return Tween<Offset>(
        begin: entryOffsets[index],
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeOutBack,
      ));
    });

    _fadeAnimations = List.generate(word.length, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeIn,
      ));
    });

    startAnimations();
    _checkAuthState(); 
  }

  Future<void> _checkAuthState() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushReplacementNamed(context, Routes.layout);
      } else {
        Navigator.pushReplacementNamed(context, Routes.onBoarding);
      }
    }
  }


  Future<void> startAnimations() async {
    for (var controller in _controllers) {
      await Future.delayed(const Duration(milliseconds: 300));
      controller.forward();
    }
  }

 

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(word.length, (index) {
            return AnimatedLetter(
              char: word[index],
              slideAnimation: _slideAnimations[index],
              fadeAnimation: _fadeAnimations[index],
              raise: word[index] == 'l',
            );
          }),
        ),
      ),
    );
  }
}