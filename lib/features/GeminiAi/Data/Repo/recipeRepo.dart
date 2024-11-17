import '../data_sorce/suggested_meal.dart';
import '../models/suggested_meal_model.dart';

class RecipeRepository {
  final RecipeRemoteDatasource remoteDatasource;

  RecipeRepository(this.remoteDatasource);

  Future<AIMeal> getRecipeSuggestions(String ingredients) async {
    final result = await remoteDatasource.getRecipeSuggestions(ingredients);
    return AIMeal(
        name: result.name,
        mealType: result.mealType,
        rating: result.rating,
        cookTime: result.cookTime,
        servingSize: result.servingSize,
        summary: result.summary,
        ingredients: result.ingredients,
        mealSteps: result.mealSteps);
  }
}
