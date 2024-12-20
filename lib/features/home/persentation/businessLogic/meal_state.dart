part of 'meal_cubit.dart';

@immutable
abstract class MealState {}

class MealInitial extends MealState {}

class MealLoading extends MealState {}

class MealLoaded extends MealState {
  final List<Meal> meals;
  MealLoaded(this.meals);
}

class MealError extends MealState {
  final String error;
  MealError(this.error);
}