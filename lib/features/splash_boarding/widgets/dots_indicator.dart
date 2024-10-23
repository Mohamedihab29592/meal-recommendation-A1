import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';

class DotsIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const DotsIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 10.h,
          width: 32.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: currentPage == index
                ? AppColors.primaryColor
                : AppColors.inActiveDots,
          ),
        ),
      ),
    );
  }
}
