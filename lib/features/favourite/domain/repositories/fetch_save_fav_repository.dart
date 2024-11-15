

import 'package:meal_recommendations/core/models/meal.dart';

abstract class FetchAndSaveFavMealsRepository {
  Future<List<Meal>> fetchAndSaveFavMeals();
}
