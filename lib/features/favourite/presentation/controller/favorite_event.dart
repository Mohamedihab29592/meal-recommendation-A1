// favorite_event.dart
import 'package:meal_recommendations/core/models/meal.dart';

abstract class FavoriteEvent {}

class FetchFavorites extends FavoriteEvent {}

class AddFavorite extends FavoriteEvent {
  final Meal meal;
  AddFavorite(this.meal);
}

class RemoveFavorite extends FavoriteEvent {
  final Meal meal;
  RemoveFavorite(this.meal);
}
