import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';

class OnboardingContent extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingContent({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.35), 
          CircleAvatar(
            radius: screenWidth * 0.32,
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: Image.asset(
                image,
                height: screenHeight * 0.3, 
                width: screenWidth * 0.63, 
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: screenWidth * 0.024, 
                left: screenWidth * 0.024, 
                top: screenHeight * 0.045, 
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    style: AppTextStyles.titleOnboarding,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.012),
                  Text(
                    description,
                    style: AppTextStyles.descriptionOnboarding,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

