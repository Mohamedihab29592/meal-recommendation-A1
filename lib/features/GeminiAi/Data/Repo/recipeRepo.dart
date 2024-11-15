import '../data_sorce/suggested_meal.dart';
import '../models/suggested_meal_model.dart';

class RecipeRepository {
  final RecipeRemoteDatasource remoteDatasource;

  RecipeRepository(this.remoteDatasource);

  Future<SuggestedRecipe> getRecipeSuggestions(String ingredients) async {
    final result = await remoteDatasource.getRecipeSuggestions(ingredients);
    return SuggestedRecipe(
      mealName: result.mealName,
      description: result.description,
      ingredients: result.ingredients,
      instructions: result.instructions,
      nutritionalInformation: result.nutritionalInformation,
    );
  }
}
