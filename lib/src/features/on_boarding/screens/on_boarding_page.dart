import 'package:charity/src/features/on_boarding/widgets/on_boarding_page_body.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: OnBoardingPageBody()));
  }
}
