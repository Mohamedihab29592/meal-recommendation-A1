import 'package:meal_recommendations/core/models/meal.dart';
import '../repo/meal_repo.dart';

class RemoveAllMeals {
  final MealRepository repository;

  RemoveAllMeals(this.repository);

  Future<void> call() async {
    return repository.removeAllMeals();
  }
}
