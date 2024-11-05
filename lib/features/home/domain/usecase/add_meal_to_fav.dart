import 'package:meal_recommendations/core/models/meal.dart';
import '../repo/meal_repo.dart';

class AddMealToFav {
  final MealRepository repository;

  AddMealToFav(this.repository);

  Future<void> call(Meal meal) async {
    return repository.addMealToFavorites(meal);
  }
}
