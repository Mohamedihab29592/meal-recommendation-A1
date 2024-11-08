
import 'package:equatable/equatable.dart';
import 'package:meal_recommendations/core/models/meal.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<Meal> favoriteMeals;
  const FavoriteLoaded(this.favoriteMeals);

  @override
  List<Object> get props => [favoriteMeals];
}

class FavoriteError extends FavoriteState {
  final String message;
  const FavoriteError(this.message);

  @override
  List<Object> get props => [message];
}
class FavoriteRemoved extends FavoriteState{}
class FavoriteEmpty extends FavoriteState{}