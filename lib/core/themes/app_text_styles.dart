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
}
