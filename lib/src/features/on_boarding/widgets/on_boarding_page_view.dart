import 'package:charity/generated/assets.gen.dart';
import 'package:charity/src/features/on_boarding/widgets/page_view_item.dart';
import 'package:flutter/material.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({
    super.key,
    required this.pageController,
    required this.currentPage,
  });
  final PageController pageController;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        PageViewItem(
          image: Assets.imagesImagePageItem1.path,
          backgroundImage: Assets.imagesBackgroudPageView1.path,
          subtitle: 'Donate easily and make a change',
          title: 'Welcome to Charity App',
          isVisible: true,
          currentPage: currentPage,
        ),

        PageViewItem(
          image: Assets.imagesImagePageItem2.path,
          backgroundImage: Assets.imagesBackgroudPageView2.path,
          subtitle: 'Track your donations anytime',
          title: 'Your Impact Matters',
          isVisible: true,
          currentPage: currentPage,
        ),

        PageViewItem(
          image: Assets.imagesImagePageItem3.path,
          backgroundImage: Assets.imagesBackgroudPageView3.path,
          subtitle: 'Join our community of givers',
          title: 'Start Giving Today',
          isVisible: false,
          currentPage: currentPage,
        ),
      ],
    );
  }
}
