import 'package:meal_recommendations/features/GeminiAi/Data/models/ImageModel.dart';

import '../../../../core/models/meal.dart';
import '../../Data/models/suggested_meal_model.dart';

abstract class SuggestedRecipeState {}

class SuggestedRecipeInitial extends SuggestedRecipeState {}

class SuggestedRecipeSuccess extends SuggestedRecipeState {
  final Meal suggestedRecipe;
final ImageModel dishImage;
  final List ingredientImages;

  SuggestedRecipeSuccess(this.suggestedRecipe,this.dishImage, this.ingredientImages);
}

class SuggestedRecipeLoading extends SuggestedRecipeState {}

class SuggestedRecipeError extends SuggestedRecipeState {
  final String errorMessage;

  SuggestedRecipeError({required this.errorMessage});
}
