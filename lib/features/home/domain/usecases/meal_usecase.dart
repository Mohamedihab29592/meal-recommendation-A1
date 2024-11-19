import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/features/home/domain/add_meal_repository.dart';


class MealUseCase {
  final AddMealRepository mealRepository;

  MealUseCase(this.mealRepository);

  Future<List<Meal>> fetchUserMeals(String userId) async {
    return await mealRepository.getMeals(userId);
  }

  Future<void> addMeal(String userId, Meal meal) async {
    await mealRepository.addMeal(userId, meal);
  }

  Future<void> deleteMeal(String userId, String mealId) async {
    await mealRepository.deleteMeal(userId, mealId);
  }
}
