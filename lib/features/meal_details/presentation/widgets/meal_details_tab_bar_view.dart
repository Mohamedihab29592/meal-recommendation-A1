import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/features/meal_details/presentation/widgets/direction_tab.dart';
import 'package:meal_recommendations/features/meal_details/presentation/widgets/ingredients_tab.dart';
import 'package:meal_recommendations/features/meal_details/presentation/widgets/summary_tab.dart';

class MealDetailsTabBarView extends StatelessWidget {
  const MealDetailsTabBarView({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        SummaryTab(
          mealSummary: meal.summary!,
        ),
        IngredientsTab(ingredients: meal.ingredients!),
        DirectionTab(steps: meal.mealSteps!),
      ],
    );
  }
}
