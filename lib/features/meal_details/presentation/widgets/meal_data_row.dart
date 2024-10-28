import 'package:flutter/material.dart';
import 'package:meal_recommendations/features/meal_details/presentation/widgets/circle_grey_divider.dart';
import 'package:meal_recommendations/features/meal_details/presentation/widgets/meal_data_grey_text.dart';

class MealDataRow extends StatelessWidget {
  const MealDataRow({
    super.key,
    required this.mealDishName,
    required this.mealCookTime,
    required this.mealServingSize,
  });

  final String mealDishName;
  final int mealCookTime, mealServingSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MealDataGreyText(text: mealDishName),
        const CircleGreyDivider(),
        MealDataGreyText(text: '$mealCookTime min'),
        const CircleGreyDivider(),
        MealDataGreyText(text: '$mealServingSize serving'),
      ],
    );
  }
}
