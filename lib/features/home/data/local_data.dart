import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meal_recommendations/core/models/meal.dart';

class LocalData {
  var box = Hive.box('myFavMeals');
  void addMealToFav(Meal meal) {
    box.add(meal);
    debugPrint('Meal added to favorites');
    debugPrint(box.length.toString());
  }

  void removeFavMeal(Meal meal) {
    box.delete(meal);
    debugPrint('Meal deleted successfully');
    debugPrint(box.length.toString());
  }

  void removeAllMeals(Meal meal) {
    box.clear();
    debugPrint('All meals deleted successfully');
    debugPrint(box.length.toString());
  }
}
