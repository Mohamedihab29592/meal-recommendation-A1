import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';
import 'package:meal_recommendations/core/utils/constant.dart';

class MealDetailsTabBar extends StatelessWidget {
  const MealDetailsTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabAlignment: TabAlignment.fill,
      labelColor: AppColors.primaryColor,
      labelStyle: AppTextStyles.font20Regular,
      unselectedLabelColor: AppColors.grey,
      labelPadding: EdgeInsetsDirectional.only(end: 16.w),
      indicatorColor: AppColors.primaryColor,
      dividerHeight: 0,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderRadius: BorderRadius.circular(17.r),
        borderSide: const BorderSide(
          width: 5.0,
          color: AppColors.primaryColor,
        ),
        insets: EdgeInsets.symmetric(horizontal: 24.0.w),
      ),
      indicatorWeight: 5.h,
      tabs: List.generate(
        AppConstants.mealDetailsTabs.length,
        (index) => Tab(
          text: AppConstants.mealDetailsTabs[index],
        ),
      ),
    );
  }
}
