import 'package:meal_recommendations/core/models/meal.dart';
import '../repo/meal_repo.dart';

class RemoveMealFromFirestore {
  final MealRepository repository;

  RemoveMealFromFirestore(this.repository);

  Future<void> call(String dishName) async {
    return  repository.removeMealFromFireStore(dishName);
  }

  Stream<List<Meal>> listenToMeals() {
    return repository.listenToMeals();
  }
}
