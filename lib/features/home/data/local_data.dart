import 'package:hive/hive.dart';
import 'package:meal_recommendations/core/models/meal.dart';

class LocalData {
  late Box<Meal> box;
  LocalData() {
    _initializeBox();
  }
  void addMealToFav(Meal meal) {
    box.put(meal.name, meal);
    print('Meal added to favorites');
    print(box.length);
  }

  Future<void> _initializeBox() async {
    if (!Hive.isBoxOpen('myFavMeals')) {
      box = await Hive.openBox<Meal>('myFavMeals');
    } else {
      box = Hive.box<Meal>('myFavMeals');
    }
  }

  Future<void> removeFavMeal(Meal meal) async {
    if (box.containsKey(meal.name)) {
      await box.delete(meal.name);
      print('${meal.name} deleted successfully');
    } else {
      print('${meal.name} not found in favorites');
    }
    print('Total favorite meals: ${box.length}');
  }

  void removeAllMeals() {
    box.clear();
    print('All meals deleted successfully');
    print(box.length);
  }
}
