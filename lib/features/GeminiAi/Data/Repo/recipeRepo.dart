import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/features/GeminiAi/Data/models/ImageModel.dart';

import '../data_sorce/suggested_meal.dart';
import '../models/suggested_meal_model.dart';

class RecipeRepository {
  final RecipeRemoteDatasource remoteDatasource;

  RecipeRepository(this.remoteDatasource);

  Future<Meal> getRecipeSuggestions(String ingredients) async {
    final result = await remoteDatasource.getRecipeSuggestions(ingredients);
    return Meal(
        dishName: result.dishName,
        name: result.name,
        mealType: result.mealType,
        rating: result.rating,
        cookTime: result.cookTime,
        servingSize: result.servingSize,
        summary: result.summary,
        ingredients: result.ingredients,
        mealSteps: result.mealSteps);
  }

  ///Fetch Dish Name Image (Ahmed)
  Future<ImageModel> getDishImage(String dishName) async {
    final result = await remoteDatasource.getDishImage(dishName);
    return result;
  }

  Future<List> getIngredientImg(List<String> ingredients) async {
    final result = await remoteDatasource.getIngredientsImages(ingredients);
    return result;
  }
}
