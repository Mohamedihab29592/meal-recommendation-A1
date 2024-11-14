import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';

class CircleGreyDivider extends StatelessWidget {
  const CircleGreyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      width: 6.h,
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: const BoxDecoration(
        color: AppColors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
