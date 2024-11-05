import 'package:meal_recommendations/core/models/meal.dart';

abstract class MealRepository {
  Future<List<Meal>> fetchMeals();
  void addMealToFavorites(Meal meal);
  void removeFavoriteMeal(Meal meal);
  Stream<List<Meal>> listenToMeals();
  void removeAllMeals();
  void updateIsFavInFireStore(String dishName, bool isFav);
}
