import 'package:meal_recommendations/core/models/meal.dart';
import '../repo/meal_repo.dart';

class FetchMeals {
  final MealRepository repository;

  FetchMeals(this.repository);

  Future<List<Meal>> call() async {
    return await repository.fetchMeals();
  }

  Stream<List<Meal>> listenToMeals() {
    return repository.listenToMeals();
  }
}
