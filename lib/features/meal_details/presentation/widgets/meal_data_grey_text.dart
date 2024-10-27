import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';

class MealDataGreyText extends StatelessWidget {
  const MealDataGreyText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.font18Medium.copyWith(
        color: AppColors.grey,
      ),
    );
  }
}
