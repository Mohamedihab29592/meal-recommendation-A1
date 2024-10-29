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

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, Routes.layout);
    } else if (onboardingShown) {
      Navigator.pushReplacementNamed(context, Routes.login);
    } else {
      Navigator.pushReplacementNamed(context, Routes.onBoarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageSize = screenWidth * 0.4;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset(
          'assets/images/splash_icon.png',
          width: imageSize,
          height: imageSize,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
