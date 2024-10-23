import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 280.h),
          CircleAvatar(
            radius: 119.r,
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: Image.asset(image,
                  height: 238.h, width: 238.w, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 9.w, left: 9.w, top: 35.h),
              child: Column(
                children: [
                  Text(
                    title,
                    style: AppTextStyles.titleOnboarding,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
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
