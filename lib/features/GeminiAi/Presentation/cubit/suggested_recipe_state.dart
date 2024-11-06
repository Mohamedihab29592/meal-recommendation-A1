part of 'suggested_recipe_cubit.dart';

@immutable
abstract class SuggestedRecipeState {}

class SuggestedRecipeInitial extends SuggestedRecipeState {}

class SuggestedRecipeSuccess extends SuggestedRecipeState {
  final SuggestedRecipe suggestedRecipe;

  SuggestedRecipeSuccess( this.suggestedRecipe);
}

class SuggestedRecipeLoading extends SuggestedRecipeState {}

class SuggestedRecipeError extends SuggestedRecipeState {
  final String errorMessage;
  SuggestedRecipeError({required this.errorMessage});
}
