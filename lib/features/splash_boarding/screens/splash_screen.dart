// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meal_recommendations/core/routing/routes.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _checkUserStatus();
    });
  }

void _checkUserStatus() async {
  final box = Hive.box('appBox');
  bool onboardingShown = box.get('onboardingShown', defaultValue: false);
  bool isLoggedIn = box.get('isLoggedIn', defaultValue: false);

  print('Retrieved onboardingShown: $onboardingShown'); 
  print('Retrieved isLoggedIn: $isLoggedIn');

  if (isLoggedIn) {
    Navigator.pushReplacementNamed(context, Routes.layout);
  } else if (onboardingShown) {
    print('Onboarding has been viewed. Navigating to login screen.');
    Navigator.pushReplacementNamed(context, Routes.login);
  } else {
    print('Navigating to onboarding screen.');
    Navigator.pushReplacementNamed(context, Routes.onBoarding);
  }
}


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageSize = screenWidth * 0.35;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: imageSize,
          height: imageSize,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
