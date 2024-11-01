import 'package:hive/hive.dart';
import 'package:meal_recommendations/features/favourite/data/models/meal.dart';

class MealLocalRepository {
  static const String boxName = 'favorites';
  late Box<FavMealModel> _mealBox;

  MealLocalRepository() {
    _openBox();
  }

  Future<void> _openBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      _mealBox = await Hive.openBox<FavMealModel>(boxName);
    } else {
      _mealBox = Hive.box<FavMealModel>(boxName);
    }
  }

  Future<void> saveFavorite(FavMealModel meal) async {
    try {
      await _mealBox.put(meal.id, meal);
    } catch (e) {
      print('Error saving favorite: $e');
    }
  }

  Future<void> removeFavorite(int id) async {
    try {
      await _mealBox.delete(id);
    } catch (e) {
      print('Error removing favorite: $e');
    }
  }

  List<FavMealModel> getFavorites() {
    return _mealBox.values.toList();
  }
}
