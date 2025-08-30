import 'package:charity/src/features/on_boarding/widgets/custom_button_onboarding.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.image,
    required this.backgroundImage,
    required this.subtitle,
    required this.title,
    required this.isVisible,
    required this.currentPage,
  });

  final String image, backgroundImage, subtitle, title;
  final bool isVisible;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: isVisible,
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              child: GestureDetector(
                onTap: () {
                    Navigator.pushReplacementNamed(context, Routes.signInPassword);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.03,
                    horizontal: size.width * 0.06,
                  ),
                  child: Text(
                    'Skip',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: size.width * 0.8,
          height: size.height * 0.3,
          child: SvgPicture.asset(image),
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: size.height * 0.51,
                  child: SizedBox(
                    width: double.infinity,
                    height: size.height * 0.51,
                    child: SvgPicture.asset(backgroundImage, fit: BoxFit.fill),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.13),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.05),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: AppColors.bgColor),
                      ),
                      SizedBox(height: size.height * 0.015),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.bgColor,
                        ),
                      ),
                      SizedBox(height: 20),
                      DotsIndicator(
                        dotsCount: 3,
                        position: currentPage.toDouble(),
                        decorator: DotsDecorator(
                          color: AppColors.bgColor.withAlpha(
                            (0.5 * 255).toInt(),
                          ),
                          activeColor: AppColors.bgColor,
                          size: Size(10.0, 10.0),
                          activeSize: Size(22.0, 10.0),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 23),
                      Visibility(
                        visible: currentPage == 2 ? true : false,
                        maintainState: true,
                        maintainAnimation: true,
                        maintainSize: true,
                        child: CustomButtonOnboarding(
                          onPressed: () {
                              Navigator.pushReplacementNamed(context, Routes.signInPassword);
                          },
                          label: 'Get Started',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
