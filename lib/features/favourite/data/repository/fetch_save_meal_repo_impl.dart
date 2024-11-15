
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:meal_recommendations/core/firebase/firebase_error_model.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/core/utils/strings.dart';
import 'package:meal_recommendations/features/favourite/domain/repositories/fetch_save_fav_repository.dart';

class MealRepositoryImpl implements FetchAndSaveFavMealsRepository {
  final FirebaseFirestore fireStore;

  MealRepositoryImpl(this.fireStore);

  @override
  Future<List<Meal>> fetchAndSaveFavMeals() async {
    try {
      QuerySnapshot snapshot = await fireStore
          .collection(AppStrings.mealsCollection)
          .where(AppStrings.isFavorite, isEqualTo: true)
          .get();

      final favMeals = snapshot.docs.map((doc) {
        return Meal.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      final box = Hive.isBoxOpen(AppStrings.faveLocalHiveId)
          ? Hive.box<Meal>(AppStrings.faveLocalHiveId)
          : await Hive.openBox<Meal>(AppStrings.faveLocalHiveId);
      for (var meal in favMeals) {
        await box.put(meal.dishName, meal);
      }
      return favMeals;
    } catch (e) {
      throw const FirebaseErrorModel(error: AppStrings.errorFetching);
    }
  }
}
