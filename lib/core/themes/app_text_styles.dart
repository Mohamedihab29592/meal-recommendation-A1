import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get font21BoldDarkBlue => TextStyle(
        fontSize: 21.sp,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get font18RegularDarkBlue => TextStyle(
        fontSize: 18.sp,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w400,
      );
        static TextStyle get titleOnboarding => TextStyle(
        fontSize: 17.sp,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get descriptionOnboarding => TextStyle(
        fontSize: 13.sp,
        color: AppColors.primaryColor,
      );
  static TextStyle get textOnboarding => TextStyle(
        fontSize: 14.sp,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
      );
}
