
import 'package:equatable/equatable.dart';

abstract class FavMealEvent extends Equatable {
   const FavMealEvent();

  @override
  List<Object> get props => [];
}

class FetchAndSaveFavMealsEvent extends FavMealEvent {}
