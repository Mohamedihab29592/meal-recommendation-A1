import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/features/GeminiAi/Presentation/cubit/suggested_recipe_state.dart';
import '../../Domain/UseCase/getRecipeSuggestionUseCase.dart';

class SuggestedRecipeCubit extends Cubit<SuggestedRecipeState> {
  final GetRecipeSuggestionUseCase getRecipeSuggestionUseCase;

  SuggestedRecipeCubit(this.getRecipeSuggestionUseCase) : super(SuggestedRecipeInitial());

  Future<void> fetchSuggestedRecipe(String ingredient) async {
    emit(SuggestedRecipeLoading());
    try {
      final recipe = await getRecipeSuggestionUseCase(ingredient);
      final image=await getRecipeSuggestionUseCase.callGetImage(recipe.name);
      emit(SuggestedRecipeSuccess(recipe,image));
    } catch (e) {
      emit(SuggestedRecipeError(errorMessage: e.toString()));
    }
  }
}
