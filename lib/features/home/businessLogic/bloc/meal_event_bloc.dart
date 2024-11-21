import 'package:meal_recommendations/core/models/meal.dart';

abstract class MealEvent {}

class FetchMeals extends MealEvent {
  final String userId;
  FetchMeals(this.userId);
}

class AddMeal extends MealEvent {
  final String userId;
  final Meal meal;

  AddMeal({required this.userId, required this.meal});

  List<Object?> get props => [userId, meal];
}

class DeleteMeal extends MealEvent {
  final String userId;
  final String mealId;

  DeleteMeal(this.userId, this.mealId);
}

class UpdateIsFav extends MealEvent {
  final String userId;
  final String mealId;
  final bool isFav;
  final String dishName;
  UpdateIsFav(this.dishName,
      {required this.userId, required this.mealId, required this.isFav});
}

class RemoveFavMeal extends MealEvent {
  final Meal meal;
  final String userId;
  RemoveFavMeal(this.meal, this.userId);
}
