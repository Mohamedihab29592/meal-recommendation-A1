import 'package:meal_recommendations/features/favourite/data/models/meal.dart';


abstract class MealState {}

class MealInitial extends MealState {}

class MealLoading extends MealState {}

class MealLoaded extends MealState {
  final List<FavMealModel> favorites;

  MealLoaded({required this.favorites});
}

class MealError extends MealState {
  final String message;

  MealError({required this.message});
}
