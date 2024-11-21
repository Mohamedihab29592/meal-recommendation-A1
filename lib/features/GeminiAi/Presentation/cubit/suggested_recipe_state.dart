import 'package:meal_recommendations/features/GeminiAi/Data/models/ImageModel.dart';

import '../../Data/models/suggested_meal_model.dart';

abstract class SuggestedRecipeState {}

class SuggestedRecipeInitial extends SuggestedRecipeState {}

class SuggestedRecipeSuccess extends SuggestedRecipeState {
  final AIMeal suggestedRecipe;
final ImageModel dishImage;
  SuggestedRecipeSuccess(this.suggestedRecipe,this.dishImage);
}

class SuggestedRecipeLoading extends SuggestedRecipeState {}

class SuggestedRecipeError extends SuggestedRecipeState {
  final String errorMessage;

  SuggestedRecipeError({required this.errorMessage});
}
