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
  static TextStyle get font28BoldDarkBlue => TextStyle(
        fontSize: 28.sp,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get font18Medium => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get font20Regular => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get font20Bold => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get font16Regular => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get font14Regular => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get font14Bold => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get font16Bold => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get font18RegularDarkBlue => TextStyle(
        fontSize: 18.sp,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get font18BoldDarkBlue => TextStyle(
        fontSize: 18.sp,);
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
