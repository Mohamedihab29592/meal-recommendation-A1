import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';

class NutrationItem extends StatelessWidget {
  const NutrationItem({
    super.key,
    required this.nutrition,
  });

  final MealNutrition nutrition;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(23.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primaryColor,
          width: 5.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${nutrition.quantityInGrams} g',
            style: AppTextStyles.font14Bold.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          Text(
            nutrition.nutrientName,
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
