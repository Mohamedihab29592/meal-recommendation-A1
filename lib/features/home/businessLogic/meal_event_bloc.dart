import 'package:meal_recommendations/core/models/meal.dart';

abstract class MealEvent {}

class FetchMeals extends MealEvent {
  final String userId;
  FetchMeals(this.userId);
}

// class AddMeal extends MealEvent {
//   final String userId;
//   final Meal meal;
//   AddMeal(this.userId, this.meal);
// }

class DeleteMeal extends MealEvent {
  final String userId;
  final String mealId;
  DeleteMeal(this.userId, this.mealId);
}


class AddMeal extends MealEvent {
  final String userId;
  final Map<String, dynamic> meal;

  AddMeal({required this.userId, required this.meal});

  @override
  List<Object?> get props => [userId, meal];
}