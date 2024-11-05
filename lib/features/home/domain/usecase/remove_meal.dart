import 'package:meal_recommendations/core/models/meal.dart';
import '../repo/meal_repo.dart';

class RemoveMeal {
  final MealRepository repository;

  RemoveMeal(this.repository);

  Future<void> call(Meal meal) async {
    return repository.removeFavoriteMeal(meal);
  }
}
