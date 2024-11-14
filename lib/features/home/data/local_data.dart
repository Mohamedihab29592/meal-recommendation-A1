import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meal_recommendations/core/models/meal.dart';

class LocalData {


  void addMealToFav(Meal meal)async {
    var box = Hive.isBoxOpen('myFavMeals')
        ? Hive.box<Meal>('myFavMeals')
        : await Hive.openBox<Meal>('myFavMeals');
    box.put(meal.dishName , meal);
    debugPrint('Meal added to favorites');
    debugPrint(box.length.toString());
  }

  void removeFavMeal(Meal meal) async {
    var box = Hive.isBoxOpen('myFavMeals')
        ? Hive.box<Meal>('myFavMeals')
        : await Hive.openBox<Meal>('myFavMeals');
    box.delete(meal.dishName);
    debugPrint('Meal deleted successfully');
    debugPrint(box.length.toString());
  }

  void removeAllMeals(Meal meal) async {
    var box = Hive.isBoxOpen('myFavMeals')
        ? Hive.box<Meal>('myFavMeals')
        : await Hive.openBox<Meal>('myFavMeals');
    debugPrint('All meals deleted successfully');
    debugPrint(box.length.toString());
  }
}
