import '../../Data/Repo/recipeRepo.dart';
import '../../Data/models/suggested_meal_model.dart';

class GetRecipeSuggestionUseCase {
  final RecipeRepository recipeRepository;

  GetRecipeSuggestionUseCase(this.recipeRepository);

  Future<SuggestedRecipe> call(String ingredients) {
    return recipeRepository.getRecipeSuggestions(ingredients);
  }
}