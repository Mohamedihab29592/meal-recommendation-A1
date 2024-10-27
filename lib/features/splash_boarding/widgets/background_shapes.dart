import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/utils/assets.dart';

class BackgroundShapes extends StatelessWidget {
  const BackgroundShapes({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
          top: screenHeight * 0.31, 
          left: screenWidth * 0.12,
          right: screenWidth * 0.12, 
          bottom: screenHeight * 0.33, 
          child: Container(
            width: screenWidth * 0.76, 
            height: screenHeight * 0.35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.scaffoldBackgroundLightColor,
              border: Border.all(
                color: AppColors.primaryColor,
                width: screenWidth * 0.0026, 
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: Image.asset(
            Assets.rectangleOnboarding,
            width: screenWidth,
            height: screenHeight * 0.56,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
