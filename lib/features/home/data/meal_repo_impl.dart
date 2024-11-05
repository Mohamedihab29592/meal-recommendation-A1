import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import '../domain/repo/meal_repo.dart';
import 'data_source.dart';
import 'local_data.dart';

class MealRepositoryImpl implements MealRepository {
  final FirebaseService firebaseService;
  final LocalData localData;

  MealRepositoryImpl(this.firebaseService, this.localData);

  @override
  Future<List<Meal>> fetchMeals() async {
    return await firebaseService.fetchMeals();
  }

  @override
  void addMealToFavorites(Meal meal) {
    localData.addMealToFav(meal);
  }

  @override
  void removeFavoriteMeal(Meal meal) {
    localData.removeFavMeal(meal);
  }

  @override
  void removeAllMeals() {
    localData.removeAllMeals();
  }

  @override
  Stream<List<Meal>> listenToMeals() {
    return FirebaseFirestore.instance
        .collection('meals')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Meal.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Future<void> updateIsFavInFireStore(String dishName, bool isFav) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('meals')
          .where('dish_name', isEqualTo: dishName)
          .get();
      if (snapshot.docs.isNotEmpty) {
        String docId = snapshot.docs.first.id;

        await FirebaseFirestore.instance.collection('meals').doc(docId).update({
          'is_favourite': !isFav,
        });
        print("is_favourite updated successfully for $dishName");
      } else {
        print("No document found with the dish_name $dishName");
      }
    } catch (e) {
      print("Failed to update is_favourite: $e");
    }
  }
}
