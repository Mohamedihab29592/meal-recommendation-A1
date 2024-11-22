import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/features/GeminiAi/Presentation/cubit/suggested_recipe_state.dart';
import '../../Domain/UseCase/getRecipeSuggestionUseCase.dart';

class SuggestedRecipeCubit extends Cubit<SuggestedRecipeState> {
  final GetRecipeSuggestionUseCase getRecipeSuggestionUseCase;

  SuggestedRecipeCubit(this.getRecipeSuggestionUseCase)
      : super(SuggestedRecipeInitial());

  Future<void> fetchSuggestedRecipe(String ingredient) async {
    emit(SuggestedRecipeLoading());
    try {
      final recipe = await getRecipeSuggestionUseCase(ingredient);
      final image = await getRecipeSuggestionUseCase.callGetImage(recipe.name!);
      final ingredientImages = await getRecipeSuggestionUseCase
          .callGetIngredientImages(recipe.ingredients!
              .map((ingredient) => ingredient.name)
              .toList());
      recipe.ingredients!.asMap().forEach((index, ingredient) {
        ingredient.imageUrl = ingredientImages[index];
      });
      recipe.isFavourite = false;
      recipe.imageUrl = image.results![0].image;

      final mealsCollection = FirebaseFirestore.instance.collection('meals');

      final mealData = recipe.toJson();

      await mealsCollection.add(mealData);

      emit(SuggestedRecipeSuccess(recipe, image, ingredientImages));
    } catch (e) {
      emit(SuggestedRecipeError(errorMessage: e.toString()));
    }
  }
}
