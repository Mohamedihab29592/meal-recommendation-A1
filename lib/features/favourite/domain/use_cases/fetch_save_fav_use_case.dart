

import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/features/favourite/domain/repositories/fetch_save_fav_repository.dart';

class FetchAndSaveFavMealsUseCase {
  final FetchAndSaveFavMealsRepository mealRepository;

  FetchAndSaveFavMealsUseCase(this.mealRepository);

  Future<List<Meal>> call() async {
    return await mealRepository.fetchAndSaveFavMeals();
  }
}
