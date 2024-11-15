
import 'package:equatable/equatable.dart';
import 'package:meal_recommendations/core/models/meal.dart';

abstract class FavMealState extends Equatable {
  const FavMealState();

  @override
  List<Object> get props => [];
}

class FavMealInitial extends FavMealState {}

class FavMealLoading extends FavMealState {}

class FavMealLoaded extends FavMealState {
  final List<Meal> meals;

  const FavMealLoaded(this.meals);

  @override
  List<Object> get props => [meals];
}

class FavMealError extends FavMealState {
  final String message;

  const FavMealError(this.message);

  @override
  List<Object> get props => [message];
}
