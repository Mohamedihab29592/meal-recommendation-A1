
import 'package:meal_recommendations/features/favourite/data/models/meal.dart';

abstract class MealEvent {}

class LoadFavoritesEvent extends MealEvent {}

class AddFavoriteEvent extends MealEvent {
  final FavMealModel meal;
  final String userId;

  AddFavoriteEvent({required this.meal, required this.userId});
}

class RemoveFavoriteEvent extends MealEvent {
  final int id;
  final String userId;

  RemoveFavoriteEvent({required this.id, required this.userId});
}
