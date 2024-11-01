import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_recommendations/features/favourite/data/models/meal.dart';

class MealRemoteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveFavoriteToFirebase(FavMealModel meal, String userId) async {
    await _firestore
        .collection('users/$userId/favorites')
        .doc(meal.id.toString())
        .set(meal.toFirestore());
  }

  Future<void> removeFavoriteFromFirebase(int id, String userId) async {
    await _firestore
        .collection('users/$userId/favorites')
        .doc(id.toString())
        .delete();
  }

  Future<List<FavMealModel>> getFavoritesFromFirebase(String userId) async {
    final snapshot =
    await _firestore.collection('users/$userId/favorites').get();
    return snapshot.docs.map((doc) => FavMealModel.fromFirestore(doc)).toList();
  }
}
