import 'package:flutter/material.dart';
import 'package:meal_recommendations/features/home/persentation/widgets/build_meal_card.dart';
import '../cubit/suggested_recipe_state.dart';

class RecipeDetails extends StatelessWidget {
  final SuggestedRecipeSuccess state;

  const RecipeDetails({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [BuildMealCard(meal: state.suggestedRecipe)]);
  }
}
