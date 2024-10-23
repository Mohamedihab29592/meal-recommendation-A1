import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/utils/assets.dart';
import 'package:meal_recommendations/features/splash_boarding/widgets/action_buttons.dart';
import 'package:meal_recommendations/features/splash_boarding/widgets/background_shapes.dart';
import 'package:meal_recommendations/features/splash_boarding/widgets/dots_indicator.dart';
import 'package:meal_recommendations/features/splash_boarding/widgets/on_boarding_data.dart';
import 'package:meal_recommendations/features/splash_boarding/widgets/skip_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _skipToLastPage() {
    _pageController.jumpToPage(onboardingScreens.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundLightColor,
      body: Stack(
        children: [
          const BackgroundShapes(),
          Positioned(
            top: 80.h,
            left: 138.w,
            child: Image.asset(
              Assets.imagesSplash,
              height: 98.h,
              width: 98.w,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingScreens.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return onboardingScreens[index];
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.h, right: 33.w, left: 33.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 53.w,
                      child: _currentPage != onboardingScreens.length - 1
                          ? SkipButton(onPressed: _skipToLastPage)
                          : const SizedBox.shrink(),
                    ),
                    DotsIndicator(
                      currentPage: _currentPage,
                      totalPages: onboardingScreens.length,
                    ),
                    ActionButtons(
                      currentPage: _currentPage,
                      totalPages: onboardingScreens.length,
                      onNext: _goToNextPage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
