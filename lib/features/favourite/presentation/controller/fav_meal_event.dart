
import 'package:equatable/equatable.dart';
import 'package:meal_recommendations/core/models/meal.dart';

abstract class FavMealEvent extends Equatable {
   const FavMealEvent();

  @override
  List<Object> get props => [];
}

class FetchAndSaveFavMealsEvent extends FavMealEvent {}
class RemoveFavMealEvent extends FavMealEvent {
  final Meal meal;

  const RemoveFavMealEvent(this.meal);
}