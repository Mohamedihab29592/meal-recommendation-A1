import 'package:meal_recommendations/core/models/meal.dart';

abstract class SeeAllStates {}

class SeeAllInitialState extends SeeAllStates {}

class SeeAllLoadingState extends SeeAllStates {}

class SeeAllSuccessState extends SeeAllStates {
  List<Meal> meals;
  SeeAllSuccessState({required this.meals});
}

class SeeAllSErrorState extends SeeAllStates {
  final String error;
  SeeAllSErrorState(this.error);
}
