import 'package:bloc/bloc.dart';
import 'package:meal_recommendations/features/GeminiAi/Data/data_sorce/suggested_meal.dart';
import 'package:meta/meta.dart';

import '../../Data/models/suggested_meal_model.dart';

part 'suggested_recipe_state.dart';

class SuggestedRecipeCubit extends Cubit<SuggestedRecipeState> {
  SuggestedRecipeCubit() : super(SuggestedRecipeInitial());

  Future<void> fetchSuggestedRecipe(String ingredient) async {
    emit(SuggestedRecipeLoading());
    try {
      final recipe =
          await RecipeRemoteDatasource().getRecipeSuggestions(ingredient);
      emit(SuggestedRecipeSuccess(recipe));
    } catch (e) {
      emit(SuggestedRecipeError(errorMessage: e.toString()));
    }
  }
}
