import 'package:hive/hive.dart';
import 'package:meal_recommendations/core/models/meal.dart';

class LocalData {
  var box = Hive.box('myFavMeals');
  void addMealToFav(Meal meal) {
    box.add(meal);
    print('Meal added to favorites');
    print(box.length);
  }

  void removeFavMeal(Meal meal) {
    box.delete(meal);
    print('Meal deleted successfully');
    print(box.length);
  }

  void removeAllMeals(Meal meal) {
    box.clear();
    print('All meals deleted successfully');
    print(box.length);
  }
}