import 'package:hive/hive.dart';
import 'package:meal_recommendations/core/models/meal.dart';

class FavoriteRepository {
  final Box<Meal> favoriteBox;

  FavoriteRepository(this.favoriteBox);

  List<Meal> fetchFavorites() {
    return favoriteBox.values.toList();
  }

  Future<void> removeFavorite(Meal meal) async {
    await favoriteBox.delete(meal.dishName);
  }
}
