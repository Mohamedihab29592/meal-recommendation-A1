import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/core/models/user.dart';

class FirebaseUserService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<User?> fetchUser(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await _fireStore.collection('users').doc(userId).get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final meals = (data['meals'] as List<dynamic>?)
                ?.map((meal) => Meal.fromJson(meal))
                .toList() ??
            [];

        return User(
          userId: snapshot.id,
          name: data['name'],
          email: data['email'],
          meals: meals,
        );
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching user: $e');
      return null;
    }
  }

  Future<void> updateUserMeals(String userId, List<Meal> meals) async {
    try {
      await _fireStore.collection('users').doc(userId).update({
        'meals': meals.map((meal) => meal.toJson()).toList(),
      });
    } catch (e) {
      debugPrint('Error updating meals: $e');
    }
  }
}
