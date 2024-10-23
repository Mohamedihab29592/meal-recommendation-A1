import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/utils/assets.dart';

class BackgroundShapes extends StatelessWidget {
  const BackgroundShapes({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 255.h,
          left: 46.w,
          right: 45.w,
          bottom: 273.h,
          child: Container(
            width: 284.w,
            height: 284.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.scaffoldBackgroundLightColor,
              border: Border.all(
                color: AppColors.primaryColor,
                width: 1.w,
              ),
            ),
          ),
        ),
        Positioned(
            top: 0.h,
            child: Image.asset(
              Assets.rectangleOnboarding,
              width: 375.w,
              height: 452.h,
              fit: BoxFit.fill,
            )),
      ],
    );
  }
}
