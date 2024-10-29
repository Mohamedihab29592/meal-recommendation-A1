// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meal_recommendations/core/routing/routes.dart';
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
void finishOnboarding() async {
  final box = Hive.box('appBox');

  print('Saving onboarding status...'); 
  await box.put('onboardingShown', true); 
  print('Onboarding status saved.'); 

  bool onboardingCheck = box.get('onboardingShown'); 
  print('Onboarding status after saving: $onboardingCheck');

  if (onboardingCheck) {
    Navigator.pushReplacementNamed(context, Routes.login); 
  } else {
    print('Failed to save onboarding state.'); 
  }
}

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
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.38,
            child: Image.asset(
              Assets.imagesSplash,
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.25,
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
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.08,
                  left: MediaQuery.of(context).size.width * 0.08,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
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
