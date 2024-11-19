import 'package:meal_recommendations/core/models/meal.dart';

abstract class AddMealRepository {
  Future<List<Meal>> getMeals(String userId);
  Future<void> addMeal(String userId, Meal meal);
  Future<void> deleteMeal(String userId, String mealId);
}
