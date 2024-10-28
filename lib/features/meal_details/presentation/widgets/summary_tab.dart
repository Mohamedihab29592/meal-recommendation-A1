import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';
import 'package:meal_recommendations/core/utils/strings.dart';
import 'package:meal_recommendations/features/meal_details/presentation/widgets/nutration_item.dart';

class SummaryTab extends StatelessWidget {
  const SummaryTab({super.key, required this.mealSummary});

  final MealSummary mealSummary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsetsDirectional.only(end: 19.w),
          child: Text(
            mealSummary.summary,
            style: AppTextStyles.font16Regular
                .copyWith(color: AppColors.primaryColor),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 19.h),
          child: Text(
            AppStrings.nutrition,
            style: AppTextStyles.font20Bold.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
        Wrap(
          spacing: 32.h,
          runSpacing: 19.h,
          alignment: WrapAlignment.start,
          children: List.generate(
            mealSummary.nutrations.length,
            (index) => NutrationItem(nutrition: mealSummary.nutrations[index]),
          ),
        ),
      ],
    );
  }
}
