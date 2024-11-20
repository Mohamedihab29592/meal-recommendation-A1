import 'package:meal_recommendations/features/GeminiAi/Data/models/ImageModel.dart';

import '../../Data/Repo/recipeRepo.dart';
import '../../Data/models/suggested_meal_model.dart';

class GetRecipeSuggestionUseCase {
  final RecipeRepository recipeRepository;

  GetRecipeSuggestionUseCase(this.recipeRepository);

  Future<AIMeal> call(String ingredients) {
    return recipeRepository.getRecipeSuggestions(ingredients);
  }


  Future<ImageModel> callGetImage(String dishName) {
    return recipeRepository.getDishImage(dishName);
  }
}
