import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/features/home/domain/add_meal_repository.dart';

class AddMealRepositoryImpl implements AddMealRepository {
  final FirebaseFirestore fireStore;

  AddMealRepositoryImpl(this.fireStore);

  @override
  Future<List<Meal>> getMeals(String userId) async {
    try {
      final snapshot = await fireStore.collection('users').doc(userId).get();
      final data = snapshot.data();
      if (data != null && data['meals'] != null) {
        return (data['meals'] as List<dynamic>)
            .map((meal) => Meal.fromJson(meal))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Error fetching meals for user $userId: $e');
    }
  }

  @override
  Future<void> addMeal(String userId, Meal meal) async {
    try {
      final userRef = fireStore.collection('users').doc(userId);
      final userSnapshot = await userRef.get();

      if (userSnapshot.exists) {
        final data = userSnapshot.data() as Map<String, dynamic>;
        final meals = (data['meals'] as List<dynamic>? ?? []);
        meals.add(meal.toJson());
        await userRef.update({'meals': meals});
      } else {
        throw Exception('User not found for userId: $userId');
      }
    } catch (e) {
      throw Exception('Error adding meal for user $userId: $e');
    }
  }

  @override
  Future<void> deleteMeal(String userId, String mealId) async {
    try {
      final userRef = fireStore.collection('users').doc(userId);
      final userSnapshot = await userRef.get();

      if (userSnapshot.exists) {
        final data = userSnapshot.data() as Map<String, dynamic>;
        final meals = (data['meals'] as List<dynamic>? ?? []);
        final updatedMeals = meals.where((meal) => Meal.fromJson(meal).id != mealId).toList();
        await userRef.update({'meals': updatedMeals});
      } else {
        throw Exception('User not found for userId: $userId');
      }
    } catch (e) {
      throw Exception('Error deleting meal for user $userId: $e');
    }
  }
}
